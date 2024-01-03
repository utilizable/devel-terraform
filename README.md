Development - Terraform
============
This repository serves as a template for Terraform projects, enhanced with a Makefile and Docker Compose for streamlined setup and usage.

## 🪜 Repository Structure
> [utilizable/github-actions-semver-tagging](https://github.com/utilizable/github-actions-semver-tagging)
>> [utilizable/terraform-development](https://github.com/utilizable/terraform-development)

## Table of Contents
- [Requirements](#-requirements)
- [Quick start](#%EF%B8%8F-quick-start)
- [Module options](#-module-options)
- [Configuration](#%EF%B8%8F-configuration)
- [Makefile stages](#-make-stages)
- [Repository structure](#-repository-structure)
- [Versioning model](#-versioning-model)

## 🧰 Requirements
<sup>[(Back to top)](#table-of-contents)</sup>

Make sure you install both the docker engine (which already includes the built-in docker compose) and make.

  - `Docker` - https://docs.docker.com/desktop/install/
  - `Make` - https://ftp.gnu.org/gnu/make/

## ⚡️ Quick start
<sup>[(Back to top)](#table-of-contents)</sup>

  1. Clone repository
  2. adjust `.env_development`
  3. execute `make init`

## 📔 Module Options
<sup>[(Back to top)](#table-of-contents)</sup>

Module is based on [terraform-lxd/lxd](https://registry.terraform.io/providers/terraform-lxd/lxd/latest/docs) provider.

#### Options
```tf
  container_name = "test"
  container_img  = "ubuntu" 
```

## ⚙️ Configuration
<sup>[(Back to top)](#table-of-contents)</sup>

Each compose stages have access to variables definied in:

- [.env_development](./env_development) - Development-related variables, lower prio,
- [.env_production](./env_production) - Production-related variables, higher prio.

You can also store `.env_prod` configuration as github secreat and create coresponding file during pipeline execution.

```sh
- name: Terraform apply
  run: |
    echo "${{ secrets.ENV_PRODUCTION }}" > .env_prod
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

## 🗄 Repository structure
<sup>[(Back to top)](#table-of-contents)</sup>

- `./terraform` terraform related resources, workdir for compose-containers,
- `./compose.yml` each step contains its own docker container,
- `./makefile` entrypoint,
- `./.env_test` non-production variables,
- `./.env_prod` production variables.

## 🔖 Versioning model
<sup>[(Back to top)](#table-of-contents)</sup>

Versions have the format `<MAJOR>.<MINOR>(.<PATCH>)?` where:

- `<MAJOR>` Triggered manualy from develop branch,
- `<MINOR>` Triggered automaticly after each push from develop branch,
- `<PATCH>` Triggered automaticly after each push from fix/A.B.C branch.
