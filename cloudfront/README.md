## Task — Securing S3 with CloudFront Origin Access Control (OAC)

### Overview
After verifying the website using the public S3 static hosting endpoint, the architecture was improved for better security. The S3 bucket was made **private**, static website hosting was **disabled**, and **CloudFront Origin Access Control (OAC)** was configured so that only CloudFront can access the S3 bucket.

### Services Used
- Amazon S3  
- Amazon CloudFront  

### Implementation

1. **Disabled S3 Public Access**
   - Re-enabled **Block Public Access** on the S3 bucket.
   - Removed public read access from the bucket.

2. **Disabled Static Website Hosting**
   - Static website hosting was turned **off** since CloudFront will now directly access the S3 bucket.

3. **Updated CloudFront Origin**
   - Changed the origin from **S3 website endpoint** to the **S3 bucket endpoint**.
   - Configured **Origin Access Control (OAC)** so CloudFront can securely fetch objects from S3.

4. **Updated Bucket Policy**
   A bucket policy was attached to allow **only the CloudFront distribution** to access the bucket.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME/*",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::ACCOUNT_ID:distribution/DISTRIBUTION_ID"
        }
      }
    }
  ]
}
```

5. **Cache Invalidation**
After modifying the origin configuration, a CloudFront invalidation was created to refresh cached objects.
```code
/*
```
---

### Architecture Role

CloudFront now securely retrieves content from a private S3 bucket using Origin Access Control (OAC). This prevents direct public access to the S3 bucket while still allowing the website to be served through CloudFront.

### Result

- S3 bucket is fully private
- Static website hosting disabled
- CloudFront securely serves content using OAC
- Users access the website only through the CloudFront distribution URL

Example:
```
https://dxxxxxxxxxxxx.cloudfront.net
```