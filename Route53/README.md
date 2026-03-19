## Task — Custom Domain Setup using Route 53 (GoDaddy Domain)

### Overview
A custom domain **`betterway.cloud`** (purchased from GoDaddy) was integrated with AWS using **Amazon Route 53**.  
This allows the CloudFront-distributed website to be accessed via a **professional domain name instead of the default CloudFront URL**.

### Services Used
- **Amazon Route 53**
- **Amazon CloudFront**
- **GoDaddy (Domain Registrar)**

---

### Step 1 — Purchased Domain from GoDaddy
- Domain: `betterway.cloud`
- Registrar: GoDaddy

---

### Step 2 — Created Hosted Zone in Route 53

1. Navigate to **Route 53 → Hosted Zones**
2. Click **Create Hosted Zone**
3. Enter:
   - Domain name: `betterway.cloud`
   - Type: Public Hosted Zone

4. Route 53 automatically generates:
   - **NS (Name Server) records**
   - **SOA record**

Example:
```
ns-xxxx.awsdns-xx.com
ns-xxxx.awsdns-xx.net
ns-xxxx.awsdns-xx.org
ns-xxxx.awsdns-xx.co.uk

```

---

### Step 3 — Updated Nameservers in GoDaddy

1. Login to GoDaddy
2. Go to **Domain Management → betterway.cloud**
3. Open **DNS / Nameservers settings**
4. Replace default GoDaddy nameservers with Route 53 nameservers

This step connects the domain to AWS.

---

### Step 4 — Configure CloudFront for Custom Domain

1. Go to **CloudFront Distribution**
2. Add **Alternate Domain Name (CNAME)**:- **betterway.cloud**
3. Attach an SSL certificate:
   - Created using **AWS Certificate Manager (ACM)**
   - Region: `us-east-1` (required for CloudFront)
   - Domain: `betterway.cloud`
4. Validate certificate (DNS validation via Route 53)

---

### Step 5 — Create DNS Record in Route 53

1. Go to **Hosted Zone → Create Record**
2. Record type: **A (Alias)**
3. Record name: *(leave blank for root domain)*

4. Enable:
   - **Alias = Yes**
   - Target: CloudFront distribution

Example:
```
Name: betterway.cloud
Type: A (Alias)
Value: dxxxxxxxxxxxx.cloudfront.net

```

---

### Step 6 — (Optional) www Subdomain

To support `www.betterway.cloud`:

- Create another record:
```
Name: www
Type: A (Alias)
Target: CloudFront distribution

```

---

### Architecture Role

Route 53 acts as the **DNS layer** in the architecture:
```
User → Route 53 → CloudFront → S3 (Private via OAC)

```


Responsibilities:
- Maps domain (`betterway.cloud`) → CloudFront
- Handles DNS resolution globally
- Works with ACM for HTTPS

---

### Result

- Website accessible via:

```
https://betterway.cloud 
https://www.betterway.cloud

```
- HTTPS enabled with SSL certificate
- Professional domain replaces CloudFront URL
- Fully integrated with secure architecture (CloudFront + Private S3)

---

### Key Learnings

- Route 53 does **DNS management**, not hosting
- CloudFront requires ACM certificates in **us-east-1**
- Alias records allow root domain mapping (no need for IP)
- Nameserver update is critical for domain routing

---
