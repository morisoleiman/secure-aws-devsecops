# Security Policy

## Reporting

Please report suspected vulnerabilities privately through GitHub Security Advisories rather than opening a public issue.

## Rules

- Never commit AWS access keys, secret keys, passwords, private keys, tokens, or Terraform state.
- Use GitHub OIDC for AWS authentication.
- Keep production deployment behind a protected GitHub Environment.
- Treat HIGH and CRITICAL dependency or container findings as release blockers unless explicitly reviewed and accepted.
