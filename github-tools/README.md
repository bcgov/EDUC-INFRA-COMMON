
github-tools
============

Commandline tools for Github

[![oclif](https://img.shields.io/badge/cli-oclif-brightgreen.svg)](https://oclif.io)
[![Version](https://img.shields.io/npm/v/github-tools.svg)](https://npmjs.org/package/github-tools)
[![Downloads/week](https://img.shields.io/npm/dw/github-tools.svg)](https://npmjs.org/package/github-tools)
[![License](https://img.shields.io/npm/l/github-tools.svg)](https://github.com/bcgov/EDUC-PEN-DEMOG-API/blob/master/package.json)

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
```

_See code: [src\commands\createSecret.js](https://github.com/bcgov/EDUC-PEN-DEMOG-API/blob/v1.0.0/src\commands\createSecret.js)_

## `github-tools deploy GITHUBTOKEN OWNER REPO REF [TASK] [AUTOMERGE] [PAYLOAD] [ENVIRONMENT] [DESCRIPTION] [TRANSIENTENVIRONMENT] [PRODUCTIONENVIRONMENT]`

Trigger deployment webhook event

```
USAGE
  $ github-tools deploy GITHUBTOKEN OWNER REPO REF [TASK] [AUTOMERGE] [PAYLOAD] [ENVIRONMENT] [DESCRIPTION] 
  [TRANSIENTENVIRONMENT] [PRODUCTIONENVIRONMENT]
```

_See code: [src\commands\deploy.js](https://github.com/bcgov/EDUC-PEN-DEMOG-API/blob/v1.0.0/src\commands\deploy.js)_

## `github-tools dispatchEvent GITHUBTOKEN OWNER REPO EVENTTYPE [CLIENTPAYLOAD]`

Trigger repository_dispatch webhook event

```
USAGE
  $ github-tools dispatchEvent GITHUBTOKEN OWNER REPO EVENTTYPE [CLIENTPAYLOAD]
```

_See code: [src\commands\dispatchEvent.js](https://github.com/bcgov/EDUC-PEN-DEMOG-API/blob/v1.0.0/src\commands\dispatchEvent.js)_

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
