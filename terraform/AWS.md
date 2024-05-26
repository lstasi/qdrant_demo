# Neural search demo Cloud deployment AWS

## Requirements

- kubectl 1.29.2
- aws-cli 2.15.21
- istioctl 1.22.0
- terraform 1.7.5
- k9s ( Optional )

### AWS IAM user permsission required

To create an EKS module using Terraform, the AWS user needs the following IAM policies:

>|this permissions are not recommended for a production environment

- AmazonEC2FullAccess: Allows full access to Amazon EC2.
- AmazonRoute53FullAccess: Allows full access to Amazon Route 53.
- AmazonS3FullAccess: Allows full access to Amazon S3.
- IAMFullAccess: Allows full access to IAM.
- AmazonVPCFullAccess: Allows full access to Amazon VPC.
- AWSCloudFormationFullAccess: Allows full access to AWS CloudFormation.
- AmazonEKSFullAccess: Allows full access to Amazon EKS.
- AmazonEKSClusterPolicy: Allows EKS Cluster related operations.
- AmazonEKSServicePolicy: Allows EKS Service related operations.
- CloudWatchLogsFullAccess
- AmazonSSMFullAccess
- AWSKeyManagementServicePowerUser
- Custom Policy (eks:*)

For Congnito add

- AmazonCognitoPowerUser


## EKS Cluster creation

From Terraform folder

```bash
terraform init
terraform plan
```

Create EKS Cluster

> terraform apply

Run Export from output

> export KUBERNETES_MASTER=qdrant-demo

Update Kube Config

> aws eks update-kubeconfig --region us-east-1 --name $KUBERNETES_MASTER

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
> kubectl get svc/istio-ingressgateway -n istio-system
```
NAME                   TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)                                      AGE
istio-ingressgateway   LoadBalancer   10.100.125.183   ab03c3577b4264a8bb1c88097492f7af-1071150399.us-east-1.elb.amazonaws.com   15021:30173/TCP,80:32022/TCP,443:32477/TCP   2m39s
```
Qdrant-demo URL
> export QDRANT_DEMO_URL=\`kubectl get svc/istio-ingressgateway -n istio-system -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'\`

Check the application accessing QDRANT_DEMO_URL
> echo "http://${QDRANT_DEMO_URL}/"


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
> kubectl exec --stdin --tty svc/qdrant-demo -n qdrant-services -- /bin/bash

Inside the pod or local using port-forward, both 6333 and 6334

```
wget https://storage.googleapis.com/generall-shared-data/startups_demo.json -P data/
python -m qdrant-demo.init_collection_startups
```

## Setup Authentication with JWT

Deploy Cognito

```
cd aws_cognito
terraform init
terraform plan
terraform apply
```

### Export Qdrant Ports

```
istioctl install -y -f ../charts/istio_extra/istio_extra_ports.yml
```

Deploy Request Authentication
```
kubectl apply -f ../charts/istio_extra/request_auth.yml
```

Check using Authorization header with id_token

```
curl -i http://a8679f72056d24ca9b62f22bedb95216-1029495632.us-east-1.elb.amazonaws.com:6333/ \
    -H "Authorization: Bearer eyJraWQiOiJDeVZRRUdyeDM3WjYzZDg3S3hVXC82UFFPUGo3dkEwNGdHNFwvMDZXUnB6Z289IiwiYWxnIjoiUlMyNTYifQ.eyJhdF9oYXNoIjoiRmNUelJhbFl3MUw5bHJpdjQ0bVpDdyIsInN1YiI6ImQ0NzhkNDc4LTMwZDEtNzAxMi03MTRhLTU3NzUzZmY5OGM4YyIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtZWFzdC0xLmFtYXpvbmF3cy5jb21cL3VzLWVhc3QtMV9rbFNmbEZnb2kiLCJjb2duaXRvOnVzZXJuYW1lIjoiZDQ3OGQ0NzgtMzBkMS03MDEyLTcxNGEtNTc3NTNmZjk4YzhjIiwiYXVkIjoiMWZ2NTZxZmMyMXBmbTBsb3VhMDFkYjZwcjciLCJldmVudF9pZCI6ImNmZDIxYWVmLTc1NGEtNGE0YS1hZjI4LWFlNDI5NTI3YmFjMiIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNzE2NjgwNTc0LCJleHAiOjE3MTY2ODQxNzQsImlhdCI6MTcxNjY4MDU3NCwianRpIjoiNWFjNTdlODktN2Y2My00ZDQ5LTljYTAtNTBmYjE3ODllNWM0IiwiZW1haWwiOiJsZWFuZHJvLnN0YXNpQGdtYWlsLmNvbSJ9.fvBrlJdQPNX5SxmOXgWC8RErXq-zlADRFO_GzydxvwEdGgMBkPN4Zsq44czWK3KflJaO8o7zOpYaXDJjknhZWEgTzsTR2kUVes7NU2YIUCr66iJ53-evGYiGhF1Kyu3JjPErMeRnfrkdNf-EtDP5c6udUaktYkxft_2tG9O-f5NQ66L7m0tXVt0KjeRfDZyqmpFMJTAGmAKUxAwdjJRSe_7K_LU92Rts7at85EfVBebZ4178PZQcNFoL1rRifkVcH5RPNq_Zdr_l3QJOvI67UrTQjxox6zW6l2BYwsS72X11WBtoEDcusK37qBxO4OXUOt92A5xI4zJ4KAo1zM8B0Q"