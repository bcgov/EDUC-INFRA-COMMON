# Database backups
The backup containers are built following the [BCDevOps guide](https://github.com/BCDevOps/backup-container).  Please refer to their complete documentation before following the below steps.  This readme only acts as a quick cheat sheet style guide for EDUC's backup containers.

## Steps for initial deployment
1. Create the required [nfs-backup pvc](https://github.com/BCDevOps/provision-nfs-apb/blob/master/docs/usage-gui.md) in openshift. Get the name of the generated pvc to use in deployment template parameter `BACKUP_VOLUME_NAME` Use a size large enough to accommodate the `BACKUP_VOLUME_SIZE` parameter in deployment template (update if you need more).
2. Update the `backup.conf` file to match your db details and scheduling needs then run the `backup-deploy.overrides.sh`
Note that you will need [openshift-developer-tools](https://github.com/BCDevOps/openshift-developer-tools) installed to run the script.
3. Create generic secret in openshift to store database details. The secret name needs to be the same as `DATABASE_DEPLOYMENT_NAME` used in the deployment template. The keys for db user `DATABASE_USER_KEY_NAME` and password `DATABASE_PASSWORD_KEY_NAME` will also be used in the deployment template.
4. Create web-hook for rocket chat alerts. The [BCDevOps guide](https://github.com/BCDevOps/backup-container) has the complete steps. Use the url you generate as the parameter in the deployment template `WEBHOOK_URL`.
5. Process the build template
`oc -n <namespace> process -f https://raw.githubusercontent.com/BCDevOps/backup-container/master/openshift/templates/backup/backup-build.json -o yaml | oc create -f -`.
6. Create config map
`oc -n <namespace> create -f <path>backup-conf-configmap_DeploymentConfig.json`
6. Process the deployment template 
`oc -n <namespace> process -f <path-to-dc>backup-deploy.json -p IMAGE_NAMESPACE=<namespace> -p TAG_NAME=<tag-name> -p DATABASE_DEPLOYMENT_NAME=<database-service-name> -p DATABASE_USER_KEY_NAME=<db-secret-key-user> -p DATABASE_PASSWORD_KEY_NAME=<db-secret-key-password> -p WEBHOOK_URL=<webhook-url> -p DAILY_BACKUPS=<daily-backups> -p WEEKLY_BACKUPS=<weekly-backups> -p MONTHLY_BACKUPS=<monthy-backups> -p BACKUP_VOLUME_NAME=<backup-volume-name> -p BACKUP_VOLUME_SIZE=<backup-volume-size> -o yaml |oc create -f -`

## Clean up
To remove the backup container resources, run the following commands. 
- `oc delete all --field-selector metadata.name=backup-postgres`
- `oc delete configmap --field-selector metadata.name=backup-conf`
- `oc delete ServiceInstance --field-selector metadata.name=<BACKUP_VOLUME_NAME>`
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
