.PHONY: test

IP=`hostname -I | cut -f1 -d' '`
IMAGE_NAME=local/php-uk-2023
IMAGE_TAG_BASE=base
IMAGE_TAG_DEV=development

COMPOSER_CMD=docker run --rm -v ${PWD}:/app -w /app $(IMAGE_NAME):$(IMAGE_TAG_DEV) composer

all: help

help: ## List all available tasks in this Makefile
	@echo "╔══════════════════════════════════════════════════════════════════════════════╗"
	@echo "║                           ${CYAN}.:${RESET} AVAILABLE COMMANDS ${CYAN}:.${RESET}                           ║"
	@echo "╚══════════════════════════════════════════════════════════════════════════════╝"
	@echo ""
	@grep -E '^[a-zA-Z_0-9%-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "${COMMAND_COLOR}%-40s${RESET} ${HELP_COLOR}%s${RESET}\n", $$1, $$2}'
	@echo ""

build: build-container composer-install

build-container:
	docker build --build-arg IP=$(IP) --target development -t $(IMAGE_NAME):$(IMAGE_TAG_DEV) .

test:
	docker run -ti -v ${PWD}:/code -w /code -p 8080:8080 $(IMAGE_NAME):$(IMAGE_TAG_DEV) php vendor/bin/phpunit --colors=always --no-coverage

composer-install:
	${COMPOSER_CMD} install --verbose

composer-update:
	${COMPOSER_CMD} update --verbose

composer-require:
	${COMPOSER_CMD} require --verbose

composer-require-dev:
	${COMPOSER_CMD} require --dev --verbose
