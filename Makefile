########################################
#### Minimal Python DevEx Makefile ####
########################################

## Source locations
MODULE_BASE_DIR = src/gha_py_app
TESTS_BASE_DIR = tests

## Python configuration
PYTHON_VERSION_FILE = .python-version
PYTHON_EXEC ?= python3
POETRY_PATH = $(shell command -v poetry)
ifeq ("$(POETRY_PATH)","")
POETRY_TASK = install-poetry
else
POETRY_TASK =
endif

## Tool commands
POETRY ?= poetry
RUFF ?= $(POETRY) run ruff
PYTEST ?= $(POETRY) run pytest

## Colors for output
COLOR_ORANGE = \033[33m
COLOR_BLUE = \033[34m
COLOR_RED = \033[31m
COLOR_GREEN = \033[32m
COLOR_RESET = \033[0m

###
### TASKS
###

.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Development

.PHONY: deps
deps: $(POETRY_TASK) poetry-install ## Install all dependencies
	@echo "$(COLOR_GREEN)All dependencies installed!$(COLOR_RESET)"

.PHONY: check
check: check-py-ruff-format check-py-ruff-lint ## Run all checks
	@echo "$(COLOR_GREEN)All checks passed!$(COLOR_RESET)"

.PHONY: check-py-ruff-lint
check-py-ruff-lint: ## Run ruff linter
	$(RUFF) check $(MODULE_BASE_DIR) $(TESTS_BASE_DIR) || \
		(echo "$(COLOR_RED)Run 'make fix' to fix some issues automatically$(COLOR_RESET)" && false)

.PHONY: check-py-ruff-format
check-py-ruff-format: ## Run ruff formatter check
	$(RUFF) format --check .

.PHONY: fix
fix: ## Fix linting and formatting issues
	$(RUFF) check --fix $(MODULE_BASE_DIR) $(TESTS_BASE_DIR)
	$(RUFF) format .

.PHONY: test
test: ## Run tests with coverage
	$(PYTEST) $(TESTS_BASE_DIR)
	@echo "$(COLOR_GREEN)Tests passed!$(COLOR_RESET)"

.PHONY: build
build: poetry-build ## Build the package
	@echo "$(COLOR_GREEN)Build complete!$(COLOR_RESET)"

##@ Poetry

.PHONY: install-poetry
install-poetry: ## Install Poetry
	@echo "$(COLOR_ORANGE)Installing Poetry from python-poetry.org$(COLOR_RESET)"
	curl -sSL https://install.python-poetry.org | $(PYTHON_EXEC) -

.PHONY: poetry-install
poetry-install: ## Run poetry install
	$(POETRY) install

.PHONY: poetry-update
poetry-update: ## Update dependencies
	$(POETRY) update -v

.PHONY: poetry-build
poetry-build: ## Build package with Poetry
	$(POETRY) build

##@ Cleanup

.PHONY: clean
clean: ## Clean build artifacts
	rm -rf build/ dist/ *.egg-info .pytest_cache .coverage htmlcov/ .ruff_cache
	find . -type d -name __pycache__ -exec rm -rf {} +
	@echo "$(COLOR_GREEN)Cleaned!$(COLOR_RESET)"
