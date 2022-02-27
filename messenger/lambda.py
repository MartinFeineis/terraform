# importing python libraries json Data formatting
# URL lib for making HTTP requests
# datetime for working with times and dates
import json, urllib.request
import datetime

print('Loading function')

# Event and Context are AWS Lambda specific objects
# Context contains AWS information about the Lambda Function (e.g. region, AWS-Account, etc.)
# Event contains information passed to the Lambda function (e.g. the ApiGateway that invoked it, IP address of User, etc. )
def lambda_handler(event, context):


    # checks if the Event object contains a field named URL if not it defaults to the ISS URL
    if "URL" in event:
      with urllib.request.urlopen(event["URL"]) as response:
          html = response.read()
    else:
      URL="http://api.open-notify.org/iss-now.json"

      # As no URL field was found we use a default URL to get the position of the Internatioal Space Station (ISS)
      with urllib.request.urlopen(URL) as response:
          html = response.read()
    print(response)
    print("The Time is " + str(datetime.datetime.now()))

    # Creates a json formatted return object 
    return json.dumps({
      "isBase64Encoded": False,
      "statusCode": 200,
      "headers": {
        "content-type": "application/json"
      },
      "body": json.loads(html)
    })
