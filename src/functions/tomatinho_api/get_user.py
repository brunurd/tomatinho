import json

def handler(event, _):
    return {
        "statusCode": 200,
        "body": json.dumps(event),
    }
