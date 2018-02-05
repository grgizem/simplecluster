#!/bin/bash

echo "Starting deployment..."
echo "======================"
DEPLOYMENT_STAMP=$(date +%s)
echo "- Checking previous state:"

DEPLOYMENT_FILE=.application_setup     
if [ -f $DEPLOYMENT_FILE ]; then
  echo "- Deploying new version..."
  if [[ -z "${DOCKER_USERNAME}" ]]; then
    read -p "DOCKER_USERNAME: " DOCKER_USERNAME
  else
    DOCKER_USERNAME="${DOCKER_USERNAME}"
  fi
  if [[ -z "${DOCKER_EMAIL}" ]]; then
    read -p "DOCKER_EMAIL: " DOCKER_EMAIL
  else
    DOCKER_EMAIL="${DOCKER_EMAIL}"
  fi
  if [[ -z "${DOCKER_PASSWORD}" ]]; then
    read -s -p "DOCKER_PASSWORD: " DOCKER_PASSWORD
  else
    DOCKER_PASSWORD="${DOCKER_PASSWORD}"
  fi
  scp -i .vagrant/machines/k8s0/virtualbox/private_key -P `vagrant port --guest 22 k8s0` application/* vagrant@127.0.0.1:/vagrant/application/
  vagrant ssh k8s0 -c "cd /vagrant/application/ && docker build -t application . && docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD && docker tag application $DOCKER_USERNAME/simple-application:$DEPLOYMENT_STAMP && docker push $DOCKER_USERNAME/simple-application:$DEPLOYMENT_STAMP"
  vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf set image deployments/application application=$DOCKER_USERNAME/simple-application:$DEPLOYMENT_STAMP"
else

  # Wait for kubernetes system pods
  echo "Waiting for kubernetes environment:"
  ONLINE_PODS=0
  while [ "$ONLINE_PODS" -lt 5 ]; do
    echo "..."
    sleep 5
    ONLINE_PODS=$(vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf -n kube-system get po -o wide | awk '{print $3}' | grep -v STATUS | grep -c 'Running'")
  done

  echo "Initial deployment starting now..."
  vagrant ssh k8s0 -c "start-canal"

  read -s -p "Please give a password for mysql: " PASSWORD
  echo "! Do not forget to save this password to somewhere safe, just in case."
  echo "=========================="
  echo "- Setting up MySQL..."
  vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf create secret generic mysql-pass --from-literal=password=$PASSWORD"
  vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf create -f /vagrant/kubernetes/mysql.yml"
  echo "MySQL setup completed."
  echo "=========================="
  echo "- Setting up application..."
  if [[ -z "${DOCKER_USERNAME}" ]]; then
    read -p "DOCKER_USERNAME: " DOCKER_USERNAME
  else
    DOCKER_USERNAME="${DOCKER_USERNAME}"
  fi
  if [[ -z "${DOCKER_EMAIL}" ]]; then
    read -p "DOCKER_EMAIL: " DOCKER_EMAIL
  else
    DOCKER_EMAIL="${DOCKER_EMAIL}"
  fi
  if [[ -z "${DOCKER_PASSWORD}" ]]; then
    read -s -p "DOCKER_PASSWORD: " DOCKER_PASSWORD
  else
    DOCKER_PASSWORD="${DOCKER_PASSWORD}"
  fi
  vagrant ssh k8s0 -c "cd /vagrant/application/ && docker build -t application . && docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD && docker tag application $DOCKER_USERNAME/simple-application:$DEPLOYMENT_STAMP && docker push $DOCKER_USERNAME/simple-application:$DEPLOYMENT_STAMP"
  vagrant ssh k8s0 -c "cp /vagrant/kubernetes/application.yml /vagrant/kubernetes/deploy.yml && sed -i -e 's/==DOCKER_USERNAME==/$DOCKER_USERNAME/g' /vagrant/kubernetes/deploy.yml && sed -i -e 's/==DEPLOYMENT_STAMP==/$DEPLOYMENT_STAMP/g' /vagrant/kubernetes/deploy.yml"
  vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf create -f /vagrant/kubernetes/deploy.yml"
  echo "Application setup completed. Please wait for the application to come up online, you can check that with using scripts."

  touch $DEPLOYMENT_FILE
fi
