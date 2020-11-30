# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy
# of the License at:
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING, SOFTWARE
# DISTRIBUTED UNDER THE LICENSE IS DISTRIBUTED ON AN "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
# SEE THE LICENSE FOR THE SPECIFIC LANGUAGE GOVERNING PERMISSIONS AND
# LIMITATIONS UNDER THE LICENSE.

# -----------------------------------------------------------------------------
# Makefile
#
# setup: Prepare Development and Publication environments
# rebase: Rebase local machine environment with upstream repo
# devenv: Prepare development environemnt
# pubenv: Prepare publication environemnt
# dev: Generates HTML content derived from markdown docs
# test: Runs test server using current HTML content
# combine: Generate a standalone document from multiple markdown files
# publish: Generate HTML and PDF versions of content
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Special targets
# -----------------------------------------------------------------------------

.PHONY: help clean
.DEFAULT_GOAL: help

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

REPO_NAME ?= mkdocs-material
UPSTREAM_REPO ?= https://github.com/trustoverip/mkdocs-material.git
DEV_IMAGE ?= trustoverip/mkdocs-material-devenv
PANDOCS_IMAGE ?= trustoverip/pandocs-devenv
DEV_SITE_PORT ?= 7500
DEV_HOST_DIR ?= host_mkdocs
PUB_HOST_DIR ?= host_pandocs
PUBLISH_DIR ?= publish

# -----------------------------------------------------------------------------
# All Purpose Commands
# -----------------------------------------------------------------------------

help:
	@echo "\n"$(REPO_NAME)"\n"
	@(grep -h "##" Makefile  | tail -8) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# -----------------------------------------------------------------------------
# Targets
# -----------------------------------------------------------------------------

# Clean all build files
clean:
	rm -rf $(PUBLISH_DIR)

# Prepare Git environment
prepare_git:
	git remote add upstream $(UPSTREAM_REPO); git remote

# Build all required Docker images
build_images: Dockerfile
	docker build -t $(DEV_IMAGE) - < ./docker/mkdocs/Dockerfile
	docker build -t $(PANDOCS_IMAGE) - < ./docker/pandocs/Dockerfile
	docker images | head -3

# Publication directory
prepare_pandocs:
	mkdir -p $(PUBLISH_DIR)
	chmod +x ./scripts/combine.sh; ls -la ./scripts/
	chmod +x ./scripts/combine/preprocess.py; ls -la scripts/combine/

# -----------------------------------------------------------------------------
# Local Environment (Docker Host) Commands
# -----------------------------------------------------------------------------

setup: prepare_git build_images ## Prepare Development and Publication environments

rebase: ## Rebase local machine environment with upstream repo
	git fetch upstream
	git rebase upstream/master; git rebase upstream/main

devenv: ## Prepare development environemnt
	docker run -ti -v ${PWD}:/$(DEV_HOST_DIR) -p $(DEV_SITE_PORT):8000 --entrypoint=/bin/bash $(DEV_IMAGE)

pubenv: clean prepare_pandocs ## Prepare print environemnt
	docker run -ti -v ${PWD}:/$(PUB_HOST_DIR) --entrypoint=/bin/bash $(PANDOCS_IMAGE)

# -----------------------------------------------------------------------------
# MkDocs Container Commands
# -----------------------------------------------------------------------------

dev : ## Generates HTML content derived from markdown files
	mkdocs build

test : ## Run test server using current HTML content
	@echo "Launching Test Server for access via http://localhost:"$(DEV_SITE_PORT)
	mkdocs serve --dev-addr=0.0.0.0:8000

# -----------------------------------------------------------------------------
# PanDoc Container Commands
# -----------------------------------------------------------------------------

combine: mkdocs.yml $(shell find docs -name "*.md") ## Generate standalone document
	./scripts/combine.sh > $(PUBLISH_DIR)/$(REPO_NAME).md

publish: combine ## Generate publication formats (HTML, PDF)
	pandoc $(PUBLISH_DIR)/$(REPO_NAME).md -o $(PUBLISH_DIR)/$(REPO_NAME).html
	pandoc $(PUBLISH_DIR)/$(REPO_NAME).md --pdf-engine=xelatex -o $(PUBLISH_DIR)/$(REPO_NAME).pdf
	ls -la $(PUBLISH_DIR)
