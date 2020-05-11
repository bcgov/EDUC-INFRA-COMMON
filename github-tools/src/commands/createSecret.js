const {Command, flags} = require('@oclif/command')
const { Octokit } = require("@octokit/rest")
const sodium = require('tweetsodium')

class CreateSecretCommand extends Command {
  async run() {
    try {
      const {args} = this.parse(CreateSecretCommand)
      this.log(`creating secret ${args.secretName} for ${args.owner}/${args.repo} ...`)
      
      const octokit = new Octokit({
        auth: args.githubToken
      })

      const { data: keyData } = await octokit.actions.getPublicKey({
        owner: args.owner,
        repo: args.repo,
      });

      // Convert the message and key to Uint8Array's (Buffer implements that interface)
      const plainSecretBytes = Buffer.from(args.plainSecret)
      const keyBytes = Buffer.from(keyData.key, 'base64')

      // Encrypt using LibSodium.
      const encryptedBytes = sodium.seal(plainSecretBytes, keyBytes)

      // Base64 the encrypted secret
      const encrypted = Buffer.from(encryptedBytes).toString('base64')

      octokit.actions.createOrUpdateSecretForRepo({
        owner: args.owner,
        repo: args.repo,
        name: args.secretName,
        encrypted_value: encrypted,
        key_id: keyData.key_id
      })

      this.log('complete!')
    } catch (error) {
      this.error(error.message, {exit: 1});
    }
  }
}

CreateSecretCommand.description = `Create secret for Github Actions
`

CreateSecretCommand.args = [
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
    name: 'secretName',
    required: true
  },
  {
    name: 'plainSecret',
    required: true
  }
]

module.exports = CreateSecretCommand
