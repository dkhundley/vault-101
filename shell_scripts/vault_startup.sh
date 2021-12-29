# Changing the working directory appropriately
cd ~
cd Documents/Repositories/vault-101

# Noting the proper Vault address as an environemnt variable
export VAULT_ADDR='http://127.0.0.1:8200'

# Getting creds from the JSON file
echo 'Extracting credentials from JSON file...'
export VAULT_UNSEAL_KEY=`/opt/homebrew/bin/jq -r '.unseal_keys_b64[0]' sensitive/vault_creds.json`
export VAULT_ROOT_TOKEN=`/opt/homebrew/bin/jq -r '.root_token' sensitive/vault_creds.json`

# Killing the process behind the Vault server's last startup
kill -9 $(<sensitive/vault_pid.txt)

# Starting the Vault server
/opt/homebrew/bin/vault server -config=config/vault_config.hcl &> /dev/null &

# Waiting 1 second for Vault server to start
sleep 1

# Saving PID of started server to text file
echo $! > sensitive/vault_pid.txt

# Unsealing the Vault with the Vault unseal key
/opt/homebrew/bin/vault operator unseal $VAULT_UNSEAL_KEY

# Waiting 10 seconds after unsealing
sleep 10

# Logging in with the Vault root token
/opt/homebrew/bin/vault login $VAULT_ROOT_TOKEN