#!/usr/bin/env bash

kubectl namespace create metrics-monitoring
helm install prometheus prometheus-community/kube-prometheus-stack \
  --version "14.0.0" \
  -f values.yaml