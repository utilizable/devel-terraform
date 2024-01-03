Development - Terraform
============
This repository serves as a template for Terraform projects, enhanced with a Makefile and Docker Compose for streamlined setup and usage.

## Table of Contents
- [Quick start](#%EF%B8%8F-quick-start)
- [Configuration](#%EF%B8%8F-configuration)
- [Makefile stages](#-make-stages)
- [Template structure](#-template-structure)
- [Versioning model](#-versioning-model)
  
## ⚡️ Quick start
<sup>[(Back to top)](#table-of-contents)</sup>

Clone repository, and execute:

```bash
make init
```

## ⚙️ Configuration
<sup>[(Back to top)](#table-of-contents)</sup>

Each of compose-stages are able to consume following environment variables, `.env_prod` overrides variables from `.env_test` 

- [.env_test](./env_test) - testing related variables,
- [.env_prod](./env_prod) - production related variables

You can also store `.env_prod` configuration as github secreat and create coresponding file during pipeline execution.

```sh
- name: Terraform apply
  run: |
    echo "${{secrets.ENV_PROD}}" > .env_prod
    make apply
```

## 📒 Make stages
<sup>[(Back to top)](#table-of-contents)</sup>

Stages definied in makefile.

- `make prune` - Wipe all docker-related resources associated with the current project,
- `make backend` - Setup [MinIO](https://min.io/) S3 backend with pre-definied bucket (`TF_VAR_backend_bucket` variable based),
- `make init` - Execute `terraform init` for modules located in `./terraform` inside docker container,
- `make apply` - Execute `terraform apply` for modules located in `./terraform` inside docker container,
- `make destroy` - Execute `terraform destroy` for modules located in `./terraform` inside docker container.

## 🗄 Template structure
<sup>[(Back to top)](#table-of-contents)</sup>

- `./terraform` terraform related resources, workdir for compose-containers,
- `./compose.yml` each step contains its own docker container,
- `./makefile` entrypoint,
- `./.env_test` non-production variables,
- `./.env_prod` production variables.

## 🔖 Versioning model
<sup>[(Back to top)](#table-of-contents)</sup>

Versions have the format `<MAJOR>.<MINOR>(.<PATCH>)?` where:

- `<MAJOR>` Triggered manualy; from develop branch,
- `<MINOR>` Triggered automaticly after each push; from develop branch,
- `<PATCH>` Triggered automaticly after each push; from fix branch (fix/1.1.x).
