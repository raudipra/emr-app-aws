import os
import json
import pymysql
import pymysql.cursors

def lambda_handler(event, context):
    user_id = 252369
    
    # Connect to the database
    connection = pymysql.connect(host=os.environ['MYSQL_HOST'],
                                 port=int(os.environ['MYSQL_PORT']),
                                 user=os.environ['MYSQL_USER'],
                                 password=os.environ['MYSQL_PASSWORD'],
                                 database=os.environ['MYSQL_DB'],
                                 cursorclass=pymysql.cursors.DictCursor)
    data = {}
    with connection:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM demographics WHERE person_id=%s"
            cursor.execute(sql, (user_id,))
            person = cursor.fetchone()
            data['person'] = person
            
            sql = "SELECT datetime AS start_date, datetime AS end_date, " +\
                  "type AS category, description AS type, result " +\
                  "FROM drugs WHERE person_id=%s " +\
                  "UNION " +\
                  "SELECT start_datetime AS start_date, end_datetime AS end_date, " +\
                  "'Encounter' AS category, visit_source_value AS type, NULL AS result " +\
                  "FROM encounter WHERE person_id=%s " +\
                  "UNION " +\
                  "SELECT condition_start_datetime AS start_date, " +\
                  "condition_start_datetime AS end_date, " +\
                  "'Condition' AS category, condition_type_concept_id AS type, " +\
                  "display AS result " +\
                  "FROM `condition` WHERE person_id=%s " +\
                  "UNION " +\
                  "SELECT observation_datetime AS start_date, observation_datetime AS end_date, " +\
                  "'Observation' AS category, display AS type, result " +\
                  "FROM observation WHERE person_id=%s " +\
                  "ORDER BY start_date "
                  
            cursor.execute(sql, (user_id, user_id, user_id, user_id,))
            rows = cursor.fetchall()
            data['medical_records'] = rows
            
    return {
        'statusCode': 200,
        'body': json.dumps(data)
    }
