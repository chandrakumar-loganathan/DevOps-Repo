import json
import boto3 as bot
region = 'us-west-2'

ecs = bot.client('ecs', region_name=region)

def lambda_handler(event, context):
    # TODO implement
    ecs.update_service(
                        cluster=event['CLUSTER_NAME'],
                        service=event['SERVICE_NAME'],
                        desiredCount=event['DESIRED_COUNT'],
                        forceNewDeployment=True
                    )
    return {
        'statusCode': 200,
        'body': json.dumps('ECS Service Update Complete!')
    }
