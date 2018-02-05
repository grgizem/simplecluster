# Simple Development Environment
Here is a simple development environment,

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
After your environment is up deploy application easily with following command.
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
To clean up all applications and services with cluster,
```
# ./scripts/clean.sh
```
To clean up kubernetes from VM's,
```
# ./scripts/clean.sh --all
```
To clean up all simply run,
```
# vagrant destroy
```

### Additional Resources
* https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
* https://github.com/coreos/flannel

