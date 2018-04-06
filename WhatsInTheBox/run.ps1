docker-compose up -d


# $dbid = docker-compose ps -q somerset
$psid = docker-compose ps -q mills
# $dnid = docker-compose ps -q johndoe

# stop 'em



# copy stuff onto 'em



# start 'em



# run the stuff

# find all the default firewall rules, if you can (answer: you can't. Container has no usable host firewall)
<#
docker-compose exec mills netsh advfirewall set allprofiles state on
docker-compose exec mills powershell -command Get-NetFirewallRule 
#>
docker-compose exec mills powershell -command ipmo ServerManager
docker-compose exec mills powershell -command Add-WindowsFeature NFS-Client
docker-compose exec mills powershell -command Get-WindowsFeature

# stop 'em


# exfil the data


# tear 'em down

docker-compose down