# CHANGELOG

## v0.2.0 (2025-09-17)

### Continuous Integration / Security

- Gate Gitleaks to run once on latest Python to avoid artifact conflicts
  ([`df33394`](https://github.com/L23P/repo-template-python/commit/df33394))
- Configure Gitleaks v2 with least-privilege and env token; add PR permissions
  ([`06b13e9`](https://github.com/L23P/repo-template-python/commit/06b13e9))
- Checkout full git history to fix PR scan ranges for Gitleaks
  ([`b925fdc`](https://github.com/L23P/repo-template-python/commit/b925fdc))
- Comply with Scorecards workflow restrictions (job-level write perms only)
  ([`1457c17`](https://github.com/L23P/repo-template-python/commit/1457c17))
- Align workflows with SSDF/Scorecards least-privilege
  ([`3fe62d8`](https://github.com/L23P/repo-template-python/commit/3fe62d8))

### Documentation

- Clarify Gitleaks: no license needed for personal repos; document single-run and full-history checkout
  ([`b925fdc`](https://github.com/L23P/repo-template-python/commit/b925fdc))
- SECURITY_BASELINE and README updates across CI/security tooling
  ([`2b341af`](https://github.com/L23P/repo-template-python/commit/2b341af))

## v0.1.0 (2025-09-14)

### Build System

- Configure setuptools for src/ layout
  ([`d92840c`](https://github.com/L23P/repo-template-python/commit/d92840c38af75eaf7152e6f6f1e3d031cb21312a))

### Chores

- Add pre-commit, dependabot, PR template, contributing, gitattributes
  ([`af751ae`](https://github.com/L23P/repo-template-python/commit/af751ae32414ef5c97b065e2e0f646d9d70791e6))

### Continuous Integration

- Improve pipeline; chore: add security/community docs, release & codeql workflows; dev:
  mypy+coverage; editor: recommendations
  ([`c589e4e`](https://github.com/L23P/repo-template-python/commit/c589e4edabae3ad9791b31aa43c396b17f9783d0))

### Documentation

- Add Keep a Changelog + README format guidance; contrib: conventional commits; pr: require
  changelog;
  ([`2745efb`](https://github.com/L23P/repo-template-python/commit/2745efbe1357a4f26f96cd2293aa03be5464a83c))

- Revamp README (clear, structured, emoji-free)
  ([`ad06977`](https://github.com/L23P/repo-template-python/commit/ad0697716bb7d2887e96fb53891c4779c67fc003))

### Features

- Bootstrap python repo template (CI, lint, tests, configs)
  ([`8f387c9`](https://github.com/L23P/repo-template-python/commit/8f387c90c088a3666866b6783372261bfe03735b))
