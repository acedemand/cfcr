# CFCR
Installing Bosh Director and Deploying CFCR (Kubo)

## Bosh Director Installation Steps

- Create a Ubuntu 16.04 jumpbox VM and SSH into VM

- Run install-prereqs.sh script to get useful binaries to manage Bosh and related software.

- Create a cloud-config file for Bosh. See bosh/cloud-config.yml file.

- Create a bootstrap variables file. See bosh/bootstrap-vars.yml file. Specify the values for main manifest file which in this case is bosh/bosh.yml.

- Create a main manifest. See bosh/bosh.yml file.

- Create a cloud provider interface file. In this case we used GCP, see bosh/gcp-cpi.yml.

- Run bosh/deploy-bosh.sh script. This will create Bosh VM and install necessary binaries. Now Bosh can be used to deploy CFCR.


## CFCR Deployment Steps

The steps in the link below are clear to deploy CFCR.

https://github.com/cloudfoundry-incubator/kubo-release/#deploying-cfcr

Some notes:

- Change the main manifest (cfcr.yml) parameters according to your Bosh cloud-config. 

- If Bosh Director VM doesn't have Credhub, "--vars-store=creds.yml" parameter need to be added to "bosh deploy ..." command. Kubeconfig script should be modified also. See cfcr/set-kubeconfig.sh. ca-cert file -which is used by set-kubeconfig script- should include tls-kubernetes/ca value of creds.yml file.

### CFCR Troubleshooting

- When worker VMS are off for multiple days, PKS Flannel network gets out of sync with docker bridge network (cni0). To resolve this follow the steps in the link below.

https://community.pivotal.io/s/article/PKS-Flannel-network-gets-out-of-sync-with-docker-bridge-network-cni0

References

[1] https://github.com/cloudfoundry-incubator/kubo-release/#deploying-cfcr
[2] https://community.pivotal.io






