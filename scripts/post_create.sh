#!/usr/bin/env bash
# Creates a Python 3.12 environment in .venv with pinned packages.
# Safe to re-run any time: bash scripts/post_create.sh
set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> Installing uv (fast Python package manager)"
python3 -m pip install --quiet --user uv 2>/dev/null || python3 -m pip install --quiet uv
export PATH="$HOME/.local/bin:$PATH"

echo "==> Creating .venv with Python 3.12 (dbt 1.12 does not support 3.14 yet)"
rm -rf .venv
uv venv --quiet --python 3.12 .venv

echo "==> Installing pinned packages"
uv pip install --quiet --python .venv/bin/python -r requirements.txt

# Activate the environment in every new terminal.
LINE="source /workspaces/ossie-card-underwriting/.venv/bin/activate"
grep -qxF "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc

# Remove any DuckDB 2.0 MotherDuck extension cached by an earlier install.
rm -rf ~/.duckdb/extensions/v2.*

echo "==> Fetching the Apache Ossie spec and examples (read-only reference)"
REF_DIR="/workspaces/ossie-reference"
[ -d "$REF_DIR" ] || git clone --quiet --depth 1 https://github.com/apache/ossie.git "$REF_DIR" \
  || echo "    Could not clone apache/ossie; retry later."

echo "==> Done. Open a NEW terminal (or run: source .venv/bin/activate), then: bash scripts/check_setup.sh"
