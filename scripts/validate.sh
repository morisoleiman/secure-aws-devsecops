#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python -m compileall -q app tests
python -m unittest discover -s tests -p 'test_*.py' -v

python - <<'PY'
from pathlib import Path

root = Path.cwd()
workflow_dir = root / '.github' / 'workflows'
for path in workflow_dir.glob('*.yml'):
    text = path.read_text()
    assert 'permissions:' in text, f'{path} has no explicit permissions'
    if 'configure-aws-credentials' in text:
        assert 'id-token: write' in text, f'{path} missing OIDC permission'
        assert 'role-to-assume:' in text, f'{path} missing role-to-assume'
        assert 'allowed-account-ids:' in text, f'{path} missing account restriction'

for path in root.glob('infrastructure/**/*.tf'):
    text = path.read_text()
    assert text.strip(), f'empty terraform file: {path}'

text_suffixes = {'.py', '.yml', '.yaml', '.tf', '.md', '.sh', '.dockerignore', '.gitignore', '.txt'}
all_text = '\n'.join(p.read_text() for p in root.rglob('*') if p.is_file() and '.git' not in p.parts and (p.suffix in text_suffixes or p.name in {'.dockerignore', '.gitignore'}))
for forbidden in ('AWS_' + 'SECRET_ACCESS_KEY', 'AWS_' + 'ACCESS_KEY_ID'):
    assert forbidden not in all_text, f'forbidden long-lived credential reference detected'

terraform = (root / 'infrastructure/terraform/main.tf').read_text()
assert 'repo:${var.github_org}@${var.github_owner_id}/${var.github_repo}@${var.github_repo_id}:environment:staging' in terraform
assert 'repo:${var.github_org}@${var.github_owner_id}/${var.github_repo}@${var.github_repo_id}:environment:production' in terraform

print('Static validation passed.')
PY
