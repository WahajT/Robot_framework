#!/usr/bin/env bash
# Task runner for this Robot Framework project (a make-free alternative to the Makefile).
#
#   ./run.sh install        create .venv and install dependencies
#   ./run.sh test           run every suite under tests/
#   ./run.sh smoke          run tests tagged 'smoke'  (no browser / network)
#   ./run.sh api            run tests tagged 'api'    (needs network)
#   ./run.sh ui             run tests tagged 'ui'     (needs a browser)
#   ./run.sh lint           static analysis with Robocop
#   ./run.sh format         auto-format suites with Robocop
#   ./run.sh clean          delete results/
#
# Any extra arguments are forwarded to 'robot', e.g.
#   ./run.sh test --variable BROWSER:firefox tests/ui/

set -euo pipefail
cd "$(dirname "$0")"

VENV=.venv
BIN="$VENV/bin"
ROBOT=("$BIN/robot" --argumentfile robot.args)
SOURCES=(tests resources libraries)

cmd=${1:-help}
shift || true

case "$cmd" in
  install)
    python3 -m virtualenv "$VENV"
    "$BIN/pip" install -r requirements.txt
    ;;
  test)   "${ROBOT[@]}" "${@:-tests}" ;;
  smoke)  "${ROBOT[@]}" --include smoke "${@:-tests}" ;;
  api)    "${ROBOT[@]}" --include api   "${@:-tests}" ;;
  ui)     "${ROBOT[@]}" --include ui    "${@:-tests}" ;;
  lint)   "$BIN/robocop" check  "${@:-${SOURCES[@]}}" ;;   # shellcheck disable=SC2145
  format) "$BIN/robocop" format "${@:-${SOURCES[@]}}" ;;   # shellcheck disable=SC2145
  clean)  rm -rf results/* ;;
  help|*)
    sed -n '2,14p' "$0" | sed 's/^# \{0,1\}//'
    ;;
esac
