#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 26 15:31:24 2022

"""

import os
import json
import pymysql
import pymysql.cursors
from datetime import datetime

def lambda_handler(event, context):
    
    # Connect to the database
    connection = pymysql.connect(host=os.environ['MYSQL_HOST'],
                                 port=int(os.environ['MYSQL_PORT']),
                                 user=os.environ['MYSQL_USER'],
                                 password=os.environ['MYSQL_PASSWORD'],
                                 database=os.environ['MYSQL_DB'],
                                 cursorclass=pymysql.cursors.DictCursor)
    end_date = datetime.now()
    
    with connection:
        with connection.cursor() as cursor:
            
            sql = f"UPDATE encounter SET discharge_to_source_value = '{event['reason']}', end_datetime = '{end_date}' WHERE enc_id = {int(event['enc'])} "
            cursor.execute(sql)
            
            connection.commit()
    
    return {"statusCode": 200 }    
    