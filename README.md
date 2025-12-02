TerraFormProject
CS 454 – Infrastructure as Code Project

This project contains two parts:
1. Terraform + Docker local infrastructure
2. Terraform + Kubernetes (k3d) deployment

Each section contains its own code, modules, variables, and test examples.

================================================================================
PART 1 — Terraform Docker Project
================================================================================
Goal:
Provision a small 3-service local cloud using Docker, fully managed by Terraform.

Services deployed:
• Frontend – Nginx (port 8080)
• Backend – Python microservice (port 8081)
• Database – Postgres
• All services connected via a custom Terraform Docker network

How to run:
cd terraform-docker
terraform init
terraform apply -auto-approve

Test with curl:
curl.exe http://localhost:8080
curl.exe http://localhost:8081

Expected output:
Hello from backend!

Enhancement added:
• Custom Nginx reverse-proxy config mounted into container

================================================================================
PART 2 — Terraform Kubernetes Project (k3d)
================================================================================
Goal:
Deploy the backend microservice into a real Kubernetes cluster using Terraform.

Cluster setup:
k3d cluster create mycluster
k3d kubeconfig merge mycluster
kubectl config current-context
kubectl get nodes

Terraform deploy:
cd terraform-k8s
terraform init
terraform apply -auto-approve

K8s resources created:
• Namespace: demo
• Deployment: backend (with 3 replicas)
• Service: LoadBalancer exposing the backend

Test the service:
kubectl get svc -n demo
curl.exe http://localhost:8080
curl.exe http://localhost:8081

Expected output:
Hello from backend!

Enhancement added:
• Deployment scaled to 3 replicas

================================================================================
Screenshots
================================================================================

Docker Output
-------------
![Docker Backend](./Screenshots/backend.png)
![Docker Frontend](./Screenshots/frontend.png)

Kubernetes Setup
----------------
![Kubeconfig](./Screenshots/kubeconfig.png)
![Kubectl Nodes](./Screenshots/kubectl.png)
![K3D Cluster Works](./Screenshots/KWorks.png)

Kubernetes Resources
--------------------
![Namespaces](./Screenshots/namespace.png)
![Pods](./Screenshots/Pods.png)
![Service LoadBalancer](./Screenshots/LoadBalanceService.png)
![Deployment Ready](./Screenshots/VerifyDeployment.png)

================================================================================
Reflection
================================================================================
This project helped me learn:
• How Terraform manages Docker resources using modules  
• How to work with Docker networks, images, and containers  
• How to build and import custom images  
• How to set up a Kubernetes cluster with k3d  
• How Terraform applies declarative infrastructure to Kubernetes  
• How to debug container pull issues, networking, and module errors

================================================================================
