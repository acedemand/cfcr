#!/usr/bin/env bash

set -eux

# Deploy the Director
bosh create-env bosh.yml \
    --state=state.json \
    --vars-store=creds.yml \
    -o gcp-cpi.yml \
    --vars-file bootstrap-vars.yml


# Configure local alias
bosh alias-env bosh -e `yq r ./bootstrap-vars.yml internal_ip` --ca-cert <(bosh int ./creds.yml --path /director_ssl/ca)

# Log in to the Director
export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=`bosh int ./creds.yml --path /admin_password`
bosh -e bosh log-in

# Query the Director for more info
bosh -e bosh env

# Upload Ubuntu Xenial stemcell
bosh -e bosh upload-stemcell https://s3.amazonaws.com/bosh-core-stemcells/google/bosh-stemcell-97.3-google-kvm-ubuntu-xenial-go_agent.tgz

# Update cloud config
yes | bosh -e bosh update-cloud-config \
    --vars-file ./bootstrap-vars.yml \
    ./cloud-config.yml

