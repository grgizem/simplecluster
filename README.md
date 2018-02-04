# Simple Development Environment
TODO

### Setup
Clone Git repository to your environment
```
# git clone git@github.com:grgizem/simplecluster
```
Install vagrant
```
# apt install vagrant
```
Install virtualbox
```
# apt install virtualbox
```

### Configuration
You can use following environment variables to configure your environment:
```
KUBERNETES_NUM_NODES: Number of nodes that will be launched on kubernetes cluster beside master (default: 1)
KUBERNETES_MEMORY: Memory value of kubernetes
KUBERNETES_MASTER_MEMORY: Memory of kubernetes master, this will override KUBERNETES_MEMORY (default: 1280)
KUBERNETES_NODE_MEMORY: Memory of kubernetes nodes, this will override KUBERNETES_MEMORY (default: 2048)
```

### Start
Start your development environment up with,
```
# vagrant up
```
After your environment is up deploy application easily with,
```
# deploy.sh
```

### List Nodes and Applications
TODO

### Deployment
You can deploy local code changes to development environment with,
```
# deploy.sh
```

### Accessing Service
TODO

### Accessing Logs
TODO

### Clean Up
TODO

### Additional Resources
https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
https://github.com/coreos/flannel

