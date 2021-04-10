#!/usr/bin/env bash

# Note! As of April 2021, ELK and Prometheus stack can't be started together
# in Minikube due to lack of resources.
# TODO(timhsieh): configure this so that they can be configured together.

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