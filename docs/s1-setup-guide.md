# S1 — Set up the cloud workspace

About 30–45 minutes, all in your browser.

## 1. Create a MotherDuck account and token

1. Sign up at https://motherduck.com (free plan).
2. Go to **Settings → Access Tokens → Create token**. Choose a read-write token.
3. Copy the token somewhere safe for the next step. Do not paste it into any file.

## 2. Create the GitHub repo

1. Sign up or sign in at https://github.com.
2. Create a new **public** repository named `ossie-card-underwriting`. Leave it empty (no README).
3. Add the starter files, using either option:
   - **Ask Claude to push them** (easiest): tell Claude the repo is created; it pushes the files for you.
   - **Upload yourself:** open a Codespace on the empty repo (step 4), drag `ossie-card-underwriting.zip`
     into the file explorer, then in the terminal run:
     `unzip ossie-card-underwriting.zip && rm ossie-card-underwriting.zip && git add -A && git commit -m "S1 starter" && git push`,
     then run **Codespaces: Rebuild Container** from the command palette.

## 3. Store the token as a Codespaces secret

1. GitHub → your avatar → **Settings → Codespaces → Secrets → New secret**.
2. Name: `MOTHERDUCK_TOKEN`. Value: your token.
3. Under **Repository access**, select `ossie-card-underwriting`.

## 4. Open the Codespace

1. On the repo page: **Code → Codespaces → Create codespace on main**.
2. Pick the **2-core** machine if asked.
3. Wait for setup to finish (2–4 minutes the first time). It installs dbt Core 1.12, dbt-duckdb,
   and clones the Apache Ossie spec to `/workspaces/ossie-reference`.

## 5. Run the acceptance check

In the Codespace terminal:

```bash
bash scripts/check_setup.sh
```

All lines should say PASS. No MotherDuck yet? `bash scripts/check_setup.sh local` checks everything else.

## 6. Protect your free quota

- Stop the Codespace when you finish: **Codespaces** menu (bottom-left) → **Stop Current Codespace**.
- GitHub → **Settings → Codespaces → Default idle timeout**: set to 15 minutes.

## Done when

- [ ] `check_setup.sh` passes all checks on the `dev` (MotherDuck) target
- [ ] The repo is public and contains no tokens
- [ ] The Codespace stops automatically when idle
