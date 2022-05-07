#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr 28 12:27:47 2022

"""

import os
import json
import pymysql
import pymysql.cursors

def upd_encounter_results(results):
    
    results_dict = {}
    for item in results:
        results_dict[item["visit_source_value"]] = item["c"]
        
    return results_dict
        

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
            
            #Current number of admitted patients 
            sql = "SELECT COUNT(DISTINCT person_id) as c FROM encounter "  +\
                " WHERE end_datetime = '' "
            cursor.execute(sql)
            results = cursor.fetchall()
            admitted_count = results[0]['c']
            
            #Admitted patients by type
            sql = "SELECT visit_source_value, COUNT(enc_id) as c FROM encounter" +\
                " GROUP BY visit_source_value"
            cursor.execute(sql)
            encounter_types = cursor.fetchall()
            
            sql = "SELECT visit_source_value, COUNT(enc_id) as c FROM encounter" +\
                " WHERE end_datetime = '' GROUP BY visit_source_value "
            cursor.execute(sql)
            encounters_admitted = cursor.fetchall()
            
            # Number of COVID patients - total and currently admitted 
            sql = "SELECT COUNT(person_id) as c FROM `condition` WHERE diagnosis_code = 'U07.1' "
            cursor.execute(sql)
            total_covid = cursor.fetchall()[0]['c']
            
            sql = "SELECT COUNT(a.person_id) as c FROM `condition` as a "  +\
                "JOIN encounter as e ON e.person_id = a.person_id " +\
                "WHERE diagnosis_code = 'U07.1' AND e.end_datetime = '' "
            cursor.execute(sql)
            total_covid_admitted  = cursor.fetchall()[0]['c']
            
    
    metrics = {
        "metrics":{
            "current_admits": admitted_count,
            "total_covid_cases": total_covid,
            "current_covid_cases": total_covid_admitted,
            "enc_types": upd_encounter_results(encounter_types),
            "admitted_enc_types": upd_encounter_results(encounters_admitted) 
            }
        }
    
    return metrics 
    
    
    
            
            
            
            
            
    
    
    
    
