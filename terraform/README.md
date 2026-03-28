## ⚙️ Infrastructure as Code — Terraform

### Overview
The entire Cloud Resume Challenge infrastructure was provisioned using **Terraform**, enabling a repeatable, automated, and production-ready deployment.

Terraform was used to create and manage:
- S3 (private bucket with OAC)
- CloudFront distribution
- API Gateway
- Lambda function
- DynamoDB table
- IAM roles and policies

---

## ⚡ Key Terraform Concepts 

- Resource creation and management  
- `variables.tf` and `terraform.tfvars` usage  
- `outputs.tf` for exposing values  
- `templatefile()` for dynamic policies (e.g., S3 bucket policy)  
- `filebase64sha256()` for Lambda deployment updates  
- Dependency graph (implicit + explicit dependencies)  

---

## ⚙️ Terraform Commands
#### Initialize Terraform
```bash
terraform init
```

#### Preview infrastructure changes
```bash
terraform plan
```

#### Apply changes
```bash
terraform apply
```

#### Destroy infrastructure (cleanup)
```bash
terraform destroy
```

#### Get API Gateway URL (used in frontend)
```bash
terraform output api_url
```

##### You will get:- 
```
api_url = https://abc123.execute-api.us-east-1.amazonaws.com/visitor
```
---



##### Add this inside
```
terraform/main.tf
```
- Place it AFTER API Gateway is created

### What This Does
##### Every time we run:
```
terraform apply
```
##### ✔ Automatically creates/updates:
```
frontend/js/config.js
```
##### ✔ Injects latest API URL
##### ✔ Removes manual copy-paste

---

### ✅ Key Learnings (Core Terraform + AWS)

- Built a complete **end-to-end serverless architecture using Terraform**  
- Implemented **modular Terraform structure** (variables, outputs, tfvars)  
- Managed **resource dependencies and ordering**  
- Secured S3 using **OAC instead of public access**  
- Automated **frontend deployment to S3**  
- Connected **API Gateway → Lambda → DynamoDB**  
- Configured **CORS in API Gateway**  
- Debugged real-world AWS issues (403 errors, CNAME conflicts)  
- Separated **configuration from code** (e.g., `config.js`)  

---

## 🚀 Why Terraform Matters

- Enables **infrastructure automation**
- Ensures **consistency across environments**
- Makes deployments **repeatable and scalable**
- Demonstrates **real DevOps capability (highly valued in interviews)**

---
## 🌐 Frontend Configuration (Dynamic API Integration)
#### Created Config File:- 📁 frontend/js/config.js

```
const API_URL = "PASTE_TERRAFORM_OUTPUT_HERE"
# Make sure to change this whenver we created the new API Gateway
Eg. api_url = https://abc123.execute-api.us-east-1.amazonaws.com/visitor
```

---

## 🔄 How to Update API URL (When Infrastructure Changes)
##### 1. Run
```bash
terraform output api_url
```
##### 2. Copy the new URL
##### 3. Update
```bash
frontend/js/config.js
```
##### 4. Re-deploy:
```bash
terraform apply
```
---

## 💡Key Takeaway

- API endpoint is not hardcoded
- Easily replaceable when infrastructure changes
- Follows real-world environment configuration practice

---

## 🧠 Terraform Learnings

### ❌ What Failed / Issues Faced
- **CloudFront 403 Access Denied**  
  Cause: Bucket policy or OAC misconfiguration  
  Learned: CloudFront requires explicit permission via OAC + bucket policy  

- **Wrong Resource Dependency Order**  
  Tried creating CloudFront before policy  
  Learned: Terraform resolves dependencies, but logical order must be correct  

- **CNAME Conflict Error (Route 53 + CloudFront)**  
  Cause: Same domain attached to old distribution  
  Learned: One domain → one CloudFront distribution  

- **Frontend Still Hitting Old API**  
  Cause: Hardcoded API URL  
  Learned: Never hardcode endpoints (use config separation)  

- **Caching Issue (Changes Not Reflecting)**  
  Cause: CloudFront cache  
  Learned: Use TTL control or invalidation (`/*`)  