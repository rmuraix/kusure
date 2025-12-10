# Terraform Configuration

This directory contains Terraform configuration for deploying the kusure application to Google Cloud Platform (GCP).

## Prerequisites

- Terraform >= 1.3
- GCP project with appropriate permissions
- Service account key file (for local development)

## Configuration

### Required Variables

- `project_id` - GCP project ID

### Optional Variables (with defaults)

- `region` - Region for resources (default: "asia-east1")
- `repository_group` - Repository group (default: "rmuraix")
- `repository_name` - Repository name (default: "kusuRe")
- `app_installation_id` - GitHub App installation ID (default: 65399203)
- `service_account_key` - Path to GCP service account key file (optional for CI)

### Sensitive Variables

The following variables are marked as sensitive and should be provided via environment variables or `.tfvars` files:

Note: `service_account_key` is a file path and is not marked as sensitive in the Terraform configuration. Only the contents of the key file are sensitive.

- `github_token` - GitHub token for accessing repositories
- `line_channel_access_token` - LINE channel access token
- `line_channel_secret` - LINE channel secret

## Usage

### Local Development

1. Set up your service account key (see `init.sh` for automation):
   ```bash
   ./init.sh <PROJECT_ID>
   ```

2. Provide variables using environment variables:
   ```bash
   export TF_VAR_project_id="your-project-id"
   export TF_VAR_github_token="your-github-token"
   export TF_VAR_line_channel_access_token="your-line-token"
   export TF_VAR_line_channel_secret="your-line-secret"
   export TF_VAR_service_account_key="terraform-key.json"
   ```

3. Or create a `terraform.tfvars` file (gitignored):
   ```hcl
   project_id                  = "your-project-id"
   github_token                = "your-github-token"
   line_channel_access_token   = "your-line-token"
   line_channel_secret         = "your-line-secret"
   service_account_key         = "terraform-key.json"
   ```

4. Run Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### CI/CD Environment

The Terraform configuration is designed to work in CI without requiring actual credentials for validation:

```bash
terraform init -backend=false
terraform validate
terraform fmt -check
```

The CI workflow provides dummy values for sensitive variables to enable planning without actual deployment.

## Migration from env.sh

Previously, this configuration used `env.sh` to source secrets from a `.env` file. This has been replaced with standard Terraform variables for better flexibility and CI compatibility.

If you were using `env.sh`, you can migrate by:
1. Converting your `.env` file values to environment variables (prefixed with `TF_VAR_`)
2. Or creating a `terraform.tfvars` file with your values
3. The `env.sh` file is kept for reference but is no longer used by Terraform
