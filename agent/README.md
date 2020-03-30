# Agent

The manifests used to deploy the Portainer agent inside a Kubernetes cluster.

To deploy an Edge agent inside your Kubernetes cluster, it is recommended to follow the instructions available inside your Portainer instance.

# Usage

## Deploy the Portainer agent and access it via an external load balancer

If your cloud provider supports external load balancers, you can use the following command to deploy the regular Portainer agent (not Edge):

```
kubectl ... apply -f portainer-agent.yaml
```

This will deploy the Portainer agent and create an external load balancer which you'll be able to use to connect to the agent on port 9001.
