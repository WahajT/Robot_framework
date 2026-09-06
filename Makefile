# Robot Framework project tasks.
# All commands run inside the project virtualenv (.venv).

VENV    := .venv
BIN     := $(VENV)/bin
ROBOT   := $(BIN)/robot --argumentfile robot.args
TESTS   ?= tests

.PHONY: help install test smoke api ui lint format clean

help:
	@echo "make install   - create .venv and install dependencies"
	@echo "make test      - run every suite under $(TESTS)/"
	@echo "make smoke     - run tests tagged 'smoke' (no browser / network)"
	@echo "make api       - run tests tagged 'api' (needs network)"
	@echo "make ui        - run tests tagged 'ui' (needs a browser)"
	@echo "make lint      - static analysis with Robocop"
	@echo "make format    - auto-format suites with Robotidy"
	@echo "make clean     - delete results/"

install:
	python3 -m virtualenv $(VENV)
	$(BIN)/pip install -r requirements.txt

test:
	$(ROBOT) $(TESTS)

smoke:
	$(ROBOT) --include smoke $(TESTS)

api:
	$(ROBOT) --include api $(TESTS)

ui:
	$(ROBOT) --include ui $(TESTS)

lint:
	$(BIN)/robocop check $(TESTS) resources libraries

format:
	$(BIN)/robocop format $(TESTS) resources

clean:
	rm -rf results/*
