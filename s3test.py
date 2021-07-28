from boto3.session import Session
import concurrent.futures
import logging
import boto3
#boto3.set_stream_logger('', logging.DEBUG)
import os
import random
import time

access_key = "cap_mon"
secret_key = "bS8yDiemFxBQDyykC6FkVMApVKqKTY7hM0FYIIuT"
session = Session(access_key, secret_key)
url = "http://127.0.0.1:9090"
config = boto3.session.Config(connect_timeout=3000000, read_timeout=3000000, retries={'max_attempts': 0}, signature_version="s3", max_pool_connections=1)

dst_bucket = 'cap_mon'
dst_obj1 = '128k.ob'
dst_obj2 = '4m.ob'

total_request_num = 1000
total_request_num1 = 600
thead_pool_size = 200
tasks = range(0, total_request_num)
tasks1 = range(0, total_request_num1)


def put_128k_object(req_id):
    print "req_id=", req_id
    s3_client = session.client('s3', endpoint_url=url, config=config)
    #print s3_client
    #resp = s3_client.get_object(Bucket=dst_bucket, Key=dst_obj)
    #print dst_bucket
    resp = s3_client.put_object(Bucket=dst_bucket, Key=dst_obj1,Body=open("test1.txt",'rb').read())
    #print resp
    #data = resp['Body'].read()

total_request_num2 = 400
tasks2 = range(0, total_request_num2)

def put_4m_object(req_id):
    print "req_id=", req_id
    s3_client = session.client('s3', endpoint_url=url, config=config)
    #print s3_client
    #resp = s3_client.get_object(Bucket=dst_bucket, Key=dst_obj)
    #print dst_bucket
    resp = s3_client.put_object(Bucket=dst_bucket, Key=dst_obj2,Body=open("test2.txt",'rb').read())
    #print resp
    #data = resp['Body'].read()

def random_exc(req_id):
	if random.randint(1,10) >= 7:
		return put_4m_object(req_id)
	else
		return put_128k_object(req_id)




#download_from_s3(1)
time1 = time.time()

with concurrent.futures.ThreadPoolExecutor(max_workers=thead_pool_size) as executor:
     executor.map(random_exc, tasks)

#with concurrent.futures.ThreadPoolExecutor(max_workers=thead_pool_size) as executor:
#    executor.map(put_4m_object, tasks)

time2 = time.time()

time_delta = time2 - time1
print time_delta