#!/bin/bash

mkdir ~/.kube
touch ~/.kube/config
cp deployments/jenkins/bazel.kubeconfig ~/.kube/config
cat /var/run/secrets/kubernetes.io/serviceaccount/token | xargs -I @ sed -i "s/\${TOKEN}/@/" ~/.kube/config
echo $KUBERNETES_SERVICE_HOST | xargs -I @ sed -i "s/\${KUBERNETES_SERVICE_HOST}/@/" ~/.kube/config
