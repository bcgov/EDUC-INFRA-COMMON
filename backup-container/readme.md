# Database backups
The backup containers are built following the [BCDevOps guide](https://github.com/BCDevOps/backup-container).  Please refer to their complete documentation before following the below steps.  This readme only acts as a quick cheat sheet style guide for EDUC's backup containers.

## Steps for initial deployment
1. Create web-hook for rocket chat alerts. The [BCDevOps guide](https://github.com/BCDevOps/backup-container) has the complete steps. Use the url you generate as the parameter in the deployment template `WEBHOOK_URL`.
2. Process the build template
`oc -n <NAMESPACE> process -f https://raw.githubusercontent.com/BCDevOps/backup-container/master/openshift/templates/backup/backup-build.json -o yaml | oc -n <NAMESPACE> create -f -`.
3. Create config map.  *Make sure the spacing is correct*
```
oc create -n <NAMESPACE> configmap backup-conf --from-literal=backup.conf="postgres=<TARGET_DATABASE>/<TARGET_DATABASE_USER>
 0 1 * * * default ./backup.sh -s
 0 4 * * * default ./backup.sh -s -v all"
```
6. Process the deployment template 
`oc -n <namespace> process -f https://raw.githubusercontent.com/bcgov/EDUC-INFRA-COMMON/master/backup-container/openshift/templates/backup/backup-deploy.json -p IMAGE_NAMESPACE=<namespace> -p TAG_NAME=<tag-name> -p DATABASE_DEPLOYMENT_NAME=<database-service-name> -p WEBHOOK_URL=<webhook-url> -p DAILY_BACKUPS=<daily-backups> -p WEEKLY_BACKUPS=<weekly-backups> -p MONTHLY_BACKUPS=<monthy-backups> -p BACKUP_VOLUME_SIZE=<backup-volume-size> -o yaml | oc -n <NAMESPACE> create -f -`

## Clean up
To remove the backup container resources, run the following commands. 
- `oc delete all --field-selector metadata.name=backup-postgres`
- `oc delete configmap --field-selector metadata.name=backup-conf`
- `oc delete pvc --field-selector metadata.name=backup`
- `oc delete pvc --field-selector metadata.name=backup-verification`
If secrets are not used by anything else, you can delete those too.

## Actions cheat sheet
Navigate to the terminal of the backup-container pod.
### One off back up
`backup.sh -1`
### One off verification
`backup.sh -v all`
### Restore
First stop all services connecting to the db then run the following.
`backup.sh -r <host>/<db-name>`
