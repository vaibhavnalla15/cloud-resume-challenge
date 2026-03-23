import json
import boto3

# Initialize outside to stay fast
table = boto3.resource('dynamodb').Table('visitor-counter')

def lambda_handler(event, context):
    # 'ADD' is the simplest way to increment a number in DynamoDB
    response = table.update_item(
        Key={'id': 'resume'},
        UpdateExpression='ADD visitor_count :inc',
        ExpressionAttributeValues={':inc': 1},
        ReturnValues='UPDATED_NEW'
    )

    # Get the new value from the response
    new_count = int(response['Attributes']['visitor_count'])

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*', # Solves CORS errors for your website
            'Content-Type': 'application/json'
        },
        'body': json.dumps({'count': new_count})
    }