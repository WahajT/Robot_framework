# Robot Framework

Test automation project built on [Robot Framework](https://robotframework.org/) 7.

## Layout

| Path                | Purpose                                                        |
| ------------------- | ------------------------------------------------------------- |
| `tests/`            | Test suites (`*.robot`), grouped by kind (`api/`, `ui/`, …)  |
| `resources/`        | Reusable keywords / imports (`*.resource`)                   |
| `libraries/`        | Custom keyword libraries written in Python                   |
| `variables/`        | Variable files (environment config, etc.)                    |
| `results/`          | Generated `output.xml` / `log.html` / `report.html` (ignored) |
| `robot.args`        | Default `robot` arguments (output dir, `--pythonpath`, …)    |
| `pyproject.toml`    | Robocop (lint + format) configuration                        |
| `run.sh`            | Task runner (no dependencies)                                |
| `Makefile`          | Same tasks for `make` users (optional; `make` not installed here) |

## Setup

The machine had no `pip`/`venv`, so the virtualenv was bootstrapped with the
`virtualenv` package. To recreate it from scratch:

```bash
python3 -m pip install --user virtualenv    # once; if pip itself is missing, bootstrap with get-pip.py
./run.sh install                            # creates .venv and installs requirements.txt
```

Equivalently, by hand:

```bash
python3 -m virtualenv .venv
.venv/bin/pip install -r requirements.txt
```

`requirements.txt` holds the intended, commented dependencies;
`requirements.lock.txt` is the full `pip freeze` for exact reproduction.

## Running tests

```bash
./run.sh test        # every suite under tests/
./run.sh smoke       # tag: smoke  — no browser, no network
./run.sh api         # tag: api    — needs internet (hits jsonplaceholder.typicode.com)
./run.sh ui          # tag: ui     — needs Chrome or Firefox installed
```

(`make test`, `make smoke`, … do the same if you have `make`.)

Under the hood each target runs:

```bash
.venv/bin/robot --argumentfile robot.args --include <tag> tests/
```

Run one suite or pass extra flags directly:

```bash
.venv/bin/robot --argumentfile robot.args tests/01_smoke.robot
.venv/bin/robot --argumentfile robot.args --variable BROWSER:firefox tests/ui/
```

Open `results/log.html` after a run for the detailed report.

### Browser tests

`SeleniumLibrary` uses Selenium 4's built-in **Selenium Manager**, which downloads
the matching driver automatically on first run — no `chromedriver` to install.
A real browser must be present. `BROWSER` defaults to `headlesschrome`
(see `variables/environments.py`); override with `--variable BROWSER:chrome`.

### Environments

`variables/environments.py` selects a base URL from the `TEST_ENV` env var
(`dev` / `staging` / `prod`, default `dev`):

```bash
TEST_ENV=staging make api
```

## Lint & format

```bash
./run.sh lint      # robocop check
./run.sh format    # robocop format  (rewrites files in place)
```

Robocop config lives in `pyproject.toml`.
