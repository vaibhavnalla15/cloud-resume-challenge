## Task — API Gateway for Visitor Counter

### Overview
Amazon API Gateway was configured to expose the Lambda function as a **public HTTP endpoint**.  
This allows the frontend (JavaScript) to send requests and retrieve the updated visitor count dynamically.

### Services Used
- **Amazon API Gateway**
- **AWS Lambda**

### Implementation

1. **Created API**
   - Type: **HTTP API** 
   - Name: `visitor-counter-api`

2. **Created Route**
   - Method: `GET`
   - Path: `/counter`

3. **Integrated with Lambda**
   - Connected the route to the Lambda function: `visitor-counter-function`
   - Enabled Lambda proxy integration

4. **Enabled CORS**
   - Allowed origin: `*` (or your CloudFront domain)
   - Allowed method: `GET`

5. **Deployed API**
   - Enabled auto deployment
   - Obtained the **Invoke URL**

Example:
```
https://xxxxxxxxxx.execute-api.REGION.amazonaws.com/counter
```

---


### Architecture Role
API Gateway acts as the **entry point** between the frontend and backend:
- Receives HTTP request from browser (JavaScript)
- Triggers Lambda function
- Returns response (visitor count)

Flow:
```
Frontend (JS) → API Gateway → Lambda → DynamoDB → Lambda → API Gateway → Frontend
```
---


### Result
A publicly accessible API endpoint is now available, enabling the frontend to **fetch and display the live visitor count**.

