#!/bin/bash

CONFIGS_PATH="./configs"

create() {
  kind create cluster --config=$CONFIGS_PATH/$1/kind.yaml --name $1
}

deploy() {
  kubectl --context kind-$1 replace --force -f $CONFIGS_PATH/$1/portainer.yaml
}

delete() {
  kind delete clusters $1
}

redeploy() {
  deploy $1
}

recreate() {
  delete $1
  create $1
}

usage() {
  echo "Usage: ./setup.sh ACTION CONFIG"
  echo ""
  echo "   with: ACTION in [create|recreate|deploy|redeploy|delete]"
  echo "         CONFIG the name of a folder in ./configs/"
  echo ""
  echo "         folder files: kind.yaml (describing cluster)"
  echo "                       portainer.yaml (describing portainer deployment)"
}

case $1 in
create | recreate | deploy | redeploy | delete)
  if [[ $# == 2 ]]; then
    $1 $2
  else
    usage
  fi
  ;;
help | usage | *)
  usage
  ;;
esac
