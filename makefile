# VARIABLES
# ------------------

DOCKER_LABEL_KEY := project

# Relative path of current directory
DOCKER_LABEL_VALUE := $(notdir $(patsubst %/,%,$(CURDIR)))

# EXECUTABLES
# ------------------

EXE_COMPOSE := docker compose

# FILES
# ------------------

FILE_COMPOSE := compose.yml
FILE_ENV_DEV := .env_development
FILE_ENV_PROD := .env_production

# PATH
# ------------------

# path to docker compose definition
PATH_COMPOSE := $(CURDIR)/$(FILE_COMPOSE)

# path to .env_development file
PATH_ENV_DEV := $(CURDIR)/$(FILE_ENV_TEST)

# path to .env_production file
PATH_ENV_PROD := $(CURDIR)/$(FILE_ENV_PRIV)

# COMMANDS
# ------------------

# docker compose script string, ready to evaluate in make stages
CMD_COMPOSE := LABEL_KEY="$(DOCKER_LABEL_KEY)" LABEL_VALUE="$(DOCKER_LABEL_VALUE)" $(EXE_COMPOSE) -f $(PATH_COMPOSE) --env-file $(PATH_ENV_DEV) --env-file $(PATH_ENV_PROD)

# List all docker resources which contains specyfic label
CMD_CONTAINERS := docker ps -aq --filter "label=$(DOCKER_LABEL)"

# MAKE STAGES
# ------------------

# Prune all docker-related resources witch project-label
prune:
	@docker stop $(shell $(CMD_CONTAINERS)) 2>/dev/null || true
	@docker rm -f $(shell $(CMD_CONTAINERS)) 2>/dev/null || true
	@docker volume prune -f $(shell $(CMD_CONTAINERS)) 2>/dev/null || true
	@docker network prune -f $(shell $(CMD_CONTAINERS)) 2>/dev/null || true
	@docker image prune -f $(shell $(CMD_CONTAINERS)) 2>/dev/null || true

# Start minio S3 backend, also initialize S3 bucket.
backend:
	-@($(CMD_COMPOSE) up -d backend)
	-@($(CMD_COMPOSE) up -d backend-init)

# Execute terraform fmt for each *.tf file inside ./terraform directory
fmt:
	-@($(CMD_COMPOSE) up fmt)

# Initialize terraform backend, passing to it variables form .env_test and .env_prod
init: backend
	-@($(CMD_COMPOSE) up init)

# Apply resource
apply: init
	-@($(CMD_COMPOSE) up apply)

# Destroy resource
destroy: 
	-@($(CMD_COMPOSE) up destroy)
