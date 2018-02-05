#!/bin/bash

APP_SERVICE=$(vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf get services | grep hello | awk '{print \$3}'")

echo "You can access to application with ssh tunneling:"
echo "Application IP: $APP_SERVICE"
echo "Vagrant Port: $(vagrant port --guest 22 k8s1)"
echo "Use following command, then access from your local browser:" 
echo "ssh -L 80:<Application IP>:80 vagrant@127.0.0.1 -i .vagrant/machines/k8s1/virtualbox/private_key -p <Vagrant Port>"