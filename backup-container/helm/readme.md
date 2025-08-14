# How to deploy backup container using Helm and config file

## This will explain how to set up a backup container for our sso-keycloak instance along with the values.yaml file to use with helm.

## Reference:

- [backup-container](https://github.com/BCDevOps/backup-container?tab=readme-ov-file#deploy-with-helm-chart) we refer to this for instructions on how to deploy
- [helm charts](https://github.com/bcgov/helm-charts/tree/master/charts/backup-storage)
- [installing helm](https://helm.sh/docs/intro/install/)

```
oc login --web //logs you into openshift
helm repo add bcgov http://bcgov.github.io/helm-charts //install the charts
```

Navigate to the config.yaml configuration folder these commands were run in WSL. Powershell will require a different order to the inputs.

```
helm upgrade --install backup-sso-keycloak bcgov/backup-storage -n <<NAMESPACE>> -f <<VALUES LOCATION>>

example run in the folder with the values.yaml:
helm upgrade --install backup-sso-keycloak bcgov/backup-storage -n 75e61b-dev -f values.yaml
```

Notes:

- One of the errors I had while backing up was

> pg_dump: error: server version: 15.6 (Ubuntu 15.6-1.pgdg22.04+1); pg_dump version: 14.7
> pg_dump: error: aborting because of server version mismatch

- to fix, I updated the tag on the config.yaml to be the latest offered by bcDevops/backup-container 2.10.3 at the time of writing this readme.

- how do I verify that the backups work?

  - I rsynced into the pods and downloaded the .gz backups and opened them in dbeaver.
  - run ./backup.sh -I -v all in the pod

- When backing up pods in patroni use ./backup.sh -I -v. This ignores some dependencies that patroni requires. Source: https://github.com/bcgov/backup-container/blob/fca9861a5c12a61c85baf6ca84e1dbf60abb5ad5/docs/TipsAndTricks.md?plain=1#L77

- Remember to add the correct environment variable otherwise the backup verification won't work. https://github.com/bcgov/backup-container?tab=readme-ov-file#backupconf ex. SSO_PATRONI_USER and SSO_PATRONI_PASSWORD.

- Issue verification process hangs and server does not start.
  - https://github.com/bcgov/backup-container/issues/151#issuecomment-2956503224 do not use the default postgres superuser. Odd issue where it might cause the verification to hang. I ended up using another user secret appuser1.
