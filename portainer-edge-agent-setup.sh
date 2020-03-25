#!/usr/bin/env bash

# Script used to deploy the Portainer Edge agent inside a Kubernetes cluster.

# Requires:
# curl
# kubectl

### COLOR OUTPUT ###

ESeq="\x1b["
RCol="$ESeq"'0m'    # Text Reset

# Regular               Bold                    Underline               High Intensity          BoldHigh Intens         Background              High Intensity Backgrounds
Bla="$ESeq"'0;30m';     BBla="$ESeq"'1;30m';    UBla="$ESeq"'4;30m';    IBla="$ESeq"'0;90m';    BIBla="$ESeq"'1;90m';   On_Bla="$ESeq"'40m';    On_IBla="$ESeq"'0;100m';
Red="$ESeq"'0;31m';     BRed="$ESeq"'1;31m';    URed="$ESeq"'4;31m';    IRed="$ESeq"'0;91m';    BIRed="$ESeq"'1;91m';   On_Red="$ESeq"'41m';    On_IRed="$ESeq"'0;101m';
Gre="$ESeq"'0;32m';     BGre="$ESeq"'1;32m';    UGre="$ESeq"'4;32m';    IGre="$ESeq"'0;92m';    BIGre="$ESeq"'1;92m';   On_Gre="$ESeq"'42m';    On_IGre="$ESeq"'0;102m';
Yel="$ESeq"'0;33m';     BYel="$ESeq"'1;33m';    UYel="$ESeq"'4;33m';    IYel="$ESeq"'0;93m';    BIYel="$ESeq"'1;93m';   On_Yel="$ESeq"'43m';    On_IYel="$ESeq"'0;103m';
Blu="$ESeq"'0;34m';     BBlu="$ESeq"'1;34m';    UBlu="$ESeq"'4;34m';    IBlu="$ESeq"'0;94m';    BIBlu="$ESeq"'1;94m';   On_Blu="$ESeq"'44m';    On_IBlu="$ESeq"'0;104m';
Pur="$ESeq"'0;35m';     BPur="$ESeq"'1;35m';    UPur="$ESeq"'4;35m';    IPur="$ESeq"'0;95m';    BIPur="$ESeq"'1;95m';   On_Pur="$ESeq"'45m';    On_IPur="$ESeq"'0;105m';
Cya="$ESeq"'0;36m';     BCya="$ESeq"'1;36m';    UCya="$ESeq"'4;36m';    ICya="$ESeq"'0;96m';    BICya="$ESeq"'1;96m';   On_Cya="$ESeq"'46m';    On_ICya="$ESeq"'0;106m';
Whi="$ESeq"'0;37m';     BWhi="$ESeq"'1;37m';    UWhi="$ESeq"'4;37m';    IWhi="$ESeq"'0;97m';    BIWhi="$ESeq"'1;97m';   On_Whi="$ESeq"'47m';    On_IWhi="$ESeq"'0;107m';

printSection() {
  echo -e "${BIYel}>>>> ${BIWhi}${1}${RCol}"
}

info() {
  echo -e "${BIWhi}${1}${RCol}"
}

success() {
  echo -e "${BIGre}${1}${RCol}"
}

error() {
  echo -e "${BIRed}${1}${RCol}"
}

errorAndExit() {
  echo -e "${BIRed}${1}${RCol}"
  exit 1
}

### !COLOR OUTPUT ###

main() {
  if [[ $# -ne 2 ]]; then
    error "Not enough arguments"
    error "Usage: ${0} <EDGE_ID> <EDGE_KEY>"
    exit 1
  fi

  [[ "$(command -v curl)" ]] || errorAndExit "Unable to find curl binary. Please ensure curl is installed before running this script."
  [[ "$(command -v kubectl)" ]] || errorAndExit "Unable to find kubectl binary. Please ensure kubectl is installed before running this script."

  info "Downloading agent manifest..."
  curl -L https://downloads.portainer.io/portainer-agent-edge-k8s.yaml -o portainer-agent-edge-k8s.yaml || errorAndExit "Unable to download agent manifest"

  info "Creating agent configuration..."
  kubectl create configmap portainer-agent-edge-id "--from-literal=edge.id=$1" -n portainer

  info "Creating agent secret..."
  kubectl create secret generic portainer-agent-edge-key "--from-literal=edge.key=$2" -n portainer

  info "Deploying agent..."
  kubectl apply -f portainer-agent-edge-k8s.yaml || errorAndExit "Unable to deploy agent manifest"

  success "Portainer Edge agent successfully deployed"
  exit 0
}

main "$@"
