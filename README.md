# portainer-k8s

Experimental deployment of Portainer inside a Kubernetes cluster.

Tested on:

* Azure AKS
* Digital Ocean

## Usage

```
kubectl ... apply -f manifest.yaml
```

## Dev

#### Requirements
- minikube

#### Usage
1. in dev directory `yarn start`
2. `minikube start --mount --mount-string /path/to/dev/dist/directory:/portainer/app`
3. `kubectl replace --force -f dev.yaml`
4. `minikube ip` (returns minikube IP)

Open browser at `<minikube_IP>:9000`
