# 🚀 Terraform AWS 3-Tier Architecture Deployment

## 👩‍💻 Author

**Pratiksha Lavand**
MCA | DevOps & Cloud Enthusiast
Savitribai Phule Pune University

---

## 📌 Project Title

**3-Tier Infrastructure Deployment Using Terraform Modules on AWS**

---

## 🧠 Project Overview

This project demonstrates a **production-ready 3-tier architecture** on AWS using **Infrastructure as Code (IaC)** with Terraform. The system is divided into:

* 🌐 Web Tier (Public Subnet)
* ⚙️ Application Tier (Private Subnet)
* 🗄️ Database Tier (RDS in Private Subnet)

The architecture ensures **scalability, security, and modularity** using Terraform modules.

---

## 🏗️ Architecture Diagram

![3-Tier Architecture](img/architecture.png)

> ⚠️ Make sure your screenshot/diagram is placed in `img/architecture.png` in your GitHub repository.

---

## 🧱 Architecture Flow

```
User Request
    │
    ▼
Web Tier (Nginx EC2 - Public Subnet)
    │
    ▼
Application Tier (PHP/Backend EC2 - Private Subnet)
    │
    ▼
Database Tier (Amazon RDS - Private Subnet)
```

---

## ☁️ AWS Components Used

* VPC (Custom Network)
* Public & Private Subnets (2 AZs)
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* EC2 Instances (Web & App Tier)
* Amazon RDS (MySQL/PostgreSQL)

---

## 📦 Terraform Modules Structure

```
project-root/
│
├── modules/
│   ├── vpc/
│   ├── ec2-web/
│   ├── ec2-app/
│   └── rds/
│
├── environments/
│   └── dev/
│
├── main.tf
├── variables.tf
├── outputs.tf
└── provider.tf
```

---

## ⚙️ Automation Tools

* Terraform (Infrastructure provisioning)
* User Data Scripts / Ansible (Configuration automation)

---

## 🌐 Web Tier

* EC2 instance in public subnet
* Nginx installed
* HTML registration form deployed

---

## ⚙️ Application Tier

* EC2 instance in private subnet
* PHP backend (`submit.php`)
* Handles form data and sends to database

---

## 🗄️ Database Tier

* Amazon RDS (MySQL/PostgreSQL)
* Private access only
* Connected via App Tier security group

---

## 🚀 Deployment Steps

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan infrastructure
terraform plan

# Apply infrastructure
terraform apply -auto-approve
```

---

## 📸 Screenshots

### 1. Architecture Diagram

![Architecture Screenshot](img/architecture.png)

### 2. AWS Console Resources (optional)

Add your EC2, VPC, RDS screenshots here

---

## 🔐 Security Highlights

* Private subnets for App & DB tiers
* Security Groups restricting access
* No direct DB exposure to internet

---

## 📈 Key Benefits

* Infrastructure as Code (IaC)
* Modular and reusable design
* Secure multi-tier architecture
* Easy scalability

---

## 📌 GitHub Repository

```
https://github.com/your-username/terraform-aws-3tier-architecture
```

---

## 🎯 Conclusion

This project demonstrates real-world **DevOps practices using Terraform and AWS**, building a scalable and secure 3-tier system suitable for production environments.

---
## 👩‍💻 Author

**Pratiksha Lavand**
MCA | DevOps & Cloud Enthusiast
Savitribai Phule Pune University
