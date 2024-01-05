
# VARIABLES
# ------------------

# .env file - override logic
ENV_FILE ?= .env 

# .env file - path
ENV_PATH := $(CURDIR)/$(ENV_FILE)

# docker compose executable 
COMPOSE_EXE := docker compose

# compose file - name
COMPOSE_FILE := compose.yml

# compose file - path
COMPOSE_PATH := $(CURDIR)/$(COMPOSE_FILE)

# finall compose command - ready for evaluate 
COMPOSE_CMD	:= $(COMPOSE_EXE) -f $(COMPOSE_PATH) --env-file $(ENV_PATH)

# STAGES
# ------------------

# Prune all resources 
prune:
	-@($(COMPOSE_CMD) down --volumes --remove-orphans)

# Start S3 backend
backend:
	-@($(COMPOSE_CMD) up -d backend)

# execute terraform fmt 
fmt:
	-@($(COMPOSE_CMD) up fmt)

# execute terraform init 
init: 
	-@($(COMPOSE_CMD) up init)

# execute terraform plan
plan: init
	-@($(COMPOSE_CMD) up plan)

# execute terraform apply 
apply: init
	-@($(COMPOSE_CMD) up apply)

# execute terraform destroy 
destroy: init
	-@($(COMPOSE_CMD) up destroy)
