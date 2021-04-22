#!/usr/bin/env bash

# Istio Gateway
./deployments/istio/simulation/startup.sh

# Prometheus stack
./deployments/prometheus-stack/startup.sh

# ELK
./deployments/elk-stack/startup.sh

bazel run deployments/url-shorten/simulation:k8-all.apply
