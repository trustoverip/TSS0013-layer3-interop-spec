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

all: clean build

# -----------------------------------------------------------------------------
# Targets
# -----------------------------------------------------------------------------

# Virtual environment
venv:
	pip3 install virtualenv
	virtualenv venv

# Distribution files
dist:
	mkdir -p $@

# Assets for combined document
dist/assets: docs/assets $(shell find docs/assets)
	cp -r $< $@

# Combined document
dist/index.md: dist mkdocs.yml $(shell find docs -name "*.md")
	./scripts/combine.sh > $@

# -----------------------------------------------------------------------------
# Rules
# -----------------------------------------------------------------------------

# Set up the development environment
setup: venv
	. ./venv/bin/activate
	pip3 install -r requirements.txt

# Clean all build files
clean:
	rm -rf dist site

# Build documentation
build:
	mkdocs build

# Serve documentation on localhost
serve:
	mkdocs serve

# Create combined document
combine: dist/index.md dist/assets

# -----------------------------------------------------------------------------

# Special targets
.PHONY: setup clean build serve combine
.FORCE:
