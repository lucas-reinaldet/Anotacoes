import requests
import base64
import json

url = "localhost:9092/topics/teste-rest-api"
headers = {
"Content-Type" : "application/vnd.kafka.binary.v1 + json"
   }
# Create one or more messages
payload = {"records":
       {
           "key": "firstkey",
           "value": "firstkey"
       }}
# Send the message
r = requests.post(url, data=json.dumps(payload).encode('utf-8'), headers=headers)
if r.status_code != 200:
   print( "Status Code: " + str(r.status_code))
   print (r.text)

# ./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic teste-rest-api --from-beginning