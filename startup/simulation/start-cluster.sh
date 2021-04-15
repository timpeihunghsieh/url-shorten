#!/usr/bin/env bash

# Prometheus stack
helm install prometheus prometheus-community/kube-prometheus-stack --version "14.0.0"

# ELK
kubectl apply -f https://download.elastic.co/downloads/eck/1.5.0/all-in-one.yaml
sleep 5  # TODO(timhsieh): hack to wait for CRD to be deployed. 
kubectl apply -f deployments/elk-stack/filebeat_autodiscover.yaml

bazel run deployments/url-shorten/simulation:k8-all.apply
kubectl apply -f deployments/ingress/internal-services-ingress.yaml
kubectl apply -f deployments/ingress/external-services-ingress.yaml
