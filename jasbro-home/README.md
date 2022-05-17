# jasbro-home

Tiny docker container that runs occasionally and makes sure my home IP has a known DNS name associated with it. Cheap-ass dyndns, if you will.

## How to use

You'll need a pre-existing Resource Group and DNS Zone, and some Azure Service Principal Credentials that can update that DNS zone. Then you can call it thusly:

```
docker run  -e AZURE_CLIENT_ID='510c929b-fb7b-44be-9aac-6932211a0828' \
            -e AZURE_TENANT_ID='34f24d5b-b966-4b13-b0b4-2615ee97543b' \
            -e AZURE_CLIENT_SECRET='4e3hkA@9sk49FPMBN&tpp6S$nnGQjHegTkHM' \
            -e AZURE_SUBSCRIPTION_ID='f29d580d-1d47-414f-8828-8a8ba272ca2c' \
            -e DNS_ZONE='example.com' \
            -e DNS_RECORD='home'
            -e DNS_RG='MyDnsResourceGroup' \
            stopthatastronaut/jasbrohome:latest
```

Of course it's much neater with an [ENV file](env.example), but take exquisite care not to commit that to source control, seriously. Those values in the example? I generated them randomly.

```
docker run --env-file ./env.example stopthatastronaut/jasbrohome:latest
```

It's mostly just for me, I don't expect anyone else to use it. If you do use it and it doesn't work I am NOT tech support. AS-IS/NO WARRANTY and all that.