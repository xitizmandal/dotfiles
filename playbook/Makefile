SHELL := /bin/bash

# The directory of this file
DIR := $(shell echo $(shell cd "$(shell  dirname "${BASH_SOURCE[0]}" )" && pwd ))

# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

deploy: ## Run all roles
	ansible-playbook --ask-become-pass -i "localhost," -c local deploy.yml

dryrun: # dryrun
	ansible-playbook --ask-become-pass -i "localhost," -c local deploy.yml --check
ansible: ## Install ansible
	if which pacman; then \
		sudo pacman --noconfirm -S ansible; \
	elif which apt-add-repository; then \
		sudo apt-get update && \
		sudo apt-get install -y ansible; \
fi

apps: ## Run all roles
	ansible-playbook --ask-become-pass -i "localhost," -c local deploy_applications.yml

test: ## Perform travis tests
	ansible-playbook -i "localhost," -c local .deployTest.yml
