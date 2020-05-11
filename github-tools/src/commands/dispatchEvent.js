const {Command, flags} = require('@oclif/command')
const { Octokit } = require("@octokit/rest")

class DispatchEventCommand extends Command {
  async run() {
    try {
      const {args} = this.parse(DispatchEventCommand)
      this.log(`creating a repository dispatch event: ${args.eventType} for ${args.owner}/${args.repo} ...`)
      
      const octokit = new Octokit({
        auth: args.githubToken
      })

      await octokit.repos.createDispatchEvent({
        owner: args.owner,
        repo: args.repo,
        event_type: args.eventType,
        client_payload: args.clientPayload
      })
      this.log('complete!')
    } catch (error) {
      this.error(error.message, {exit: 1});
    }
  }
}

DispatchEventCommand.description = `Trigger repository_dispatch webhook event
`

DispatchEventCommand.args = [
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
    name: 'eventType',
    required: true
  },
  {
    name: 'clientPayload',
    required: false,
    parse: input => JSON.parse(input),
    default: '{}'
  }
]

module.exports = DispatchEventCommand
