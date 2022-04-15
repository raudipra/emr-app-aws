import os
import json
import pymysql
import pymysql.cursors

def lambda_handler(event, context):
    # Connect to the database
    connection = pymysql.connect(host=os.environ['MYSQL_HOST'],
                                 port=int(os.environ['MYSQL_PORT']),
                                 user=os.environ['MYSQL_USER'],
                                 password=os.environ['MYSQL_PASSWORD'],
                                 database=os.environ['MYSQL_DB'],
                                 cursorclass=pymysql.cursors.DictCursor)
    
    with connection:
        with connection.cursor() as cursor:
            sql = "SELECT * " +\
                  "FROM (SELECT d.person_id, condition_occurrence_id, " +\
                  "birth_datetime, first_name, last_name, MAX(condition_occurrence_id) " +\
                  "OVER (PARTITION BY d.person_id) AS c_id, condition_status " +\
                  "FROM `condition` AS c INNER JOIN `demographics` AS d " +\
                  "ON c.person_id = d.person_id) AS temp " +\
                  "WHERE condition_occurrence_id = c_id"
            cursor.execute(sql)
            rows = cursor.fetchall()
    
    return {
        'statusCode': 200,
        'body': json.dumps(rows)
    }
