#!/usr/bin/env bash

echo "Install istio"
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

# Addons such as Kiali
kubectl apply -f deployments/istio/addons

# Istio Gateway
kubectl apply -f deployments/istio/gateway.yaml
kubectl apply -f deployments/istio/virtual-service.yaml