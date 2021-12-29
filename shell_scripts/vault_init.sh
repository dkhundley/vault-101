# Changing the working directory appropriately
cd ~
cd Documents/Repositories/vault-101

# Starting the Vault server
echo 'Starting the Vault server...'
vault server -config=config/vault_config.hcl &> /dev/null &

# Waiting 10 seconds for Vault server to start
sleep 10

# Saving PID of started server to text file
echo $! > sensitive/vault_pid.txt

# Initializing the Vault operator and writing the output to a JSON file
echo 'Initializing the Vault operator and writing to JSON file...'
vault operator init -format=json -key-shares 1 -key-threshold 1 > sensitive/vault_creds.json

# Getting creds from the JSON file
echo 'Extracting credentials from JSON file...'
export VAULT_UNSEAL_KEY=`jq -r '.unseal_keys_b64[0]' sensitive/vault_creds.json`
export VAULT_ROOT_TOKEN=`jq -r '.root_token' sensitive/vault_creds.json`

# Unsealing the Vault with the Vault unseal key
echo 'Unsealing the Vault with the unseal key...'
vault operator unseal $VAULT_UNSEAL_KEY

# Waiting 10 seconds after unsealing
sleep 10

# Logging in with the Vault root token
echo 'Logging into Vault with the root token...'
vault login $VAULT_ROOT_TOKEN

echo 'Vault initialization complete!'