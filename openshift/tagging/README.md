## Tagging Conventions
All EDUC-PEN pipelines currently build and deploy based on the 'latest' image. This works fine for small, non-breaking changes, but when we run into problems we have no images to roll-back to. This folder contains scripts that allow us to create version tags for all or some of the images in our namespaces.

### tag-all.sh
This file goes through an array which contains all of our deployable images and tags them with a version which is specified on the command line. Example
``` sh
./tag-all.sh 1.3
```
The above command will create a copy of the last built image in the DEV and TEST environment with the '1.3' and 'latest' tags for all images specified in 'array'.

### tagging-script
This file tags a single specified image with a version which is specified on the command line. Example
``` sh
./tagging-script.sh 2.3 educ-pen-request-frontend-static
```
The above command will create a copy of the last built image in the DEV and TEST environment with the '1.3' and 'latest' tags for the 'educ-pen-request-frontend-static' image.

### tagging-pipeline
The tagging-pipeline file creates and runs a Jenkins pipeline which tags images based on input from the taggin-script.sh and tag-all.sh files.

### Rolling Back
To roll back to a reliable version, you must run the following commands:
``` sh
oc tag educ-pen-request-frontend-static:latest educ-pen-request-frontend-static:1.3
oc deploy pen-request-frontend-master
```
The above commands points your latest image to the version specified (1.3 in this case). The deploy command then deploys the application with the new 'latest' image.
