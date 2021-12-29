# Changing the working directory appropriately
cd ~
cd Documents/Development/Vault

# Extracting the respective environment variables from the text file
export VAULT_UNSEAL_KEY=`grep 'VAULT_UNSEAL_KEY' vault_creds.txt | sed 's/VAULT_UNSEAL_KEY\s*=\s*//'`
export VAULT_ROOT_TOKEN=`grep 'VAULT_ROOT_TOKEN' vault_creds.txt | sed 's/VAULT_ROOT_TOKEN\s*=//'`

# Killing the process behind the Vault server's last startup
kill -9 $(<vault_pid.txt)

# Starting the Vault server
vault server -config=config.hcl &> /dev/null &

# Waiting 1 second for Vault server to start
sleep 1

# Saving PID of started server to text file
echo $! > vault_pid.txt

# Unsealing the Vault with the Vault unseal key
vault operator unseal $VAULT_UNSEAL_KEY

# Waiting 10 seconds after unsealing
sleep 10

# Logging in with the Vault root token
vault login $VAULT_ROOT_TOKEN