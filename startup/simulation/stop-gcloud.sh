#!/usr/bin/env bash

PROJECT_ID=elevated-dynamo-310317
CLUSTER_NAME=simulation

# Delete k8s cluster
gcloud container clusters delete $CLUSTER_NAME \
    --zone us-east1-b \
    --project $PROJECT_ID

# Delete images
gcloud container images delete gcr.io/$PROJECT_ID/url-shorten-canary
gcloud container images delete gcr.io/$PROJECT_ID/url-shorten-production