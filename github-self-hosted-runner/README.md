# GITHUB Self-hosted runner

This directory contains the files for building a self-hosted github actions runner that can be deployed
on Openshift for running tests, etc.

The Dockerfile in self_hosted_gh_runner_base is what is used to create the base image which contains all
the necessary tools used (Chrome, Nodejs, NPM, etc.). In order to update anything on the self-hosted runner,
make the changes in the Dockerfile there, and run the Github action "Build self hosted runner base" in this repository. This is defined in the `.github\build-self.hosted.runner.base.yaml` file.

Second, the files in the self_hosted_gh_runner directory add the necessary startup scripts, etc to the image base and deploy to an Openshift environment image stream ready for deployment. You can run the github action: "Build and push self-hosted runner from base". This is defined in the `.github\build-self.hosted.runner.yaml` file.