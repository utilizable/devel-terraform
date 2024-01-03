Development - Terraform
============
This repository serves as a template for Terraform projects, enhanced with a Makefile and Docker Compose for streamlined setup and usage.

## Table of Contents
- [Quick start](#%EF%B8%8F-quick-start)
- [Makefile stages](#-makefile-stages)
- [Template structure](#-template-structure)
- [Production Configuration](#%EF%B8%8F-production-configuration)
- [Versioning model](#-versioning-model)
  
## ⚡️ Quick start
<sup>[(Back to top)](#table-of-contents)</sup>

Clone repository, and execute:

```bash
make init
```

## 📒 Makefile stages
<sup>[(Back to top)](#table-of-contents)</sup>

- `make prune` - Wipe all docker related resources based on label (project directory name),
- `make backend` - Wrap minimal S3 backend ([MinIO](https://min.io/)) with predefinied S3 bucket (based on `TF_VAR_backend_bucket` variable),
- `make init` - Execute `terraform init` for modules located in `./terraform` inside docker container,
- `make apply` - Execute `terraform apply` for modules located in `./terraform` inside docker container,
- `make destroy` - Execute `terraform destroy` for modules located in `./terraform` inside docker container.

## 🗄 Template structure
<sup>[(Back to top)](#table-of-contents)</sup>

- `./terraform` terraform related resources, workdir for compose-containers,
- `./compose.yml` each step contains its own docker container,
- `./makefile` entrypoint,
- `./.env_local` non-production variables,
- `./.env_priv` production variables.

## ⚙️ Production Configuration
<sup>[(Back to top)](#table-of-contents)</sup>

Repository brings you posibility to provide production configuration by creating `.env_priv` file.

```ini
# .env_priv
# ------------------

# PROVIDER VARIABLES
# ------------------

TF_VAR_provider_lxd_name="your-lxd-node-name"
TF_VAR_provider_lxd_scheme="your-lxd-node-scheme"
TF_VAR_provider_lxd_address="your-lxd-node-address"
TF_VAR_provider_lxd_password="your-lxd-node-password"

# BACKEND VARIABLES
# ------------------

TF_VAR_backend_access_key="your-s3-backend-username"
TF_VAR_backend_secret_key="your-s3-backend-passowrd"
TF_VAR_backend_scheme="your-s3-backend-scheme"
TF_VAR_backend_port="your-s3-backend-port"
TF_VAR_backend_endpoint="your-s3-backend-endpoint"
TF_VAR_backend_key="your-s3-backend-tfstate-key"
TF_VAR_backend_bucket="your-s3-backend-bucket"
TF_VAR_backend_region="your-s3-backend-region"
```
You can also stroe this configuration in github actions secreat and create it during pipeline execution.

```sh
echo "${{secrets.ENV_PRIV}}" > .env_priv
```

## 🔖 Versioning model
<sup>[(Back to top)](#table-of-contents)</sup>

Versions have the format `<MAJOR>.<MINOR>(.<PATCH>)?` where:

- `<MAJOR>` Triggered manualy; from develop branch,
- `<MINOR>` Triggered automaticly after each push; from develop branch,
- `<PATCH>` Triggered automaticly after each push; from fix branch (fix/1.1.x).
