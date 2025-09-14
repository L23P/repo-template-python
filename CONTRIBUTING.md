# Contributing

Thanks for contributing! To get started:

1. Create a virtual environment and install dev deps:

   ```powershell
   python -m venv .venv
   . .venv/Scripts/Activate.ps1
   pip install -r requirements-dev.txt
   ```

2. Install pre-commit hooks:

   ```powershell
   pip install pre-commit
   pre-commit install
   ```

3. Run checks locally:

   ```powershell
   ruff check .
   black --check .
   pytest -q
   ```

Please open a draft PR early for feedback. Make sure CI passes before requesting review.

## Commit messages and changelog

- Follow Conventional Commits: https://www.conventionalcommits.org/en/v1.0.0/
   - Examples: `feat: add new subcommand`, `fix: handle empty input gracefully`, `docs: update README`
- Update `CHANGELOG.md` when user-facing changes are introduced. Group entries under Added/Changed/Fixed/Removed.
