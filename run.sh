#!/usr/bin/env bash
# Judgement - Card Game Scorer
# Launches the scorer in your default browser

set -e

# Resolve the directory this script lives in (handles symlinks and spaces)
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
GAME_FILE="${SCRIPT_DIR}/index.html"

if [ ! -f "${GAME_FILE}" ]; then
  echo "Error: Could not find ${GAME_FILE}"
  exit 1
fi

echo "Launching Judgement scorer..."
echo "File: ${GAME_FILE}"

# Cross-platform open
case "$(uname -s)" in
  Darwin)
    open "${GAME_FILE}"
    ;;
  Linux)
    if command -v xdg-open >/dev/null 2>&1; then
      xdg-open "${GAME_FILE}"
    elif command -v gnome-open >/dev/null 2>&1; then
      gnome-open "${GAME_FILE}"
    else
      echo "Could not find xdg-open. Open this file manually in your browser:"
      echo "  ${GAME_FILE}"
    fi
    ;;
  CYGWIN*|MINGW*|MSYS*)
    start "" "${GAME_FILE}"
    ;;
  *)
    echo "Unrecognized OS. Open this file manually in your browser:"
    echo "  ${GAME_FILE}"
    ;;
esac
