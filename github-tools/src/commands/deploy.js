const {Command, flags} = require('@oclif/command')
const { Octokit } = require("@octokit/rest")

class DeployCommand extends Command {
  async run() {
    try {
      const {args} = this.parse(DeployCommand)
      this.log(`creating a deployment event for ${args.owner}/${args.repo} ...`)
      
      const octokit = new Octokit({
        auth: args.githubToken
      })

      await octokit.repos.createDeployment({
        owner: args.owner,
        repo: args.repo,
        ref: args.ref,
        task: args.task,
        auto_merge: args.autoMerge,
        payload: args.payload,
        environment: args.environment,
        description: args.description,
        transient_environment: args.transientEnvironment,
        production_environment: args.productionEnvironment
      })
      this.log('complete!')
    } catch (error) {
      this.error(error.message, {exit: 1});
    }
  }
}

DeployCommand.description = `Trigger deployment webhook event  
`

DeployCommand.args = [
  {
    name: 'githubToken',
    required: true
  },
  {
    name: 'owner',
    required: true
  },
  {
    name: 'repo',
    required: true
  },
  {
    name: 'ref',
    required: true
  },
  {
    name: 'task',
    required: false,
    default: 'deploy'
  },
  {
    name: 'autoMerge',
    required: false,
    default: false
  },
  {
    name: 'payload',
    required: false,
    parse: input => JSON.parse(input),
    default: ''
  },
  {
    name: 'environment',
    required: false,
    default: 'development'
  },
  {
    name: 'description',
    required: false,
    default: ''
  },
  {
    name: 'transientEnvironment',
    required: false,
    default: true
  },
  {
    name: 'productionEnvironment',
    required: false,
    default: false
  },
]

module.exports = DeployCommand
