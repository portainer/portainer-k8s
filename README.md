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

If your cloud provider supports external load balancers, you can use the following command to deploy Portainer:

```
kubectl ... apply -f portainer.yaml
```

This will deploy the Portainer application and create an external load balancer which you'll be able to use to access Portainer on port 9000.

## Deploy Portainer inside your cluster and access it via node port

If you prefer to access Portainer via a specific port on a node of your cluster, use the following command:

```
kubectl ... apply -f portainer-nodeport.yaml
```

This will expose Portainer on the port `30777` inside your cluster (`30776` for Edge tunnel server). You can change these ports inside the manifest if you wish.

## Deploy Portainer using Helm Chart
### Testing the Chart
Execute the following for testing the chart:

```bash
helm install --dry-run --debug portainer -n portainer deploy/helm/portainer
```

### Installing the Chart
Execute the following for installing the chart:

```bash
helm upgrade -i -n portainer portainer deploy/helm/portainer
## Refer to the output NOTES on how-to access Portainer web
## An example is attached below

NOTES:
1. Get the application URL by running these commands:
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get --namespace portainer svc -w portainer'
  
  export SERVICE_IP=$(kubectl get svc --namespace portainer portainer --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
  echo http://$SERVICE_IP:9000
  http://20.40.176.8:9000
```

### Deleting the Chart
Execute the following for deleting the chart:

```bash
## Delete the Helm Chart
helm delete -n portainer portainer
## Delete the Namespace
kubectl delete namespace portainer
```

### Chart Configuration
The following table lists the configurable parameters of the Portainer chart and their default values. The values file can be found under `deploy/helm/portainer/values.yaml`.

*The parameters will be keep updating.*

| Parameter | Description | Default |
| - | - | - |
| `replicaCount` | Number of Portainer service replicas (ALWAYS set to 1) | `1` |
| `image.repository` | Portainer Docker Hub repository | `portainer/portainer-k8s-beta` |
| `image.tag` | Tag for the Portainer image; `linux-amd64` for Linux and `linux-arm` for ARM | `linux-amd64` |
| `image.pullPolicy` | Portainer image pulling policy | `IfNotPresent` |
| `imagePullSecrets` | If Portainer image requires to be in a private repository | `nil` |
| `serviceAccount.annotations` | Annotations to add to the service account | `null` |
| `serviceAccount.name` | The name of the service account to use | `portainer-sa-clusteradmin` |
| `service.type` | Service Type for the main Portainer Service; ClusterIP, NodePort and LoadBalancer | `LoadBalancer` |
| `service.httpPort` | HTTP port for accessing Portainer Web | `9000` |
| `service.httpNodePort` | Static NodePort for accessing Portainer Web. Specify only if the type is NodePort | `nil` |
| `service.edgePort` | TCP port for accessing Portainer Edge | `8000` |
| `service.edgeNodePort` | Static NodePort for accessing Portainer Edge. Specify only if the type is NodePort | `nil` |
| `ingress.enabled` | Create an ingress for Portainer | `false` |
| `ingress.annotations` | Annotations to add to the ingress. For instane, `kubernetes.io/ingress.class: nginx` | `{}` |
| `ingress.hosts.host` | URL for Portainer Web. For instance, `portainer.example.io` | `nil` |
| `ingress.hosts.path` | Path for the Portainer Web. | `[]` |
| `ingress.tls` | TLS support on ingress. Must create a secret with TLS certificates in advance | `[]` |
| `resources` | Portainer resource requests and limits | `{}` |

## Manage a remote Kubernetes cluster

In order to manage a remote Kubernetes cluster, you'll need a Portainer for Kubernetes BETA instance already deployed inside a Kubernetes cluster and connect it to a Portainer agent running inside the remote cluster.

### Deploy the Portainer agent and access it via an external load balancer

If your cloud provider supports external load balancers, you can use the following command to deploy the regular Portainer agent (not Edge):

```
kubectl ... apply -f agent/portainer-agent.yaml
```

This will deploy the Portainer agent and create an external load balancer which you'll be able to use to connect to the agent on port 9001.

### Edge agent

If you wish to deploy the Edge agent inside your Kubernetes cluster, it is recommended to follow the instructions available inside your Portainer instance.

## ARM platform

If you wish to deploy Portainer or the agent inside a Kubernetes cluster running on arm, please use the tag `linux-arm` instead of `linux-amd64`.
