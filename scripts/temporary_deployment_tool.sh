#!/usr/bin/env bash

echo "current version coming from upstream is VERSION=$VERSION"
if [[ -f ./kubectl ]]
then
    echo "kubectl already downloaded, moving on ..."
else
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.3.0/bin/linux/amd64/kubectl"
fi
chmod 755 ./kubectl
#sed 's|${.*pt-income-version.*}|${VERSION}|g' k8resources/pttg-family-migration-ui-rc.yaml
sed -i 's|${.*pt-income-version.*}|'"${VERSION}"'|g' k8resources/pttg-family-migration-ui-rc.yaml
./kubectl -s https://kube-dev.dsp.notprod.homeoffice.gov.uk --insecure-skip-tls-verify=true --namespace=pt-i-dev --token=0225CE5B-C9C8-4F3B-BE49-3217B65B41B8  get rc/pttg-income-proving-ui 2>&1 |grep -q "not found"
if [[ $? -eq 1 ]];
then
    ./kubectl -s https://kube-dev.dsp.notprod.homeoffice.gov.uk --insecure-skip-tls-verify=true --namespace=pt-i-dev --token=0225CE5B-C9C8-4F3B-BE49-3217B65B41B8 delete rc/pttg-income-proving-ui
else
    echo "pttg-income-proving-ui RC doesn't exist, moving on ..."
fi
./kubectl -s https://kube-dev.dsp.notprod.homeoffice.gov.uk --insecure-skip-tls-verify=true --namespace=pt-i-dev --token=0225CE5B-C9C8-4F3B-BE49-3217B65B41B8 create -f k8resources/pttg-family-migration-ui-rc.yaml
