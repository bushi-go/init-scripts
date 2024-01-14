#!/usr/bin/env bash

JAVA_VERSION='21.0.1-tem'
KOTLIN_VERSION='1.9.21'
GRADLE_VERSION='8.5'
# install sdkman to manage java and kotlin environment
#TODO check if sdkman is already installed
apt-get install unzip
apt-get install zip
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java "$JAVA_VERSION"
sdk install kotlin "$KOTLIN_VERSION"
sdk install gradle "$GRADLE_VERSION"

# install nvm to manage node environment
NVM_VERSION='0.39.7'
NODE_VERSION='21.5.0'

#TODO check if nvm is already installed
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh" | bash

nvm install "$NODE_VERSION"

# install podman
apt-get install -y podman

# install aws-cli
#TODO check if aws cli is already installed
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -f awscliv2.zip
./aws/install -i /usr/local/aws-cli -b /usr/local/bin --update
rm awscliv2.zip
rm -rf aws

