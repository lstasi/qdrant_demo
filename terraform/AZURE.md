# Neural search demo Cloud deployment Azure

## Requirements

- azure-cli 2.60.0
- kubectl 1.29.2
- aws-cli 2.15.21
- istioctl 1.22.0
- terraform 1.7.5
- k9s ( Optional )


Create Kubernetes Cluster

```
terraform init
terraform plan
terraform apply -target module.azure_k8s
```

Update Kubernetes config 
```
> az aks get-credentials --resource-group qdrant-demo --name qdrant-demo --overwrite-existing
```
## Service Mesh Deployment

Install Istio with istioctl

```bash
istioctl install -y
```

## Application Deployment

Install Qdrant DB and Nueral Search

```
kubectl create namespace qdrant-services
kubectl label namespace qdrant-services istio-injection=enabled
helm install qdrant-demo ../charts/qdrant_demo -n qdrant-services
helm install qdrant ../charts/qdrant/ -n qdrant-services --set replicaCount=3
```

## Application access

Get Load Balancer URL
```
> kubectl get svc/istio-ingressgateway -n istio-system
```
```
NAME                   TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                                      AGE
istio-ingressgateway   LoadBalancer   10.100.125.183   34.41.172.168   15021:30173/TCP,80:32022/TCP,443:32477/TCP   2m39s
```
Qdrant-demo URL
```
> export QDRANT_DEMO_URL=\`kubectl get svc/istio-ingressgateway -n istio-system -o jsonpath='{.status.loadBalancer.ingress[0].ip}'\`
```

Check the application accessing QDRANT_DEMO_URL
```
> echo "http://${QDRANT_DEMO_URL}/"
```

## Service Mesh Addons
Deploy Obervability Addons

```
cd ../charts; ./install_addons.sh; cd ../terraform;
```

Access Dashboards

```
kubectl port-forward svc/kiali 20001:20001 -n istio-system
kubectl port-forward svc/prometheus 9090:9090 -n istio-system
kubectl port-forward svc/grafana 3000:3000 -n istio-system
kubectl port-forward svc/jaeger 16686:16686 -n istio-system
```

## Port Foward Access
Access the application with port-forward

```
kubectl port-forward svc/qdrant-demo 8000:80 -n qdrant-services
```

Access qdrant with port-foward
```
kubectl port-forward svc/qdrant 6333:6333 -n qdrant-services
kubectl port-forward svc/qdrant 6334:6334 -n qdrant-services
```

## Init neural index
Access qdrant-demo app to upload data

Shell into pod
```
> kubectl exec --stdin --tty svc/qdrant-demo -n qdrant-services -- /bin/bash
```

Inside the pod or local using port-forward, both 6333 and 6334

```
wget https://storage.googleapis.com/generall-shared-data/startups_demo.json -P data/
python -m qdrant_demo.init_collection_startups
```