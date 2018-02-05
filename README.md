# Simple Development Environment
Here is a simple development environment,

### Setup
Clone Git repository to your environment
```
# git clone git@github.com:grgizem/simplecluster
```
Install vagrant, https://www.vagrantup.com/docs/installation/
```
# apt install vagrant
```
Install virtualbox, https://www.virtualbox.org/wiki/Downloads
```
# apt install virtualbox
```

### Configuration
You can use following environment variables to configure your environment:
```
KUBERNETES_MEMORY: Memory value of kubernetes
KUBERNETES_MASTER_MEMORY: Memory of kubernetes master, this will override KUBERNETES_MEMORY (default: 1280)
KUBERNETES_NODE_MEMORY: Memory of kubernetes nodes, this will override KUBERNETES_MEMORY (default: 2048)
```
Also you can set following environment variables to use on deployments, otherwise it will ask on every deployment,
```
DOCKER_USERNAME: Username that you use to login to https://hub.docker.com
DOCKER_EMAIL: Email address that you use to login to https://hub.docker.com
DOCKER_PASSWORD: Password that you use to login to https://hub.docker.com
```

### Start
Start your development environment up with,
```
# vagrant up
```
After your environment is up, deploy the application easily with following command.
Note that you will need a Docker ID. If you do not have a Docker ID, head over to https://hub.docker.com to create one.
```
# ./scripts/deploy.sh
```

### List Applications and Services
You can list applications and services on cluster,
```
# ./scripts/list.sh
```

### Deployment
You can deploy local code changes to development environment with,
```
# ./scripts/deploy.sh
```

### Accessing Service
You can access to service from your browser after executing,
```
# ./scripts/application.sh
```

### Accessing Logs
You can get logs of the application with,
```
# ./scripts/logs.sh
```

### Clean Up
To clean up all simply run,
```
# vagrant destroy
```

### Additional Resources
* https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
* https://github.com/coreos/flannel

#### Troubleshooting
* If you can not access to application due to DNS problems, you can try other Pod Networking Providers. Check (3/4) on following link for instructions: https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

#### Tests
Tested on
* Ubuntu 17.10
* Vagrant 1.9.1
* Virtualbox 5.1.30