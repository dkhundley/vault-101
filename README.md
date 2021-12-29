# Vault 101!

# Prerequisites
In order to follow along with what we will be doing in this repository, you will need to install the following dependencies with Homebrew:

- **Vault**: Naturally, we will need the Vault CLI to do all of our work! To install, run the following command: `brew install vault`
- **JQ**: JQ is a lightweight Linux package that allows us to easily extract bits of information from JSON files. This will be useful as we will need to save / extract Vault credentials from a JSON file. JQ can be installed with the following command: `brew install jq`
- **Terraform**: This one isn't exactly required, but in order to optimize your Vault maintenance, it is best practice to streamline everything via Terraform. To install Terraform, run the following command `brew install terraform`