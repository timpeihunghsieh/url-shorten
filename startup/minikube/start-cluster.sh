#!/usr/bin/env bash

# Note! As of April 2021, ELK and Prometheus stack can't be started together
# in Minikube due to lack of resources.
# TODO(timhsieh): configure this so that they can be configured together.

# Prometheus stack
./deployments/prometheus-stack/startup.sh

# ELK
#kubectl apply -f https://download.elastic.co/downloads/eck/1.5.0/all-in-one.yaml
#sleep 5  # TODO(timhsieh): hack to wait for CRD to be deployed. 
#kubectl apply -f deployments/elk-stack/filebeat_autodiscover.yaml

# URL shorten
bazel run deployments/url-shorten/minikube:k8-all.apply

# Ingress rules
kubectl apply -f deployments/ingress/internal-services-ingress.yaml
kubectl apply -f deployments/ingress/external-services-ingress.yaml
