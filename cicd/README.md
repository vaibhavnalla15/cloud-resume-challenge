# 🚀 CI/CD Pipeline — Cloud Resume Challenge

## 🧠 One-Liner Summary

Automated end-to-end CI/CD pipeline that provisions AWS infrastructure with Terraform and deploys a serverless application with dynamic configuration and CDN cache management.

---

## ⚙️ Pipeline Overview

- Automated **CI/CD pipeline using GitHub Actions**
- Triggered on push to `test` branch
- Handles:
  - **Infrastructure provisioning (Terraform)**
  - **Application deployment (Frontend to S3)**

---

## 🧱 Infrastructure as Code (Terraform)

- Provisions AWS resources:
  - S3 (frontend hosting)
  - CloudFront (CDN with OAC)
  - API Gateway + Lambda (backend)
  - DynamoDB (visitor counter)

- Uses:
  - **Remote state (S3)**
  - **State locking (DynamoDB)**

- Ensures:
  - **Idempotent deployments**
  - Consistent infrastructure

---

## 🔁 CI Phase (Validation)

- `terraform fmt` → Enforces code formatting  
- `terraform validate` → Validates configuration  
- `terraform plan` → Previews infrastructure changes  

### 🎯 Purpose
- Detect errors early  
- Prevent broken infrastructure deployments  

---

## 🚀 CD Phase (Deployment)

- `terraform apply` → Creates/updates AWS infrastructure  
- Fully automated deployment (no manual steps)

---

## 🔄 Dynamic Configuration Injection

- Extract API Gateway URL dynamically:

```bash
terraform output
```
- Inject into frontend using config file

#### 📄 frontend/js/config.js
```
const API_URL = "PLACEHOLDER";  // We will replace PLACEHOLDER dynamically
```
---

## ⚙️ GitHub Actions Step (Injection)
```
# ✅ Inject into frontend
- name: Inject API URL into config.js
  run: |
    echo "Injecting API URL: $API_URL"
    sed -i "s|PLACEHOLDER|${API_URL}|g" ../frontend/js/config.js
```

#### 🎯 Purpose
- Replaces placeholder with real API Gateway URL
- Avoids hardcoding endpoints
- Enables environment-independent deployments

---

## 🌐 Frontend Deployment
```
aws s3 sync ./frontend s3://<bucket-name> --delete
```

#### ✅ Benefits
- Removes stale files
- Keeps deployment clean
- Ensures consistency

---

## ⚡ CDN Cache Management
- Automates CloudFront cache invalidation
- Ensures latest changes are served immediately
- Prevents stale content issues

---

## 🔐 Security Best Practices
Uses GitHub Secrets for AWS credentials
No hardcoded sensitive data
Proper environment variable handling

---

## 🧠 Key Engineering Concepts Applied
- Infrastructure as Code (IaC)
- Continuous Integration & Continuous Deployment
- Dynamic configuration management
- Remote state management
- Idempotent deployments
- CDN caching strategy

---

## 🛠️ Real-World Problems Solved
- Terraform state corruption & recovery
- Environment variable scoping in CI/CD
- Safe S3 sync without deleting critical files
- CloudFront caching & invalidation issues
- API endpoint injection errors

---

## 🎯 Outcome
- Fully automated deployment pipeline
- Zero manual intervention
- Production-ready cloud architecture