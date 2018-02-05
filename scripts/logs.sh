#!/bin/bash

echo "Application Logs:"
echo "======================"

vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf logs deployment/application"
