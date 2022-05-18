from azure.mgmt.dns import DnsManagementClient
from azure.identity import DefaultAzureCredential
from requests import get
import os
from dotenv import load_dotenv
import json
import logging
import sys

Log_Format = "%(levelname)s %(asctime)s - %(message)s"

logging.basicConfig(
                    stream = sys.stdout, 
                    filemode = "w",
                    format = Log_Format, 
                    level = logging.INFO)

log = logging.getLogger("jasbro-home")

if ( os.getenv('USERDOMAIN') is not None ):
    if ( os.environ['USERDOMAIN'] == 'ALLMYAPESGONE'):   # local laptop. Don't do this.
        log.info("Loading environment variables from .env file")
        load_dotenv(".env")

# which sub are we hitting?
subscription_id = os.environ["AZURE_SUBSCRIPTION_ID"]

# load from env vars 
credentials = DefaultAzureCredential()

dns_client = DnsManagementClient(
	credentials,
	subscription_id
)

ip = get('https://api.ipify.org').text
log.info('My public IP address appears to be: {}'.format(ip))

record_set = dns_client.record_sets.create_or_update(
	os.environ["DNS_RG"],
	os.environ["DNS_ZONE"],
	os.environ["DNS_RECORD"],
	'A',
	{
			"ttl": 300,
			"arecords": [
				{
				"ipv4_address": ip
				}
			]
	}
)

log.info(record_set.fqdn + " updated to " + ip)