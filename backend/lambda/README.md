## Task — AWS Lambda Function for Visitor Counter

### Overview
An **AWS Lambda function** was created to handle the backend logic for the visitor counter.  
This function is triggered via API calls and is responsible for **reading and updating the visitor count stored in DynamoDB**.

### Services Used
- **AWS Lambda**
- **Amazon DynamoDB**
- **IAM (Execution Role)**

### Implementation

1. **Created Lambda Function**
   - Runtime: Python (e.g., Python 3.x)
   - Function name: `visitor-counter-function`

2. **Configured IAM Role**
   - Attached permissions to allow:
     - `dynamodb:GetItem`
     - `dynamodb:UpdateItem`

3. **Connected to DynamoDB**
   - Table name: `visitor-counter`
   - Partition key: `id = "resume"`

4. **Lambda Function Logic**
   - Fetch current visitor count from DynamoDB
   - Increment the count by 1
   - Update the value in DynamoDB
   - Return updated count as response

---

## Architecture Role
- Lambda acts as the compute layer in the architecture:
- Receives request from API Gateway
- Updates visitor count in DynamoDB
- Returns updated value to frontend

## Result

A serverless backend is now in place that dynamically updates and returns the visitor count on each website visit.