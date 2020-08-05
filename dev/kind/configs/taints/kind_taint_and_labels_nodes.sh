#!/bin/bash

# DONT FORGET TO CHANGE THE CONTEXT TO THE KIND CLUSTER NAME YOU WANT TO TAINT
CONTEXT="kind-taints"

# add - at the end to untaint (... kind-worker foo=bar:NoExecute- )
kubectl --context $CONTEXT taint nodes kind-worker foo=bar:NoExecute
kubectl --context $CONTEXT taint nodes kind-worker2 hello-world:NoExecute

# replace =<value> by - to unlabel (... kind-worker foo- )
kubectl --context $CONTEXT label nodes kind-worker foo=bar
kubectl --context $CONTEXT label nodes kind-worker2 hello=world
