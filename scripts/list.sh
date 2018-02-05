#!/bin/bash

echo "List of Applications:"
echo "======================"

vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf get deployments"

echo "List of Services:"
echo "======================"

vagrant ssh k8s0 -c "kubectl --kubeconfig=/home/vagrant/admin.conf get services"
