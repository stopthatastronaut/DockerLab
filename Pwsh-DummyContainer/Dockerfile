FROM mcr.microsoft.com/powershell:latest

LABEL Stopthatastronaut Dummy Container

COPY dummycontainer.ps1 /pwsh/dummycontainer.ps1

RUN chmod 777 /pwsh/dummycontainer.ps1

CMD pwsh -f /pwsh/dummycontainer.ps1