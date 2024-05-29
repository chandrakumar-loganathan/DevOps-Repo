import boto3
import botocore

rds = boto3.client('rds', region_name='me-central-1')


def lambda_handler(event, context):
    
    print (event['schedule'])
        
    if event['schedule'] == "start":
        #get all aurora db clusters
        rds_aurora = rds.describe_db_clusters()
            #start all aurora cluster
        for aurora_cluster in rds_aurora['DBClusters']:
            try:
                rds.start_db_cluster(DBClusterIdentifier=aurora_cluster['DBClusterIdentifier'])
                print("Started DB instances")
                print(aurora_cluster['DBClusterIdentifier'])
            except botocore.exceptions.ClientError as err:
                print(err)
    elif event['schedule'] == "stop":
        #get all aurora db clusters
        rds_aurora = rds.describe_db_clusters()
            #stop all aurora cluster
        for aurora_cluster in rds_aurora['DBClusters']:
            try:
                rds.stop_db_cluster(DBClusterIdentifier=aurora_cluster['DBClusterIdentifier'])
                print("Stopped DB instances")
                print(aurora_cluster['DBClusterIdentifier'])
            except botocore.exceptions.ClientError as err:
                print(err)