# Deploy Portainer using Helm Chart

Before proceeding, ensure to create a namespace in advance.
For instance:
```bash
kubectl create namespace portainer
```

# Testing the Chart
Execute the following for testing the chart:

```bash
helm install --dry-run --debug portainer -n portainer deploy/helm/portainer
```

# Installing the Chart
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

# Deleting the Chart
Execute the following for deleting the chart:

```bash
## Delete the Helm Chart
helm delete -n portainer portainer
## Delete the Namespace
kubectl delete namespace portainer
```

# Chart Configuration
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
