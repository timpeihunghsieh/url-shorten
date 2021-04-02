#!/bin/bash

mkdir ~/.kube
touch ~/.kube/config
cp deployments/jenkins/bazel.kubeconfig ~/.kube/config
cat /var/run/secrets/kubernetes.io/serviceaccount/token | xargs -I @ sed -i "s/\${TOKEN}/@/" ~/.kube/config
echo $KUBERNETES_SERVICE_HOST | xargs -I @ sed -i "s/\${KUBERNETES_SERVICE_HOST}/@/" ~/.kube/config

cluster_ip=`kubectl get svc/registry-docker-registry -o yaml  | grep clusterIP | awk '{print $2}'`
echo $cluster_ip | xargs -I @ sed -i "s/localhost:5000/@:5000/" WORKSPACE