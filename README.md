# Python Repository Template

[![CI](https://github.com/L23P/repo-template-python/actions/workflows/ci.yml/badge.svg)](https://github.com/L23P/repo-template-python/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A clean, reusable template to bootstrap new Python projects with testing, linting, formatting, continuous integration, and sensible defaults.

## What’s included

| Area | Tooling / Files |
|---|---|
| Linting | ruff (configured in `pyproject.toml`) |
| Formatting | black (configured in `pyproject.toml`) |
| Testing | pytest (`tests/`, basic example) |
| CI | GitHub Actions (`.github/workflows/ci.yml`) |
| Dependency updates | Dependabot (`.github/dependabot.yml`) |
| Git hooks | pre-commit (`.pre-commit-config.yaml`) |
| Ownership | CODEOWNERS (`.github/CODEOWNERS`) |
| Editor/formatting | `.editorconfig`, `.gitattributes`, `.vscode/settings.json` |
| Packaging | `pyproject.toml` (Python ≥ 3.10) |

## Use this template

1. Create your repository from this template:
   - Open: https://github.com/L23P/repo-template-python/generate
   - Choose a name, set visibility, then create
2. Clone your new repository locally.
3. Set up your environment and developer tools.

```powershell
python -m venv .venv
. .venv/Scripts/Activate.ps1
pip install -r requirements-dev.txt
```

4. Run the checks.

```powershell
ruff check .
black --check .
pytest -q
```

5. (Optional) Enable pre-commit hooks to auto-fix issues before commit.

```powershell
pip install pre-commit
pre-commit install
```

## Development workflow

- Write code under `src/` (rename the package `project_template` to your project name).
- Add tests in `tests/` and run with `pytest`.
- Keep code clean with `ruff` and `black`.
- CI runs on pushes and pull requests to `main`.

## Continuous integration

The workflow at `.github/workflows/ci.yml` runs on Ubuntu and performs:
1. Checkout and Python setup (3.11 by default)
2. Dependency installation (`requirements*.txt` if present)
3. Linting via ruff and formatting check via black
4. Tests via pytest

You can adjust Python versions, cache settings, or add steps as needed.

## Project structure

```
repo-template-python/
  .github/
    CODEOWNERS
    dependabot.yml
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
  .gitattributes
  .gitignore
  .pre-commit-config.yaml
  CONTRIBUTING.md
  LICENSE
  pyproject.toml
  README.md
  requirements.txt
  requirements-dev.txt
```

## Customize

- Update `pyproject.toml` with your package `name`, `version`, and metadata.
- Rename the package directory from `project_template` to your chosen import name.
- Adjust `CODEOWNERS` to your user or team.
- Edit `README.md` and `LICENSE` to reflect your project.
- Modify `.github/workflows/ci.yml` for additional steps or Python versions.

## Versioning and changelog

This project follows Semantic Versioning. See the [Changelog](CHANGELOG.md) for release notes and unreleased changes.

If you adopt this template, consider following the same approach and documenting your release notes clearly.

For guidance on structuring your README effectively, see [docs/README_FORMAT.md](docs/README_FORMAT.md).

## License

This template is licensed under the MIT License. See [LICENSE](LICENSE) for details.
