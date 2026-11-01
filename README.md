# Credit Card Application Underwriting — an Apache Ossie semantic model

A Kimball dimensional model of credit card application underwriting, expressed as an
[Apache Ossie](https://ossie.apache.org) semantic model and built with dbt on MotherDuck.

**Goal:** one vendor-neutral definition of underwriting metrics (approval rate, time to decision,
approved credit exposure) that every BI tool and AI agent reads the same way.

> Status: **S1 complete — workspace set up.** Modeling begins in S3.
> All data in this repository is synthetic. No real applicant information is used.

## Run it

Open in GitHub Codespaces (**Code → Codespaces → Create codespace**), add a `MOTHERDUCK_TOKEN`
Codespaces secret, then:

```bash
bash scripts/check_setup.sh
```

## Repository layout

| Path | Contents |
| --- | --- |
| `.devcontainer/` | Cloud workspace definition |
| `models/` | dbt staging and mart models (star schema) |
| `osi/` | Apache Ossie semantic model documents |
| `snapshots/` | SCD Type 2 snapshots |
| `scripts/` | Setup checks and synthetic data generator |
| `docs/` | Design notes, spec version pin, findings |

## Stack

dbt Core 1.12 (native Ossie support) · dbt-duckdb · MotherDuck · GitHub Codespaces ·
Apache Ossie spec 0.1.1 (see `docs/spec-version.md`).

Apache Ossie is an effort undergoing incubation at The Apache Software Foundation.
