#!/bin/bash

# DONT FORGET TO CHANGE THE CONTEXT TO THE KIND CLUSTER NAME YOU WANT TO TAINT
CONTEXT="kind-multi-master"

# add - at the end to untaint (... multi-master-control-plane foo=bar:NoExecute- )
kubectl --context $CONTEXT taint nodes multi-master-control-plane portainer=accept:NoExecute
kubectl --context $CONTEXT taint nodes multi-master-control-plane2 multi-master-control-plane3 portainer=reject:NoSchedule
