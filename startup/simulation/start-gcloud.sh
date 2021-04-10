#!/usr/bin/env bash

PROJECT_ID=elevated-dynamo-310317

$ gcloud services enable container.googleapis.com --project $PROJECT_ID
$ gcloud container clusters create simulation  \
   --machine-type n1-standard-2  \
   --num-nodes 3  \
   --scopes "https://www.googleapis.com/auth/source.read_write,cloud-platform"  \
   --zone us-east1-b \
   --project $PROJECT_ID