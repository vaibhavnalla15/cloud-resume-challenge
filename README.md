# Cloud Resume Challenge — AWS

## 📌 Overview

This project demonstrates a **real-world cloud architecture** by building and deploying a personal resume website using AWS services.

It follows a **secure, scalable, and serverless design**, integrating frontend hosting, backend APIs, and infrastructure best practices.

Designed and automated a serverless cloud architecture using **Terraform, integrating CloudFront (OAC-secured S3), API Gateway, Lambda, and DynamoDB, with dynamic frontend-backend integration, CI/CD automation using GitHub Actions, and custom domain via Route 53.**

---

## 🧱 Architecture Diagram

![Architecture](./assets/AWS-Cloud-Resume-Challenge.png)

### 🔥 Architecture Flow

```
User (Browser)
↓
Route 53 (DNS)
↓
CloudFront (CDN + HTTPS)
↓
S3 Bucket (Private - OAC Enabled)
↓
Frontend (HTML, CSS, JS)
↓
API Gateway
↓
Lambda Function
↓
DynamoDB (Visitor Counter)
```

---

## Resume Website

![Resume](./assets/Resume.png)

## 🌐 Live Demo

- ⚠️ Currently disabled to avoid AWS costs.

## 🔁 Reproducibility

This entire infrastructure can be recreated from scratch using:

```bash
terraform apply
```

- This ensures zero manual configuration and full automation.

---

## ⚙️ Tech Stack

| Category    | Services Used               |
| ----------- | --------------------------- |
| Frontend    | HTML, CSS, JavaScript       |
| Hosting     | Amazon S3 (Private)         |
| CDN         | Amazon CloudFront (OAC)     |
| Backend API | API Gateway                 |
| Compute     | AWS Lambda                  |
| Database    | DynamoDB                    |
| DNS         | Route 53                    |
| Domain      | GoDaddy (`betterway.cloud`) |
| IaC         | Terraform                   |
| CI/CD       | GitHub Actions              |

---

## 📁 Project Structure

```text
cloud-resume-challenge/
│
├── assets/
│   ├── Cloud-Resume-Challenge.png
│   └── Resume.png
│
├── backend/
│   ├── API Gateway/
│   │   └── README.md
│   ├── DynamoDB/
│   │   └── README.md
│   └── lambda/
│       ├── function.zip
│       ├── lambda_function.py
│       └── README.md
│
├── cloudfront/
│   └── README.md
│
├── Route53/
│   └── README.md
│
├── frontend/
│   ├── css/
│   ├── img/
│   ├── js/
│   ├── vendor/
│   ├── index.html
│   └── README.md
│
├── Terraform/
│   ├── main.tf
│   ├── output.tf
│   ├── variables.tf
│   ├── provider.tf
│   └── policy.json
│
├── README.md
└── .gitignore
```

---
## 📁 Project Structure

```text
cloud-resume-challenge/
│
├── assets/
│   ├── Cloud-Resume-Challenge.png
│   └── Resume.png
│
├── backend/
│   ├── API Gateway/
│   │   └── README.md 
│   ├── DynamoDB/
│   │   └── README.md 
│   └── lambda/
│       ├── function.zip
│       ├── lambda_function.py
│       └── README.md 
│
├── cloudfront/
│   └── README.md 
│
├── Route53/
│   └── README.md 
│
├── frontend/
│   ├── css/
│   ├── img/
│   ├── js/
│   ├── vendor/
│   ├── index.html
│   └── README.md 
│
├── Terraform/
│   ├── main.tf
│   ├── output.tf
│   ├── variables.tf
│   ├── provider.tf
│   └── policy.json
│
├── README.md 
└── .gitignore
```
---

## 📚 Project Documentation

### 🔹 Frontend

- [Frontend Setup](./frontend/README.md)

### 🔹 Backend

- [API Gateway](./backend/API%20Gateway/README.md)
- [Lambda Function](./backend/lambda/README.md)
- [DynamoDB](./backend/DynamoDB/README.md)

