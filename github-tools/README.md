
github-tools
============

Commandline tools for Github

[![oclif](https://img.shields.io/badge/cli-oclif-brightgreen.svg)](https://oclif.io)

<!-- toc -->
* [Usage](#usage)
* [Commands](#commands)
<!-- tocstop -->
# Usage
<!-- usage -->
```sh-session
$ npm install
$ bin/run COMMAND
or
$ npm install
$ npm link
$ github-tools COMMAND
running command...
$ github-tools (-v|--version|version)
github-tools/1.0.0 win32-x64 node-v12.14.1
$ github-tools --help [COMMAND]
USAGE
  $ github-tools COMMAND
...
```
<!-- usagestop -->
# Commands
<!-- commands -->
* [`github-tools createSecret GITHUBTOKEN OWNER REPO SECRETNAME PLAINSECRET`](#github-tools-createsecret-githubtoken-owner-repo-secretname-plainsecret)
* [`github-tools deploy GITHUBTOKEN OWNER REPO REF [TASK] [AUTOMERGE] [PAYLOAD] [ENVIRONMENT] [DESCRIPTION] [TRANSIENTENVIRONMENT] [PRODUCTIONENVIRONMENT]`](#github-tools-deploy-githubtoken-owner-repo-ref-task-automerge-payload-environment-description-transientenvironment-productionenvironment)
* [`github-tools dispatchEvent GITHUBTOKEN OWNER REPO EVENTTYPE [CLIENTPAYLOAD]`](#github-tools-dispatchevent-githubtoken-owner-repo-eventtype-clientpayload)
* [`github-tools help [COMMAND]`](#github-tools-help-command)

## `github-tools createSecret GITHUBTOKEN OWNER REPO SECRETNAME PLAINSECRET`

Create secret for Github Actions

```
USAGE
  $ github-tools createSecret GITHUBTOKEN OWNER REPO SECRETNAME PLAINSECRET

Example
  $ github-tools createSecret myGithubToken bcgov educ-pen-demog-api OPENSHIFT_API_TOKEN 123abc
```

_See code: src\commands\createSecret.js_

## `github-tools deploy GITHUBTOKEN OWNER REPO REF [TASK] [AUTOMERGE] [PAYLOAD] [ENVIRONMENT] [DESCRIPTION] [TRANSIENTENVIRONMENT] [PRODUCTIONENVIRONMENT]`

Trigger deployment webhook event

```
USAGE
  $ github-tools deploy GITHUBTOKEN OWNER REPO REF [TASK] [AUTOMERGE] [PAYLOAD] [ENVIRONMENT] [DESCRIPTION] 
  [TRANSIENTENVIRONMENT] [PRODUCTIONENVIRONMENT]

Example
  $ github-tools deploy myGithubToken bcgov educ-pen-demog-api feature/actions
```

_See code: src\commands\deploy.js_

## `github-tools dispatchEvent GITHUBTOKEN OWNER REPO EVENTTYPE [CLIENTPAYLOAD]`

Trigger repository_dispatch webhook event

```
USAGE
  $ github-tools dispatchEvent GITHUBTOKEN OWNER REPO EVENTTYPE [CLIENTPAYLOAD]

Example
  $ github-tools dispatchEvent myGithubToken bcgov educ-pen-demog-api test
```

_See code: src\commands\dispatchEvent.js_

## `github-tools help [COMMAND]`

display help for github-tools

```
USAGE
  $ github-tools help [COMMAND]

ARGUMENTS
  COMMAND  command to show help for

OPTIONS
  --all  see all commands in CLI
```

_See code: [@oclif/plugin-help](https://github.com/oclif/plugin-help/blob/v2.2.3/src\commands\help.ts)_
<!-- commandsstop -->
