import json
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    # Log the received event
    logger.info("Received event: " + json.dumps(event, indent=2))

    # Iterate over each record in the event
    for record in event['Records']:
        # Extract message body from the event
        message_body = record['body']
        
        # Log the message body
        logger.info(f"Received message: {message_body}")

    return {
        'statusCode': 200,
        'body': json.dumps(f"Processed {len(event['Records'])} records.")
    }
