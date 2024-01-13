#!/usr/bin/env bash

# Generate ssh key for provided keyPathMap, add to ssh-agent, and print public key to add to keyPathMap
SSH_CONFIG_FILE="$HOME/.ssh/config"
SSH_PASSWORD_FILE="$HOME/.ssh/passwords"
# backup ssh config file
mv -f "$SSH_CONFIG_FILE" "$SSH_CONFIG_FILE.old"

declare -A keyPathMap
declare -A keyPasswordMap

echo "Removing current ssh config..."
rm -f "$SSH_CONFIG_FILE"
rm -f "$SSH_PASSWORD_FILE"

touch "$SSH_PASSWORD_FILE"
chmod 600 "$SSH_PASSWORD_FILE"

for site in "$@"
do
    keyName="id_${site}_${USER}"
    keyPath="$HOME/.ssh/$keyName"
    rm -f "$keyPath"
    echo "Generating ssh key with a random passphrase for $site..."
    passphrase=$(tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 32; echo)
    ssh-keygen -t ed25519 -C "Key of $USER for $site" -f "$keyPath" -N "$passphrase"
    echo "Adding $site to ssh config..."
    touch "$SSH_CONFIG_FILE"
    {
    echo "Host $site"
    echo "    HostName $site"
    echo "    User git"
    echo "    PreferredAuthentications publickey"
    echo "    IdentityFile $keyPath"
    } >> "$SSH_CONFIG_FILE"
    keyPathMap["$site"]="$keyPath"
    keyPasswordMap["$keyPath"]="$passphrase"
done

# add ssh key to ssh-agent
eval "$(ssh-agent -s)"
echo "Removing identities from ssh-agent..."
ssh-add -D

echo "#!/usr/bin/env bash" > ./ssh-provide-pass.sh
echo 'echo $SSH_PASSWORD' >> ./ssh-provide-pass.sh
chmod +x ./ssh-provide-pass.sh
for key in "${!keyPathMap[@]}"
do
    echo "Adding $key key to ssh-agent..."
    SSH_PASSWORD="${keyPasswordMap[${keyPathMap[$key]}]}" SSH_ASKPASS="./ssh-provide-pass.sh" DISPLAY=1 setsid -w ssh-add "${keyPathMap[$key]}" < /dev/null
done
rm ./ssh-provide-pass.sh

for site in "${!keyPathMap[@]}"
do
      {
        echo "site: $site"
        echo "public key: $(cat "${keyPathMap[$site]}.pub")"
        echo "password: ${keyPasswordMap[${keyPathMap[$site]}]}"
      } >> "$SSH_PASSWORD_FILE"
done

echo "Done ! Check $SSH_PASSWORD_FILE to save your passwords in a password manager and get the public key to add to the sites. Remove the file once you're done."
