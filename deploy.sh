#!/usr/bin/env bash
export KUBE_NAMESPACE=${KUBE_NAMESPACE}
export ENVIRONMENT=${ENVIRONMENT}
export APP=pttg-ip-gt-ui
export KUBE_SERVER=${KUBE_SERVER_DEV}
export KUBE_TOKEN=${KUBE_TOKEN}

cd kd
kd --insecure-skip-tls-verify --retries=20 \
   --file ${ENVIRONMENT}/pttg-ip-gt-ui-deployment.yaml \
   --file ${ENVIRONMENT}/pttg-ip-gt-ui-ingress.yaml \
   --file ${ENVIRONMENT}/pttg-ip-gt-ui-svc.yaml