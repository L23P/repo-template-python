# Python Repo Template

A clean, reusable template to bootstrap new Python projects with tests, linting, formatting, CI, and sensible defaults.

## Features

- Ready-to-run GitHub Actions CI (lint + tests)
- ruff + black wired for lint/format
- pytest configured with example tests
- Preconfigured .gitignore, .editorconfig, and VS Code settings
- CODEOWNERS support
- MIT license (customize as needed)

## Quick start

1. Use this template to create a new repository on GitHub.
2. Clone your new repo locally.
3. Create a virtual environment and install dev tools.

```powershell
python -m venv .venv
. .venv/Scripts/Activate.ps1
pip install -r requirements-dev.txt
```

4. Run lint and tests.

```powershell
ruff check .
black --check .
pytest -q
```

## Customize

- Update `pyproject.toml` (name, version, tooling)
- Edit `README.md` and `LICENSE`
- Adjust `CODEOWNERS` to your team
- Add or modify workflows under `.github/workflows`

## Project layout

```
repo-template-python/
  .github/
    CODEOWNERS
    workflows/
      ci.yml
  .vscode/
    settings.json
  src/
    project_template/
      __init__.py
  tests/
    test_sample.py
  .editorconfig
  .gitignore
  LICENSE
  pyproject.toml
  README.md
  requirements.txt
  requirements-dev.txt
```
