#!/bin/bash

APP_SERVICE=$(vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf get services | grep hello | awk '{print \$3}'")

echo "You can access to application from:"
echo "http://$APP_SERVICE:80/"

ssh -L 80:$APP_SERVICE:80 vagrant@127.0.0.1 -i .vagrant/machines/k8s1/virtualbox/private_key -p `vagrant port --guest 22 k8s1`