#!/usr/bin/env bash

set -o pipefail -e +x

set_kubeconfig() {
  set +x
  cluster="${1}"
  apiserver="${2}"
  admin_password=CHANGEME

  cluster_name="cfcr-ha/${cluster}"
  user_name="${cluster_name}/cfcr-ha-admin"
  context_name="${cluster_name}"

  kubectl config set-cluster "${cluster_name}" --server="${apiserver}" --certificate-authority=./ca-cert --embed-certs=true
  kubectl config set-credentials "${user_name}" --token="${admin_password}"
  kubectl config set-context "${context_name}" --cluster="${cluster_name}" --user="${user_name}"
  kubectl config use-context "${context_name}"

  echo "Created new kubectl context ${context_name}"
  echo "Try running the following command:"
  echo "  kubectl get pods --namespace=kube-system"
}

[[ "$0" == "${BASH_SOURCE[0]}" ]] && set_kubeconfig "$@"

