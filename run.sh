#!/usr/bin/env bash
# Judgement - Card Game Scorer
# Starts a local server and launches the game in your default browser
# Usage: ./run.sh [--fresh]
#   --fresh  Clear all saved player history and start clean

set -e

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
GAME_FILE="${SCRIPT_DIR}/index.html"

if [ ! -f "${GAME_FILE}" ]; then
  echo "Error: Could not find ${GAME_FILE}"
  exit 1
fi

PORT=8765
QUERY=""

for arg in "$@"; do
  case "$arg" in
    --fresh) QUERY="?fresh=1" ;;
  esac
done

# Kill server on exit
cleanup() {
  if [ -n "$SERVER_PID" ]; then
    kill "$SERVER_PID" 2>/dev/null
  fi
}
trap cleanup EXIT INT TERM

# Start HTTP server in the background
python3 -m http.server "$PORT" --directory "$SCRIPT_DIR" &>/dev/null &
SERVER_PID=$!
sleep 0.3

URL="http://localhost:${PORT}/index.html${QUERY}"

if [ -n "$QUERY" ]; then
  echo "Starting fresh — all player history will be cleared."
fi
echo "Serving at ${URL}"
echo "Press Ctrl+C to stop."

# Cross-platform open
case "$(uname -s)" in
  Darwin)
    open "$URL"
    ;;
  Linux)
    if command -v xdg-open >/dev/null 2>&1; then
      xdg-open "$URL"
    elif command -v gnome-open >/dev/null 2>&1; then
      gnome-open "$URL"
    else
      echo "Open this URL in your browser: ${URL}"
    fi
    ;;
  CYGWIN*|MINGW*|MSYS*)
    start "" "$URL"
    ;;
  *)
    echo "Open this URL in your browser: ${URL}"
    ;;
esac

wait "$SERVER_PID"
