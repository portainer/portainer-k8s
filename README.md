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

1. `minikube start`
2. in dev directory `yarn start`
3. `minikube mount /path/to/dist/directory:/portainer/app`
4. `kubectl replace --force -f dev.yaml`
5. `minikube ip` (returns minikube IP)

Open browser at `<minikube_IP>:9000`
