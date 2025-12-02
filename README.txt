===========================================
           TERRAFORM DOCKER & K8S PROJECT
===========================================

Author: Katan Jones
Course: Cloud Computing
Project: Terraform Infrastructure – Docker + Kubernetes
Date: December 2025

===========================================
              PROJECT OVERVIEW
===========================================

This project demonstrates Infrastructure-as-Code using Terraform in two 
different environments:

PART 1 — Local Docker Infrastructure
PART 2 — Kubernetes Cluster using k3d

Both parts use Terraform modules, variables, state, and dependency graphs. 
The goal was to build small but realistic cloud environments that show how 
Terraform manages containers, networks, deployments, and services.

===========================================
        PART 1 — DOCKER TERRAFORM
===========================================

The Docker portion provisions a small “local cloud” made of:

- A frontend container running NGINX
- A backend microservice written in Python (Flask)
- A Postgres database
- A shared Docker network
- A reverse proxy that exposes everything on localhost

Terraform resources used:
- docker_image
- docker_container
- docker_network

Frontend URL:
    http://localhost:8080

Backend URL:
    http://localhost:8081

Verification screenshots taken:
    - curl.exe http://localhost:8081  → “Hello from backend!”
    - curl.exe http://localhost:8080  → “Hello from backend!”
    - docker ps showing all containers running

Docker enhancement included:
    - Custom NGINX reverse proxy config mounted with Terraform volume mapping.


===========================================
      PART 2 — KUBERNETES (k3d) + TERRAFORM
===========================================

The Kubernetes portion uses a lightweight local cluster created with k3d. 
Terraform provisions:

- A namespace (demo)
- A deployment running the backend image
- A LoadBalancer service
- Replicas (scaled to 3)
- Local image import into k3d

k3d cluster created:
    k3d cluster create mycluster

Kubernetes provider used:
    hashicorp/kubernetes

Verification commands/screenshots captured:
    - k3d kubeconfig merge mycluster
    - kubectl config current-context → k3d-mycluster
    - kubectl get nodes → cluster ready
    - kubectl get ns → "demo" namespace exists
    - kubectl get deployment -n demo → backend 3/3 running
    - kubectl get pods -n demo → 3 backend pods running
    - kubectl get svc -n demo → LoadBalancer with port mapping
    - curl.exe http://localhost:8080 → “Hello from backend!”
    - curl.exe http://localhost:8081 → “Hello from backend!”

Kubernetes enhancement included:
    - Horizontal scaling: backend replicas increased to 3.


===========================================
            FOLDER STRUCTURE
===========================================

Part 1: terraform-docker/
    - main.tf
    - variables.tf
    - terraform.tfvars
    - nginx.conf
    - modules/
         backend/
         frontend/
         database/
         network/

Part 2: terraform-k8s/
    - main.tf
    - variables.tf
    - terraform.tfvars
    - modules/
         app/
             deployment.tf
             service.tf
             namespace.tf

===========================================
          HOW TO RUN (DOCKER PART)
===========================================

1. Install Docker Desktop
2. Navigate to terraform-docker/
3. Run:
        terraform init
        terraform apply -auto-approve

4. Test:
        curl.exe http://localhost:8080
        curl.exe http://localhost:8081

5. Destroy:
        terraform destroy -auto-approve


===========================================
         HOW TO RUN (K8S PART)
===========================================

1. Install k3d:
        winget install k3d

2. Create cluster:
        k3d cluster create mycluster

3. Merge kubeconfig:
        k3d kubeconfig merge mycluster

4. Apply Terraform:
        cd terraform-k8s
        terraform init
        terraform apply -auto-approve

5. Verify:
        kubectl get pods -n demo
        kubectl get svc -n demo
        curl.exe http://localhost:8080

6. Destroy:
        terraform destroy -auto-approve
        k3d cluster delete mycluster


===========================================
           REFLECTION PARAGRAPH
===========================================

This project helped me understand Terraform at a deeper level by working 
through real infrastructure instead of examples. The Docker portion taught 
me how Terraform controls individual containers, images, and networks like 
a small cloud. The Kubernetes portion showed how Terraform interacts with 
a full cluster by deploying pods, services, and namespaces. I learned how 
to troubleshoot image pulls, expose services, and manage state files. I 
also got comfortable using modules, variables, and provider plugins. This 
project made Kubernetes and Terraform feel much more understandable, and I 
feel confident deploying containerized apps using infrastructure-as-code.

===========================================
                END OF FILE
===========================================
