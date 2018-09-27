#!/usr/bin/env bash

set -eux

sudo apt-get update


# build-essential required for cf-uaac rubygem
sudo apt-get install -y \
  curl \
  zlib1g-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 \
  libxml2-dev \
  libxslt-dev \
  ruby-dev \
  jq \
  git \
  ruby \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  python-pip

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

sudo apt-get update
sudo apt-get install -y docker-ce

pip install awscli --upgrade --user

# Install bosh cli
sudo wget "https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-3.0.1-linux-amd64" -O \
  /usr/local/bin/bosh
sudo chmod +x /usr/local/bin/bosh

# Fly
sudo wget "https://github.com/concourse/concourse/releases/download/v4.0.0/fly_linux_amd64" -O \
  /usr/local/bin/fly
sudo chmod +x /usr/local/bin/fly

# YQ
sudo wget "https://github.com/mikefarah/yq/releases/download/2.0.0/yq_linux_amd64" -O \
  /usr/local/bin/yq
sudo chmod +x /usr/local/bin/yq

# Pivnet CLI
sudo wget "https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.51/pivnet-linux-amd64-0.0.51" -O \
  /usr/local/bin/pivnet
sudo chmod +x /usr/local/bin/pivnet

# UAA
sudo gem install cf-uaac

# CF CLI
sudo curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
sudo mv cf /usr/local/bin
sudo curl -o /usr/share/bash-completion/completions/cf https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf
sudo rm -f LICENSE NOTICE

# Credhub
wget "https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/1.7.6/credhub-linux-1.7.6.tgz"
sudo tar -zxvf credhub-linux-1.7.6.tgz -C /usr/local/bin
rm credhub-linux-1.7.6.tgz

# BBR
wget "https://github.com/cloudfoundry-incubator/bosh-backup-and-restore/releases/download/v1.2.3/bbr-1.2.3.tar"
tar -xvf bbr-1.2.3.tar
sudo mv releases/bbr /usr/local/bin/bbr
rm -rf releases bbr-1.2.3.tar

# OM
sudo wget "https://github.com/pivotal-cf/om/releases/download/0.37.0/om-linux" -O /usr/local/bin/om
sudo chmod +x /usr/local/bin/om

# verify binaries
which nc
which bosh
which fly
which yq
which pivnet
which cf
which uaac
which bbr
which credhub
which om

