# PortalSql

A disposable copy of a target SQL Database from a backup. Either pulls from S3 (if switched to use Production Data) or from a local path. It then goes to my local web app's repository path and updates the Sql Connection String. Then you just F5 the web app and you have production data in place to test with. YOUR MILEAGE MAY VARY.

The DB Name, Repo Path, S3 bucket and S3 region are all pulled from  `~/.secrets/secrets.json`

