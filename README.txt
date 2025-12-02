CS 454 – Terraform Project
Author: Katan Jones

Project Overview

This project demonstrates Infrastructure-as-Code using Terraform in two environments:

Local Docker Infrastructure

Kubernetes Cluster using k3d

You will see how Terraform provisions Docker containers, builds a local microservice stack, and deploys the same backend into Kubernetes using modules, variables, and declarative configuration.

---------------------------------------------------------
PART 1 — Docker Terraform Project
---------------------------------------------------------
Description

Terraform provisions a small “local cloud” consisting of:

Frontend: Nginx

Backend: Python Flask microservice

Database: PostgreSQL

Custom Docker network

Frontend loads from port 8080.
Backend is reachable through 8081.

Run Terraform
terraform init
terraform apply -auto-approve

Test Endpoints
Frontend
curl.exe http://localhost:8080


Expected output:

Hello from backend!

Backend
curl.exe http://localhost:8081


Expected output:

Hello from backend!

Enhancement (Required)

Added custom Docker network

Exposed multiple components

Backend container built from a custom image (my-backend)

---------------------------------------------------------
PART 2 — Kubernetes Terraform Project (k3d)
---------------------------------------------------------
Description

A lightweight Kubernetes cluster is created using k3d, and Terraform deploys:

Namespace: demo

Deployment: Backend Flask API replicated 3 times

Service: LoadBalancer service to expose the backend

Cluster Setup Commands
Create and Merge k3d Kubeconfig
k3d kubeconfig merge mycluster
kubectl config current-context


Expected:

k3d-mycluster

Verify Cluster Nodes
kubectl get nodes

Apply Terraform
terraform init
terraform apply -auto-approve

Validate Kubernetes Deployment
Check Namespace
kubectl get ns

Check Pods
kubectl get pods -n demo

Check Deployment
kubectl get deployment -n demo

Check Service
kubectl get svc -n demo

Test LoadBalancer
curl.exe http://localhost:8080
curl.exe http://localhost:8081


Both should return:

Hello from backend!

---------------------------------------------------------
Screenshots
---------------------------------------------------------
Docker Success

docker-backend.png — Backend curl success on port 8081

docker-frontend.png — Frontend curl success on port 8080

Kubernetes Setup

kubeconfig.png — k3d kubeconfig merge

kubectl-context.png — Current kubectl context

kubectl-nodes.png — Show cluster node

Kubernetes Workloads

namespace.png — Namespace "demo" created

pods.png — Pods running (3 replicas)

deployment.png — Deployment showing 3/3 available

Service + LoadBalancer

loadbalancer.png — Backend LoadBalancer service

curl-k8s-8080.png — curl → Hello from backend on 8080

curl-k8s-8081.png — curl → Hello from backend on 8081

(Place images inside a /screenshots folder in your repo for organization.)
