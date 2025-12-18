# gha-py-app

![CI](https://github.com/banginji/gh-py-app/actions/workflows/ci.yml/badge.svg)

A minimal Python project built with the [make-python-devex](https://github.com/target/make-python-devex) pattern and automated with GitHub Actions plus the [diff-poetry-lock](https://github.com/colindean/diff-poetry-lock) action.

## Features

- **Lean DevEx**: Follows the essential Make + Poetry workflow from make-python-devex
- **GitHub Actions CI**: Single workflow orchestrating dependency install, checks, tests, and builds
- **Diff-friendly PRs**: Automatic dependency summaries on pull requests via diff-poetry-lock
- **Poetry-powered**: Modern dependency management and packaging with Poetry 2.x

## Quick Start

```bash
# Install dependencies
make deps

# Run checks, tests, and build
make check test build

# Run the application
poetry run gha-py-app
```

## Commands

- `make help` – View all targets
- `make deps` – Install and lock dependencies
- `make check` – Run Ruff lint and format checks
- `make fix` – Auto-fix lint/format issues
- `make test` – Execute pytest with coverage
- `make build` – Build the distributable package
- `make clean` – Remove build artifacts

## Project Structure

```
gha-py-app/
├── .github/workflows/ci.yml   # GitHub Actions pipeline with diff-poetry-lock
├── Makefile                   # Development workflow automation
├── pyproject.toml             # Project metadata and dependencies
├── poetry.lock                # Locked dependency versions
├── .python-version            # Tooling hint for Python 3.13
├── src/gha_py_app/__init__.py # Application module
└── tests/unit/test_main.py    # Pytest test suite
```

## GitHub Actions Pipeline

The workflow at `.github/workflows/ci.yml` runs on pushes and pull requests:

1. **build** job installs Poetry, runs `make deps check test build`, and uploads build artifacts.
2. **diff-poetry-lock** job (pull requests only) uses `colindean/diff-poetry-lock` to post a readable summary of `poetry.lock` changes back to the PR.

Both jobs share cached dependencies when possible and rely solely on the default `GITHUB_TOKEN` secret.

## Requirements

- Python 3.13+
- Poetry 2.0+
- GNU Make

## Development

- Lint/format: [Ruff](https://github.com/astral-sh/ruff)
- Tests: [pytest](https://pytest.org) with coverage reports
- Packaging: [Poetry](https://python-poetry.org)

## License

MIT
