# Portainer on Kubernetes BETA

This repository contains all the manifests you can use to deploy the Portainer for Kubernetes BETA version.

For any feedback regarding the BETA version, please head to the [portainer for Kubernetes BETA repository](https://github.com/portainer/kubernetes-beta)

These manifests have been tested on:

* Azure AKS
* Digital Ocean
* minikube
* kind

Have any feedback on the deployment of Portainer inside Kubernetes? Please head to the [deployment feedback topic](https://github.com/portainer/kubernetes-beta/issues/1)

# Usage

## Deploy Portainer and access it via an external load balancer

If your cloud provider supports external load balancers, you can use the following command to deploy Portainer:

```
kubectl ... apply -f portainer.yaml
```

This will deploy the Portainer application and create an external load balancer which you'll be able to use to access Portainer on port 9000.

## Deploy Portainer and access it via node port

If you prefer to access Portainer via a specific port on a node of your cluster, use the following command:

```
kubectl ... apply -f portainer-nodeport.yaml
```

This will expose Portainer on the port `30777` inside your cluster. You can change that port inside the manifest if you wish.

# Dev

This setup can be used to deploy Portainer inside a Kubernetes environment for development purposes.

## Minikube

### Requirements

- [minikube](https://minikube.sigs.k8s.io/)

### Usage

1. Start Portainer in development mode via `yarn start`
2. Start minikube: `minikube start --mount --mount-string /path/to/dev/dist/directory:/portainer/app`
3. Deploy or force an update of any existing Portainer app: `kubectl replace --force -f portainer-minikube.yaml`
4. Retrieve minikube IP via: `minikube ip`

Open browser at `<minikube_IP>:9000`

## kind

### Requirements

- [kind](https://kind.sigs.k8s.io/)

### Usage

1. Update the `hostPath` property in the `kind.yaml` file to match the path of th project on your filesystem
2. Create the cluster via `kind create cluster --config kind.yaml`
3. Deploy or force an update of any existing Portainer app: `kubectl replace --force -f portainer-kind.yaml`

Open browser at `localhost:9000`
