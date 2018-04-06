param([switch]$UseProductionData)

$workdir = $pwd

# load secrets
$secrets = gc .\..\.secrets\secrets.json -raw | ConvertFrom-Json

docker-compose up -d

# wait until it's up, get its container id
$longid = docker-compose ps -q db

# get its IP address
$conf = docker inspect $longid | convertfrom-json

$IpAddress = $conf.NetworkSettings.Networks.portalsql_default.IPAddress

Write-Host "Container IP Address is $IpAddress"

$fn = $secrets.DbName

Write-Host "Waiting 30s for SQL to be up and running"
Start-Sleep -s 30


if($UseProductionData)
{
    $bn = $secrets.S3Bucket
    $rg = $secrets.S3Region
    Read-S3Object -bucketname $bn -key "/$fn/$fn.bak" -file "c:\SqlBackup\$fn.bak" -region $rg
    osql -S $IpAddress -U sa -P p@ssword1234 -Q"RESTORE DATABASE $fn FROM DISK = 'c:\SqlBackup\$fn.bak' WITH MOVE '$fn' TO 'c:\SqlBackup\$($fn)_Data.mdf', MOVE '$($fn)_Log' TO 'c:\SqlBackup\$($fn)_Log.mdf'   "
}
else
{
    osql -S $IpAddress -U sa -P p@ssword1234 -Q"CREATE DATABASE $fn"
}

# write the config file
$targetfile = "$($secrets.PortalRepoPath)\source\HostedPortal.Web\settings.Development.json"

$configtemplate = gc .\configtemplate.json | ConvertFrom-Json 

$configtemplate.ConnectionString = "Server=$IpAddress;Database=$fn;user_id=sa;password=p@ssword1234;"

$configtemplate | ConvertTo-Json -depth 6 | Out-File $targetfile -Force

Write-Host "Done. Now go and fill in your API keys and such, I'm not doing that for you!" -ForegroundColor Yellow 

notepad $targetfile