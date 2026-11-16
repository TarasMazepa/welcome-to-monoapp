# server-setup-terraform-for-gcp

Provisions a single cloud node on GCP and joins it to the tailnet, so the
monoapp server can be reached privately over Tailscale.

This first step only creates the node and brings up Tailscale on it. Running the
monoapp container on it comes as a later step.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install)
- A GCP project and `gcloud auth application-default login` (or a service
  account) with permission to create Compute Engine instances
- A [Tailscale auth key](https://login.tailscale.com/admin/settings/keys), and
  the node's tag (`tag:server` by default) listed under `tagOwners` in the
  tailnet ACL
- A GCS bucket for the Terraform state, ideally with versioning turned on

## Usage

Copy the example vars and fill in your project id and auth key:

```sh
cp terraform.tfvars.example terraform.tfvars
```

Then:

```sh
terraform init -backend-config="bucket=<state bucket>"
terraform plan
terraform apply
```

The bucket only needs to be passed to `terraform init` once per checkout.
`terraform.tfvars` is gitignored, so no secrets land in the repo. Once applied,
the node joins your tailnet as a tagged device and is reachable over Tailscale
SSH. It has a network of its own with no firewall rules, so nothing is open to
the internet.
