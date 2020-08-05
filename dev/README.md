# Development

These manifests are useful to deploy a development version of Portainer inside a local Kubernetes cluster.

## Minikube

### Requirements

- [minikube](https://minikube.sigs.k8s.io/)

### Usage

1. Start Portainer in development mode via `yarn start`
2. Start minikube: `minikube start --mount --mount-string /path/to/dev/dist/directory:/portainer/app`
3. Deploy or force an update of any existing Portainer app: `kubectl replace --force -f minikube/portainer-minikube.yaml`
4. Retrieve minikube IP via: `minikube ip`

Open browser at `<minikube_IP>:9000`

## kind

### Requirements

- [kind](https://kind.sigs.k8s.io/)

### Usage

1. Update the `hostPath` property in all `configs/**/kind.yaml` files to match the path of the project on your filesystem
1. (optional) Update the `hostPort` property in all `configs/**/kind.yaml` files to the port that suits you the best to access portainer instance
2. Create the cluster with `./setup.sh create <ENV>` where `<ENV>` is the name of the subfolder inside `configs` folder
3. Deploy or force an update of any existing Portainer app: `./setup.sh deploy <ENV>`

Open browser at `localhost:<hostPort>` (`hostPort` is defined in `kind.yaml` file)

##### Notes
* Multiple clusters can run at the same time, updating portainer frontend will update all clusters (for backend you need to use step 3 to redeploy on every cluster you want)
* `setup.sh` script provides some commands to help you recreate / redeploy / delete clusters. See them with `./setup help` or `./setup.sh usage`
