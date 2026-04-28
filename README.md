# 🚀 3-Tier Infrastructure Deployment Using Terraform Modules

![AWS](https://img.shields.io/badge/Cloud-AWS-orange?logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)
![EC2](https://img.shields.io/badge/Compute-EC2-red)
![RDS](https://img.shields.io/badge/Database-RDS-blue)
![VPC](https://img.shields.io/badge/Networking-VPC-green)
![Nginx](https://img.shields.io/badge/WebServer-Nginx-009639?logo=nginx)
![PHP](https://img.shields.io/badge/Backend-PHP-777BB4?logo=php)
![MySQL](https://img.shields.io/badge/DB-MySQL-4479A1?logo=mysql)
![DevOps](https://img.shields.io/badge/Project-DevOps-success)

---

# 📑 Table of Contents

- [📌 Project Overview](#-project-overview)
- [🧩 Problem Statement / Scenario](#-problem-statement--scenario)
- [🎯 Objectives](#-objectives)
- [🛠️ Tech Stack](#-tech-stack)
- [🏗️ Architecture / Workflow](#️-architecture--workflow)
- [⚙️ Implementation Steps](#️-implementation-steps)
- [🔐 Security / Best Practices Used](#-security--best-practices-used)
- [📸 Screenshots](#-screenshots)
- [📁 Project Structure](#-project-structure)
- [▶️ How to Run / Deploy](#️-how-to-run--deploy)
- [📚 Key Learnings](#-key-learnings)
- [🔮 Future Improvements](#-future-improvements)
- [👩‍💻 Author](#author)
---

# 📌 Project Overview

This project demonstrates a **production-ready 3-Tier Web Application Architecture on AWS** using **Terraform Modules (Infrastructure as Code)**.

The infrastructure is fully automated and modular, enabling organizations to replace manual provisioning with a **repeatable, scalable, and secure deployment process**.

The architecture consists of:
- 🌐 Web Tier (Public Subnet)
- ⚙️ Application Tier (Private Subnet)
- 🗄️ Database Tier (Private Subnet)

---


# 🧩 Problem Statement / Scenario

As a DevOps Intern in an e-commerce company, the infrastructure was being provisioned manually, causing configuration errors and slow deployments.  
To improve automation and consistency, the company adopted **Infrastructure as Code (IaC)** using Terraform.

Using **IAM credentials and AWS CLI**, the task was to design and deploy a **secure 3-tier architecture** by automating the provisioning of the Web, Application, and Database tiers.
---

# 🎯 Objectives

- Automate infrastructure provisioning using Terraform  
- Implement reusable Terraform modules  
- Deploy secure AWS 3-tier architecture  
- Automate server configuration using provisioners  
- Demonstrate real-world DevOps workflow  

---

# 🛠️ Tech Stack

| Category | Tools |
|---|---|
| Cloud Provider | AWS |
| IaC Tool | Terraform |
| Compute | EC2 |
| Database | Amazon RDS (MySQL) |
| Networking | VPC, Subnets, NAT Gateway |
| Web Server | Nginx |
| Backend | PHP |
| Automation | Terraform Provisioners |
| Version Control | Git & GitHub |

---

# 🏗️ Architecture / Workflow

### Step-by-Step Flow

1️⃣ User accesses web application via Internet  
2️⃣ Request reaches **Web Tier EC2 (Public Subnet)**  
3️⃣ Web server hosts **HTML Registration Form**  
4️⃣ Form submits data to **Application Tier EC2 (Private Subnet)**  
5️⃣ PHP backend processes request  
6️⃣ Data stored in **Amazon RDS MySQL (Private Subnet)**  

```
User → Web Tier → App Tier → Database Tier
```

---

# ⚙️ Implementation Steps

### 1️⃣ Networking Setup
- Created custom VPC
- Configured public & private subnets across 2 AZs
- Setup Internet Gateway & NAT Gateway
- Configured route tables & security groups

### 2️⃣ Web Tier Deployment
- Launched EC2 in public subnet
- Installed Nginx using provisioners
- Deployed HTML registration form

### 3️⃣ Application Tier Deployment
- Launched EC2 in private subnet
- Installed PHP & MySQL client
- Created `submit.php` to send data to RDS

### 4️⃣ Database Tier Deployment
- Provisioned Amazon RDS MySQL
- Configured private subnet group
- Restricted access to App Tier only

---

# 🔐 Security / Best Practices Used

- Private subnets for App & Database tiers  
- No public access to RDS  
- Security groups for tier-to-tier communication  
- NAT Gateway for secure outbound internet access  
- Modular Terraform code for reusability  

---

# 📸 Screenshots

Images are stored inside **/screenshot** folder.

### 🏗️ Architecture Diagram
![Architecture](screenshot/AWS%203-tier%20infrastructure%20architecture.png)

### ⚙️ Terraform Apply
![Terraform Apply](screenshot/VS%20Code%20Terraform%20cmd%20used.png)

### 🖥️ EC2 Instances
![EC2 Instances](screenshot/EC2%20Instances%20(Web%20%26%20App%20Servers).png)

### 🗄️ RDS Database
![RDS Database](screenshot/RDS%20MySQL%20Database%20Instance.png)

### 🌐 Web Application – Registration Page
![Registration Page](screenshot/App%20Frontend%20(Registration%20Page).png)

### ✅ Web Application – Success Page
![Success Page](screenshot/App%20Frontend%20(Success%20Page).png)

---

# 📁 Project Structure

```
terraform-aws-3tier-architecture/
│
├── modules/
│ ├── vpc/
│ ├── ec2-web/
│ ├── ec2-app/
│ └── rds/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
└── terraform.tfvars
```

---

# ▶️ How to Run / Deploy

◆ **Clone Repository**
```bash
git clone https://github.com/your-username/terraform-aws-3tier-architecture.git
cd terraform-aws-3tier-architecture
```
◆ **Initialize Terraform**
```bash
terraform init
```

◆ **Validate Configuration**
```bash
terraform validate
```
◆ **Plan Infrastructure**
```bash
terraform plan
```
### Deploy Infrastructure
```bash
terraform apply --auto-approve 
```
◆ **Destroy Infrastructure (Cleanup)**

To avoid AWS charges, destroy all created resources after testing:

```bash
terraform destroy --auto-approve
```

# 📚 Key Learnings
- Real-world Terraform project implementation
- AWS VPC networking & security
- Infrastructure as Code best practices
- Multi-tier architecture design
- Automation using Terraform provisioners

# 🔮 Future Improvements
- Add Load Balancer & Auto Scaling
- Implement CI/CD pipeline
- Add HTTPS with ACM & Route53
- Use Ansible for advanced configuration
---
<a id="author"></a>

# 👩‍💻 Author
**Pratiksha Lavand**  
☁️ Aspiring Cloud & DevOps Engineer  

🔗 GitHub: [github.com/your-username](https://github.com/pratikshalavand98/)  
🔗 LinkedIn: [linkedin.com/in/your-linkedin-id](https://www.linkedin.com/in/pratiksha-lavand/)