### 🔹 Infrastructure

- [CloudFront + OAC](./cloudfront/README.md)
- [Route 53 Custom Domain](./Route53/README.md)

### 🔹 Terraform

- [Terraform (Infrastructure as Code)](./terraform/README.md)

### 🔹 CI/CD Pipeline

- [CI/CD Pipeline](./cicd/README.md)

---

## 🔐 Security Best Practices Implemented

- S3 bucket is **private (no public access)**
- Access controlled using **CloudFront Origin Access Control (OAC)**
- HTTPS enabled using **ACM SSL certificate**
- IAM roles follow **least privilege principle**

---

## 🚀 Deployment Flow (Step-by-Step)

1. Build frontend (HTML, CSS, JS)
2. Upload to S3 bucket (initial public testing)
3. Configure CloudFront (CDN + HTTPS)
4. Secure S3 using OAC (make private)
5. Create DynamoDB table (visitor counter)
6. Build Lambda function (update counter)
7. Expose API via API Gateway
8. Connect frontend → API
9. Configure Route 53 with custom domain

---

## ⚡ Key Features

- Fully serverless architecture
- Global content delivery using CloudFront
- Secure private S3 access (OAC)
- Dynamic visitor counter using Lambda + DynamoDB
- Custom domain with HTTPS
- Infrastructure fully reproducible using Terraform
- Automated deployment via CI/CD pipeline

---

## 🧠 Lessons Learned / Challenges

- **CloudFront Caching Issue**  
   Updates to the website were not reflecting due to cached content.  
   **Solution:** Used CloudFront invalidation (`/*`) to refresh cached files.
  <br>

- **OAC vs Public S3 Bucket Confusion**  
   Initially used public S3 static hosting, but later migrated to a secure setup.  
   **Learning:** CloudFront with **Origin Access Control (OAC)** is the correct production approach to keep S3 private.
  <br>

- **Route 53 Nameserver Delay**  
   After updating nameservers in GoDaddy, the domain did not resolve immediately.  
   **Learning:** DNS propagation can take time (usually a few minutes to hours).
  <br>

- **S3 Website Endpoint vs S3 Origin Endpoint**  
   Faced issues when switching from static hosting to private bucket.  
   **Learning:** CloudFront must use **S3 origin endpoint (not website endpoint)** when OAC is enabled.
  <br>

- **CORS Issues with API Gateway**  
  Frontend was unable to fetch data initially.  
  **Solution:** Enabled proper CORS configuration in API Gateway.

---

## 💡 Key Learnings

- Real-world AWS architecture design
- Secure static website hosting
- Serverless backend integration
- DNS + CDN + HTTPS workflow

---

## 🎯 Why This Project

- Demonstrates real AWS architecture
- Shows Infrastructure as Code skills
- Implements CI/CD pipeline
- Simulates production environment

---

## 🏁 Conclusion

This project demonstrates the design and implementation of a **production-grade, end-to-end serverless architecture on AWS**, combining frontend delivery, backend processing, infrastructure automation, and deployment pipelines.

It goes beyond basic cloud usage by showcasing:

- **Secure architecture design** using private S3 with CloudFront OAC
- **Scalable serverless backend** with API Gateway, Lambda, and DynamoDB
- **Global content delivery** via CloudFront with HTTPS (ACM)
- **Custom domain integration** using Route 53
- **Infrastructure as Code (Terraform)** for reproducible and automated deployments
- **CI/CD automation (GitHub Actions)** for continuous delivery

The project reflects real-world engineering practices such as:

- Eliminating manual configuration through automation
- Maintaining separation of concerns (frontend, backend, infrastructure)
- Debugging and resolving production-level issues
- Designing systems with security, scalability, and maintainability in mind

This implementation demonstrates readiness for **Cloud / DevOps Engineer roles**, with hands-on experience in building, automating, and managing modern cloud-native systems on AWS.
