"""Create the MotherDuck database for this project if it does not exist.

Reads the token from the MOTHERDUCK_TOKEN environment variable (a Codespaces secret).
The token is never printed or written to disk.
"""
import os
import sys

import duckdb

DB_NAME = "underwriting"

if not os.environ.get("MOTHERDUCK_TOKEN"):
    sys.exit("MOTHERDUCK_TOKEN is not set. Add it as a Codespaces secret first.")

con = duckdb.connect("md:")
con.execute(f"CREATE DATABASE IF NOT EXISTS {DB_NAME}")
names = [row[0] for row in con.execute("SELECT database_name FROM duckdb_databases()").fetchall()]
print(f"MotherDuck database '{DB_NAME}' ready." if DB_NAME in names else f"'{DB_NAME}' not visible yet.")
