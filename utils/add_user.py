import json
import requests
import sys

url = f'https://firestore.googleapis.com/v1/projects/spraywalls-dd36f/databases/(default)/documents/users/{sys.argv[1]}?updateMask.fieldPaths=logbook&updateMask.fieldPaths=bookmarks'
body = json.dumps({ 
  "fields": { 
    "logbook" : { "arrayValue" : {"values": []}},
    "bookmarks" : { "arrayValue" : {"values": []}},
  }
})

response = requests.patch(url, data=body)
print(response.status_code)
print(response.text)
