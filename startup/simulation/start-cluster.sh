#!/usr/bin/env bash

# Prometheus stack
helm install prometheus prometheus-community/kube-prometheus-stack --version "14.0.0"
kubectl apply -f deployments/prometheus-stack/prometheus-ingress.yaml
kubectl apply -f deployments/prometheus-stack/alertmanager-ingress.yaml
kubectl apply -f deployments/prometheus-stack/grafana-ingress.yaml

# ELK
kubectl apply -f https://download.elastic.co/downloads/eck/1.5.0/all-in-one.yaml
sleep 5  # TODO(timhsieh): hack to wait for CRD to be deployed. 
kubectl apply -f deployments/elk-stack/filebeat_autodiscover.yaml
kubectl apply -f deployments/elk-stack/kibana-ingress.yaml

bazel run deployments/url-shorten/simulation:k8-all.apply