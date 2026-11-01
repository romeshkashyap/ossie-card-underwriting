#!/usr/bin/env bash
# S1 acceptance check. Each step prints PASS or FAIL.
# Usage: bash scripts/check_setup.sh            (MotherDuck, the default)
#        bash scripts/check_setup.sh local      (local DuckDB file, no account needed)
set -uo pipefail

TARGET="${1:-dev}"
FAILED=0
pass() { echo "  PASS  $1"; }
fail() { echo "  FAIL  $1"; FAILED=1; }

echo "S1 setup check (target: $TARGET)"

python --version >/dev/null 2>&1 && pass "Python $(python --version 2>&1 | cut -d' ' -f2)" || fail "Python not found"

DBT_VER=$(python -c "from importlib.metadata import version; print(version('dbt-core'))" 2>/dev/null)
if [[ "$DBT_VER" =~ ^1\.1[2-9]\. ]]; then
  pass "dbt Core $DBT_VER (Ossie support needs 1.12+)"
else
  fail "dbt Core 1.12+ not found. Run: bash scripts/post_create.sh, then open a new terminal"
fi

python -c "import dbt.adapters.duckdb" 2>/dev/null && pass "dbt-duckdb adapter" || fail "dbt-duckdb not installed"

DUCK=$(python -c "import duckdb;print(duckdb.__version__)" 2>/dev/null)
case "$DUCK" in 1.5.*) pass "DuckDB $DUCK (MotherDuck-compatible)";; *) fail "DuckDB ${DUCK:-missing}; MotherDuck needs 1.5.x. Run: bash scripts/post_create.sh";; esac

if [ "$TARGET" = "dev" ]; then
  if [ -n "${MOTHERDUCK_TOKEN:-}" ]; then
    pass "MOTHERDUCK_TOKEN is set (value hidden)"
    if python scripts/create_motherduck_db.py >/dev/null 2>&1; then
      pass "MotherDuck database 'underwriting' reachable"
    else
      fail "Could not reach MotherDuck. See the error with: python scripts/create_motherduck_db.py"
    fi
  else
    fail "MOTHERDUCK_TOKEN not set. Add it as a Codespaces secret, then rebuild or restart the Codespace"
  fi
fi

if dbt debug --target "$TARGET" >/dev/null 2>&1; then pass "dbt debug"; else fail "dbt debug (run 'dbt debug --target $TARGET' to see why)"; fi
if dbt run --target "$TARGET" --select smoke >/dev/null 2>&1; then pass "dbt run smoke model"; else fail "dbt run smoke model"; fi

if git ls-files 2>/dev/null | grep -v '^scripts/check_setup.sh$' \
   | xargs grep -lE "motherduck_token=|eyJ[A-Za-z0-9_-]{20,}" 2>/dev/null | grep -q .; then
  fail "A file tracked by git looks like it contains a token"
else
  pass "No tokens found in tracked files"
fi

echo
if [ "$FAILED" -eq 0 ]; then echo "S1 complete: all checks passed."; else echo "Some checks failed; see above."; exit 1; fi
