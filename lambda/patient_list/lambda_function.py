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
            sql = "SELECT DISTINCT d.person_id, " +\
                 "birth_datetime, first_name, last_name, MAX(end_datetime) " +\
                 "OVER (PARTITION BY d.person_id) AS c_id " +\
                 "FROM `demographics` AS d LEFT JOIN `encounter` AS e " +\
                 "ON e.person_id = d.person_id "
            cursor.execute(sql)
            rows = cursor.fetchall()
    
    return {
        'statusCode': 200,
        'body': json.dumps(rows)
    }
