# terraform

Provisions a single cloud node on GCP and joins it to the tailnet, so the
monoapp server can be reached privately over Tailscale.

This first step only creates the node and brings up Tailscale on it. Running the
monoapp container on it comes as a later step.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install)
- A GCP project and `gcloud auth application-default login` (or a service
  account) with permission to create Compute Engine instances
- A [Tailscale auth key](https://login.tailscale.com/admin/settings/keys)

## Usage

Copy the example vars and fill in your project id and auth key:

```sh
cp terraform.tfvars.example terraform.tfvars
```

Then:

```sh
terraform init
terraform plan
terraform apply
```

`terraform.tfvars` and the state files are gitignored, so no secrets land in the
repo. Once applied, the node joins your tailnet and is reachable over Tailscale
SSH.
