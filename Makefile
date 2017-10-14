.PHONY: install requirements build-doc

TECH_DIR=technology
VENV_DIR=$(CURDIR)/venv

build-doc:
	$(MAKE) -C $(TECH_DIR) html

requirements:
	@echo "Analyzing requirements..."
	@sleep 2
	@if [[ -z $$(which python3) ]]; then echo "The command python3 was not found"; exit 1; else echo "Requirements: OK"; fi

install: requirements
	@echo "Installing enviroment..."
	@python3 -m venv $(VENV_DIR)
	@echo "Activating virtualenv" && \
	source "$(VENV_DIR)/bin/activate" && \
	echo "Installing python packages required" && \
	pip install -r requirements.txt && \
	echo "Deactivating virtualenv" && \
	deactivate
