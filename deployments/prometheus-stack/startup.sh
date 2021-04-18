#!/usr/bin/env bash

#kubectl label namespace default metrics-monitoring=target
#kubectl namespace create metrics-monitoring -l metrics-monitoring=target
helm install prometheus prometheus-community/kube-prometheus-stack \
  --version "14.0.0" \
  -f deployments/prometheus-stack/values.yaml