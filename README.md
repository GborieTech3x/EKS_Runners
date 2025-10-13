# 🧩 EKS Runners – Terraform Infrastructure

Infrastructure-as-Code project deploying **self-hosted GitHub Actions runners** on **AWS EKS** using Terraform.  
This repository demonstrates how to build a **modular, observable, and automated CI/CD platform** that can scale dynamically with Karpenter and integrate directly into enterprise pipelines.

---

## 🧠 Overview

This project provisions a complete AWS EKS environment for self-hosted GitHub Actions runners.  
It includes:
- Automated Terraform provisioning for EKS, networking, and IAM.
- Observability with Prometheus, Grafana, and CloudWatch integration.
- Dynamic node provisioning with Karpenter.
- Modular structure designed for reuse across environments.
- Future CI/CD integration via a shared Terraform pipeline template.

Once complete, this repository will represent a **production-ready EKS runner platform** — secure, monitored, and extensible across AWS accounts.

---

## 🏗️ Current Status

✅ Active Development  
Core networking and EKS infrastructure are being built with Terraform using `for_each` constructs.  
Next phase: modularisation, Helm-based add-ons, and CI/CD integration.

---

## 📦 Repository Structure (Planned)


---

## ⚙️ Cluster Configuration

The EKS environment is designed with:
- **Helm-based add-ons** for reproducible configuration.
- **Core Components**
  - VPC CNI, CoreDNS, kube-proxy.
  - Metrics Server for resource visibility.
  - Cluster Autoscaler & Karpenter for scaling.
  - ExternalDNS for automatic DNS record management.
  - Ingress Controller (ALB / NGINX).
- **RBAC & IAM Roles for Service Accounts (IRSA)** for secure AWS access.
- **Node Groups** separated by workload type (system, runners, monitoring).

---

## 🔍 Observability & Monitoring Stack

| Layer | Tool | Purpose |
|-------|------|----------|
| **Metrics & Dashboards** | **Prometheus + Grafana** (via *kube-prometheus-stack* Helm chart) | Real-time visibility into cluster health, node performance, and GitHub runner metrics (CPU, memory, queue times). |
| **Node Autoscaling Metrics** | **Karpenter + CloudWatch Metrics** | Monitor autoscaling efficiency and provisioning latency. |
| **Logs & AWS Integration** | **CloudWatch Agent + Fluent Bit** (via Helm) | Centralised log forwarding for pods and nodes; long-term retention in CloudWatch. |
| **Alerting (Optional)** | **CloudWatch Alarms / Grafana Alerting** | SNS/email notifications for CPU spikes, node failures, or memory pressure. |

Future enhancements:
- **AWS X-Ray** for tracing GitHub Actions workflows.
- **Loki** for lightweight log aggregation.

---

## 🧠 CI/CD & Automation

The Terraform build, validation, and backend bootstrapping pipeline will be developed in a dedicated repository:

**`terraform-cicd-template`**

Features include:
- Backend auto-creation (S3 + DynamoDB)
- Linting (`tflint`) and formatting checks
- Documentation generation (`terraform-docs`)
- Plan / apply automation
- Policy enforcement and backend validation

This repository will consume the shared template as:

```yaml
# uses: Gborietech3x/terraform-cicd-template/.github/workflows/terraform.yml@v1
```

```mermaid
graph TD
    A[GitHub Actions Workflow] -->|Triggers| B[EKS Cluster]
    B --> C[Runner Pods]
    B --> D[Karpenter]
    D --> E[EC2 Node Groups]
    B --> F[Prometheus + Grafana]
    F --> G[CloudWatch + Fluent Bit]
    G --> H[Alerts / Dashboards]
    B --> I[VPC & Networking]
    I --> J[Bastion Host]
    I --> K[Private Subnets]
    K --> L[S3 Backend + DynamoDB Lock]

