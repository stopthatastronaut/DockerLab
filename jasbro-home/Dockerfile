FROM python:alpine3.15

LABEL description="This simple image runs occasionally and updates my home DNS record in Azure to match my router's dynamic IP address. It is parameterised so anyone needing to do this in Azure can re-use it"

LABEL org.opencontainers.image.authors="jasbro@jasbro.io"

RUN mkdir /jasbro-home/

RUN apk add --no-cache libffi-dev build-base 

COPY ./ip.py /jasbro-home

COPY ./requirements.txt /jasbro-home

RUN chmod 777 /jasbro-home/

RUN pip install -r /jasbro-home/requirements.txt --target /jasbro-home/

CMD python /jasbro-home/ip.py