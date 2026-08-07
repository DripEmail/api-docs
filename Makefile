BUILD_DIR    := build
PORT         ?= 4567
PREVIEW_PORT ?= 4568

.DEFAULT_GOAL := help

.PHONY: help install serve build check preview deploy clean distclean

help: ## List the available targets
	@awk 'BEGIN{FS=":.*## "} /^[a-z][a-z-]*:.*## /{printf "  %-10s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install gems into vendor/bundle
	bundle check || bundle install

serve: install ## Run the Middleman dev server (PORT, default 4567)
	bundle exec middleman server --port $(PORT)

build: install ## Build the static site into build/
	bundle exec middleman build --clean

check: build ## Verify the site builds

preview: build ## Serve the built site (PREVIEW_PORT, default 4568)
	python3 -m http.server --directory $(BUILD_DIR) $(PREVIEW_PORT)

deploy: clean install ## Build and push the site to the gh-pages branch
	bundle exec middleman deploy

clean: ## Remove build output and caches
	rm -rf $(BUILD_DIR) .sass-cache .cache

distclean: clean ## Also remove installed gems
	rm -rf vendor/bundle .gem
