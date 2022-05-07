#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 26 13:52:50 2022

"""
import os
import json
from dateutil import parser
from datetime import datetime
import pymysql
import pymysql.cursors

def parse_bday(birthdate):
    
    try:
        bdate = parser.parse(birthdate)
        return bdate.year, bdate.month, bdate.day
    except:
        return 0,0,0
    

def get_pat_id(cur):
    
    cur.execute("SELECT MAX(person_id) as m from demographics")
    result = cur.fetchall()
    
    pat_id = result[0]["m"]
    
    return pat_id +1

def get_enc_id(cur):
    
    cur.execute("SELECT MAX(enc_id) as m from encounter")
    result = cur.fetchall()
    
    enc_id = result[0]["m"]
    
    return enc_id +1

            
def lambda_handler(event, context):
    #create DB connection 
    connection = pymysql.connect(host=os.environ['MYSQL_HOST'],
                                 port=int(os.environ['MYSQL_PORT']),
                                 user=os.environ['MYSQL_USER'],
                                 password=os.environ['MYSQL_PASSWORD'],
                                 database=os.environ['MYSQL_DB'],
                                 cursorclass=pymysql.cursors.DictCursor)
    
    
    #Parse birthdate for year month day
    cur = connection.cursor()
    year, month, day = parse_bday(event["birthdate"])
    
    patient_id = get_pat_id(cur)
    enc_id = get_enc_id(cur)
    start_date = datetime.now()
    
    with connection:
        with connection.cursor() as cursor:
            
            #Insert new patient into demographics table 
            sql = f"INSERT INTO demographics VALUES ({patient_id}, {year}, {month}, {day}, '{event['birthdate']}', '{event['gender']}', '{event['race']}', '{event['f_name']}', '{event['l_name']}')"
            cursor.execute(sql)
            
            sql = f"INSERT INTO encounter (enc_id, person_id, start_datetime, visit_source_value) VALUES ({enc_id},{patient_id}, '{start_date}','{event['encounter_type']}' )"
                
            cursor.execute(sql)
            
            connection.commit()
    
    return {"statusCode": 200 }
            
    
    
    
    
    