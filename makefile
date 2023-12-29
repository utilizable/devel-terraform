# EXECUTABLES
EXE_COMPOSE := docker compose

# FILES
FILE_COMPOSE := compose.yml
FILE_BACKEND := backend.yml
FILE_ENV 		 := .env

# PATH
PATH_COMPOSE := $(CURDIR)/$(FILE_COMPOSE)
PATH_BACKEND := $(CURDIR)/$(FILE_BACKEND)
PATH_ENV		 := $(CURDIR)/$(FILE_ENV)

# COMMANDS
CMD_COMPOSE := $(EXE_COMPOSE) -f $(PATH_COMPOSE)

.PHONY: default
default:
	@$(CMD_COMPOSE) down --volumes

init: default 
	@$(CMD_COMPOSE) up init 

plan: init 
	@$(CMD_COMPOSE) up plan 

apply: plan 
	@$(CMD_COMPOSE) up apply 

destroy:
	$(CMD_COMPOSE) up destroy 

backend:
	$(EXE_COMPOSE) up backend 
