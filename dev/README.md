# Development

These manifests are useful to deploy a development version of Portainer inside a local Kubernetes cluster.

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
