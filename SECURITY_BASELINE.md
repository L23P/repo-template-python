# DevSecOps Baseline (Lean)

This repo intentionally keeps security automation focused and minimal. It aligns to widely adopted guidance:

- NIST Secure Software Development Framework (SSDF) v1.1: Practices PS, PW, RV, and PO
- OpenSSF Scorecards: Automated checks for supply-chain hygiene

Scope and mapping:

- PS.1: Define security requirements → Linting/typing gates in CI; documented here
- PW.4: Analyze code for vulnerabilities → CodeQL + Bandit (SAST)
- PW.5: Manage dependencies → Dependabot + pip-audit
- PW.6: Build integrity → Reproducible builds via `pyproject.toml`; SBOM via CycloneDX
- RV.1: Identify and confirm vulnerabilities → CI fails on audit findings; CodeQL alerts
- RV.2: Assess and remediate → PRs require passing checks; tracked via GitHub Security
- PO.1/2: Vulnerability reporting and disclosure → `SECURITY.md`

Included automation:

- CI: ruff, black --check, mypy, pytest+coverage (>=80%), Bandit, pip-audit, SBOM artifact
- CodeQL: GitHub-native SAST
- Dependabot: Weekly updates for pip and GitHub Actions
- Scorecards: Supply-chain posture with SARIF upload
- Gitleaks: Secrets scanning in CI

Intentionally out of scope (to avoid bloat):

- Release automation and changelog generation beyond basic tagging (optional)
- Multi-cloud deployment scaffolding
- Complex policy-as-code; add per-organization as needed

How to run locally:

- Format/lint: `ruff check .`; `black --check .`
- Types: `mypy src`
- Tests: `pytest -q`
- SAST: `bandit -r src -x tests`
- Dependency audit: `pip-audit`
- SBOM: `cyclonedx-py -o sbom.json -e`
