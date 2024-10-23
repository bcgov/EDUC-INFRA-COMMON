# Personal Cloud Nats for development

The intention of this DC is to deploy a personal nats server with jetstream enabled to an openshift tools environment. You can then port-forward to this 'personal' instance for local development work.

## Usage:

### Setup:
Replace ${your-name} with your first name and ${your-tools-namespace} with the openshift tools namespace (including the -tools part)

`oc login`
`oc process -f nats-sa-dc.yaml -p YOUR_NAME=${your-name} -p TOOLS_NAMESPACE=${your-tools-namespace} | oc apply -f -`

You should now be able to port-forward to your nats server:

`oc port-forward service/nats-sa-${your-name} 4222:4222`

Note: you will have to use nats-cli to populate the necessary streams etc.
