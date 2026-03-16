## Task — DynamoDB Table for Visitor Counter

### Overview
To store the number of visitors to the resume website, a **DynamoDB table** was created. This table acts as the backend data store for the visitor counter that will later be accessed by an AWS Lambda function.

### Services Used
- **Amazon DynamoDB**

---
### Implementation

1. **Created DynamoDB Table**
   - Table name: `visitor-counter`
   - Partition key: `id` (String)

2. **Inserted Initial Item**
   A record was added to store the visitor count.

| id     | visitor_count |
|--------|---------------|
| resume |      10       |

3. **Purpose of Attributes**
- **id** → Unique identifier for the counter  
- **views** → Stores the number of website visits

---

### Architecture Role
DynamoDB acts as the **persistent data layer** for the visitor counter.  
When users visit the website:
1. A **Lambda function** will be triggered.
2. Lambda will **increment the `views` value** in DynamoDB.
3. The updated count will be returned to the frontend.

---
### Result
A DynamoDB table is now available to store and update the **visitor count for the resume website**.