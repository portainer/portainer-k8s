# Portainer on Kubernetes BETA

This repository contains all the manifests you can use to deploy the Portainer for Kubernetes BETA version.

For any feedback regarding the BETA version, please head to the [portainer for Kubernetes BETA repository](https://github.com/portainer/kubernetes-beta).

These manifests have been tested on:

* Azure AKS
* Digital Ocean
* minikube
* kind

Have any feedback on the deployment of Portainer inside Kubernetes? Please head to the [deployment feedback topic](https://github.com/portainer/kubernetes-beta/issues/1).

Supported platforms:

* Linux amd64
* Linux arm

# Usage

## Deploy Portainer inside your cluster and access it via an external load balancer

If your cloud provider supports external load balancers, you can use the following commands to deploy Portainer:

```
curl -LO https://raw.githubusercontent.com/portainer/portainer-k8s/master/portainer.yaml
kubectl apply -f portainer.yaml
```

This will deploy the Portainer application and create an external load balancer which you'll be able to use to access Portainer on port 9000.

## Deploy Portainer inside your cluster and access it via node port

If you prefer to access Portainer via a specific port on a node of your cluster, use the following commands:

```
curl -LO https://raw.githubusercontent.com/portainer/portainer-k8s/master/portainer-nodeport.yaml
kubectl apply -f portainer-nodeport.yaml
```

This will expose Portainer on the port `30777` inside your cluster (`30776` for Edge tunnel server). You can change these ports inside the manifest if you wish.

## Deploy Portainer using Helm Chart

Refer to the [README](https://github.com/portainer/portainer-k8s/blob/master/deploy/helm/README.md) under the `deploy/helm/portainer` directory for more details.

## Manage a remote Kubernetes cluster

In order to manage a remote Kubernetes cluster, you'll need a Portainer for Kubernetes BETA instance already deployed inside a Kubernetes cluster and connect it to a Portainer agent running inside the remote cluster.

### Deploy the Portainer agent and access it via an external load balancer

If your cloud provider supports external load balancers, you can use the following command to deploy the regular Portainer agent (not Edge):

```
curl -LO https://raw.githubusercontent.com/portainer/portainer-k8s/master/agent/portainer-agent.yaml
kubectl apply -f agent/portainer-agent.yaml
```

This will deploy the Portainer agent and create an external load balancer which you'll be able to use to connect to the agent on port 9001.

### Edge agent

If you wish to deploy the Edge agent inside your Kubernetes cluster, it is recommended to follow the instructions available inside your Portainer instance.

## ARM platform

If you wish to deploy Portainer or the agent inside a Kubernetes cluster running on arm, please use the tag `linux-arm` instead of `linux-amd64`.
