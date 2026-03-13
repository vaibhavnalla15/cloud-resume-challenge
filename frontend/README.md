## Task 1 — Frontend Implementation

### Overview

The first step of the Cloud Resume Challenge was to build the **frontend of the resume website**.  
This static website displays my resume and serves as the user-facing component of the project.

The frontend is built using **HTML, CSS, and JavaScript**, along with additional vendor libraries for styling and layout.

---

<h3 align="left">Tech Stack:</h3>
<p align="left">
  <a href="https://www.w3.org/html/" target="_blank" rel="noreferrer">
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/html5/html5-original-wordmark.svg" alt="html5" width="45" height="45"/>
  </a>
  &nbsp;
  <a href="https://www.w3schools.com/css/" target="_blank" rel="noreferrer">
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/css3/css3-original-wordmark.svg" alt="css3" width="45" height="45"/>
  </a>
  &nbsp;
  <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript" target="_blank" rel="noreferrer">
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/javascript/javascript-original.svg" alt="javascript" width="40" height="40"/>
  </a>
  &nbsp;
  <a href="https://git-scm.com/" target="_blank" rel="noreferrer">
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/git/git-original.svg" alt="git" width="40" height="40"/>
  </a>
  &nbsp;
  <a href="https://github.com/" target="_blank" rel="noreferrer">
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/github/github-original.svg" alt="github" width="40" height="40"/>
  </a>
  &nbsp;
  <a href="https://shorturl.at/vmjj6" target="_blank" rel="noreferrer">
    <img src="https://icon.icepanel.io/AWS/svg/Storage/Simple-Storage-Service.svg" alt="github" width="40" height="40"/>
  </a>
</p>


---

### Implementation

- Created the main index.html file containing the resume layout.
- Added a CSS stylesheet to handle visual design and responsiveness.
- Added JavaScript for interactive elements and future integration with backend services.
- Included vendor libraries (such as Bootstrap and icon libraries) to improve layout and UI design.
- Organized files into a clean directory structure for maintainability.

### Key Features

- Fully static resume website
- Responsive layout
- Clean separation of HTML, CSS, and JavaScript
- Ready for deployment to a static hosting service (Amazon S3)

### Architecture Role

This frontend serves as the presentation layer of the Cloud Resume Challenge architecture.
Users access this webpage via a browser, which will later be hosted using Amazon S3 and CloudFront.

##### Future steps will integrate the frontend with backend services such as:

- AWS Lambda
- Amazon DynamoDB
- API Gateway

--- 

## Task 2 — Hosting the Resume Website on Amazon S3  


### Overview
After building the frontend, the next step was to **host the static resume website using Amazon S3**.  
Amazon S3 provides highly durable and scalable object storage, and it can be configured to serve **static websites directly to users**.

In this step, the frontend files were uploaded to an S3 bucket and static website hosting was enabled so the resume could be accessed through a public URL.

### Services Used
- **Amazon S3** – Static website hosting 
- **AWS Management Console** – Resource configuration

### Implementation

1. **Created an S3 Bucket**
   - Bucket name chosen to match the project (e.g., `cloud-resume-<name>`).
   - Region selected during creation. (us-east-1)
   - Block public access was **temporarily disabled to allow public read access for testing the static website endpoint**. In later steps, public access will be **blocked again and access will be provided securely through CloudFront**.  
<br>

2. **Uploaded Frontend Files**
   - Uploaded the following files and folders:
     - `index.html`
     - `css/`
     - `js/`
     - `vendor/`
     - `assets/`
<br>

3. **Enabled Static Website Hosting**
   - Opened **S3 → Bucket → Properties**
   - Enabled **Static website hosting**
   - Configured:
     - **Index document:** `index.html`
<br>

4. **Configured Bucket Policy**
   A bucket policy was added to allow public read access to the website files.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadAccess",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME/*"
    }
  ]
}
```
5. **Accessing the Website**
    After enabling static website hosting, S3 provided a website endpoint URL which allows the resume site to be accessed from a browser.

```code
http://YOUR_BUCKET_NAME.s3-website-REGION.amazonaws.com
```

--- 

### Architecture Role

Amazon S3 acts as the static hosting layer for the Cloud Resume Challenge architecture.
It stores the frontend assets and serves them to users when they access the website.

In later steps, this S3-hosted site will be integrated with:

- CloudFront for global content delivery
- HTTPS support
- Custom domain configuration using Route 53

--- 
### Result

The resume website is now publicly accessible through an S3 static website endpoint, serving HTML, CSS, JavaScript, and assets directly from Amazon S3.

[🧷 MyResume](./Resume.pdf)

---
