#!/bin/bash

source utils.sh

# Cluster Name: the name of the cluster to either spin up or update
# Action: either "create" or "update"

# Reequires that gcloud already be set up with valid credentials

while getopts ":c:a:" OPTION; do
  case $OPTION in
    c) CLUSTER_NAME="$OPTARG"  ;;
    a) ACTION="$OPTARG"        ;;
  esac
done
shift $((OPTIND-1))

validate_val "cluster name" "$CLUSTER_NAME"
validate_val "action" "$ACTION"

if [ "$ACTION" == "create" ]; then
  echo "ACTION WAS CREATE"
  gcloud container clusters create $CLUSTER_NAME --enable-network-policy
elif [ "$ACTION" == "update" ]; then
  echo "ACTION WAS UPDATE"
  gcloud container clusters update $CLUSTER_NAME --update-addons=NetworkPolicy=ENABLED
  gcloud container clusters update $CLUSTER_NAME --enable-network-policy
else
  echo "WTF, ACTION WAS $ACTION"
fi
