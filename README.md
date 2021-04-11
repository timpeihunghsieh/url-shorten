
# URL Shortener Kubernetes Stack
## Overview
This project sets up a simple URL shortener application. The application itself is not interesting. The goal is to set up various DevOps components that are needed to productionize a backend application.

The key components includes:
- **Bazel** as build tool
- **Java Guice** as the Dependency Injection framework.
- **JUnit** as the unit test framework.
- **Mockito** (from Spring) as the mocking framework.
- Prometheus Stack
  -- **Prometheus** as the time series database to store metrics.
  -- **Grafana** as the metrics dashboard.
  -- **Alertmanager** stores and manages alert.
- EFK Stack
  -- **ElasticSearch** to store logs.
  -- **FileBeat** to gather logs.
  -- **Kibana** to query and logs.
 - **Kubernetes** as the container management platform.
 - **GCP** as the cloud provider.
 -  **OpenVPN** as the gateway.

## Word of Caution
Some code are not added to this repository due to personal reason. As a result, Minikube setup would need more work. 

## URL Shorten 
Insert a mapping:
```
http://<cluster-url>/?short_url=<short>&long_url=<http://long.com>
```
Using a mapping:
```
http://<cluster-url>/?q=<short>
```
## Setup
### Minikube
Start Minikube on the location machine:
```
./startup/minikube/start-minikube.sh
```
Start the monitoring stacks and the URL Shorten application:
```
./startup/minikube/start-cluster.sh
```
**Note!** The Minikube set up requires a locally run registry. It is not provided in the start up script at the moment. 
**Note!** The default monitoring stack is resource intensive and does not fit on a single Minikube node at this time.

### Simulation Environment
The "Simulation Environment" is a simulation of the production world. The instruction assumes GCP account has a project named "elevated-dynamo-310317"

1. Creates k8s cluster with 3 nodes:
```
./startup/minikube/start-gcloud.sh
```
2. Start the monitoring stack and the URL Shorten application:
```
./startup/minikube/start-gcloud.sh
```
3. Find the ${external_ip} and ${internal_ip} ingress.
```
kubectl get ingress
```
4. Add hosts to /etc/hosts 
```
sudo -- sh -c "echo \"${external_ip}     urlshorten.tim.hsieh\" >> /etc/hosts"
sudo -- sh -c "echo \"${internal_ip}     kibana.tim.hsieh\" >> /etc/hosts"
sudo -- sh -c "echo \"${internal_ip}     grafana.tim.hsieh\" >> /etc/hosts"
```

## Monitoring UIs
**Note!** Need to deploy OpenVPN from GCP Marketplace in order to access monitoring applications. In addition, we also need to open VPN.

### Grafana 
- URL: **grafana.tim.hsieh**
- Username: **admin**
- Password: **prom-operator**

### Kibana  
- URL: **kibana.tim.hsieh**
- User: **elastic**
- Password: (See the following)
```
kubectl get secret elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
```