## Task — CloudFront Distribution with Cache Invalidation

### Overview
To improve performance and prepare the website for secure delivery, **Amazon CloudFront** was configured in front of the S3 bucket. CloudFront acts as a **Content Delivery Network (CDN)** that caches and distributes the static website globally through edge locations, reducing latency and improving load times.

### Services Used
- **Amazon CloudFront**
- **Amazon S3**

### Implementation

1. **Created a CloudFront Distribution**
   - Origin configured as the **S3 static website endpoint**.
   - Viewer protocol policy set to **Redirect HTTP to HTTPS**.
   - Default root object set to `index.html`.

2. **Configured Cache Behavior**
   - Allowed methods: `GET, HEAD`
   - Compression enabled for faster delivery.
   - Default caching settings used.

3. **Accessing the Website**
   After deployment, CloudFront generated a **distribution domain name**.

Example:
```code
https://dxxxxxxxxxxxx.cloudfront.net
```


This domain now serves the resume website through CloudFront's global edge network.

----

### Cache Invalidation

CloudFront caches files to improve performance. When updates are made to the website (such as changes to HTML, CSS, or JavaScript files), cached content must be invalidated so that users receive the latest version.

An invalidation request was created for the following path:
```
/*
```


This clears all cached objects in the distribution and forces CloudFront to fetch the updated files from the origin (S3).

### Architecture Role
CloudFront sits **in front of the S3 bucket** and acts as the content delivery layer.

Benefits:
- Global CDN performance
- Reduced latency
- HTTPS support
- Better security by hiding direct S3 access in later steps

### Result
The resume website is now served through **CloudFront's global CDN**, improving performance and preparing the architecture for secure access and custom domain integration.

### Screenshot
```
![CloudFront Distribution](./screenshots/cloudfront-distribution.png) 
```