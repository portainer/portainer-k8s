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

This setup can be used to deploy Portainer inside a Kubernetes environment for development purposes.

### Requirements

- [minikube](https://minikube.sigs.k8s.io/)

### Usage

1. Start Portainer in development mode via `yarn start`
2. `minikube start --mount --mount-string /path/to/dev/dist/directory:/portainer/app`
3. `kubectl replace --force -f dev.yaml`
4. Retrieve minikube IP via: `minikube ip`

Open browser at `<minikube_IP>:9000`
