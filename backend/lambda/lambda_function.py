import json
import boto3
import os

# Initialize DynamoDB
dynamodb = boto3.resource('dynamodb')

# ✅ Use environment variable (Terraform-controlled)
table_name = os.environ.get('TABLE_NAME')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    try:
        response = table.update_item(
            Key={'id': 'visitor_count'},  # consistent key
            UpdateExpression='ADD #count :inc',
            ExpressionAttributeNames={
                '#count': 'visitor_count'
            },
            ExpressionAttributeValues={
                ':inc': 1
            },
            ReturnValues='UPDATED_NEW'
        )

        new_count = int(response['Attributes']['visitor_count'])

        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'count': new_count})
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': str(e)
        }