#!/usr/bin/env bash
set -euo pipefail

#
# Vizio SmartCast Local Control Script
# Replace TV_IP and AUTH_TOKEN before use.
#

TV_IP="<TV_IP>"
PORT="7345"
AUTH_TOKEN="<AUTH_TOKEN>"

ACTION="${1:-}"

case "$ACTION" in
  power)   CODESET=11; CODE=2 ;;   # Power toggle
  volup)   CODESET=5;  CODE=1 ;;
  voldown) CODESET=5;  CODE=0 ;;
  mute)    CODESET=5;  CODE=4 ;;
  input)   CODESET=7;  CODE=1 ;;

  up)      CODESET=3;  CODE=8 ;;
  down)    CODESET=3;  CODE=0 ;;
  left)    CODESET=3;  CODE=1 ;;
  right)   CODESET=3;  CODE=7 ;;
  enter)   CODESET=3;  CODE=2 ;;
  home)    CODESET=4;  CODE=3 ;;

  *)
    echo "Usage: $0 {power|volup|voldown|mute|input|up|down|left|right|enter|home}" >&2
    exit 1 ;;
esac

curl --http1.1 -k -s -m 5 -X PUT \
  "https://${TV_IP}:${PORT}/key_command/" \
  -H "Content-Type: application/json" \
  -H "AUTH: ${AUTH_TOKEN}" \
  -d "{
    \"KEYLIST\": [
      { \"CODESET\": ${CODESET}, \"CODE\": ${CODE}, \"ACTION\": \"KEYPRESS\" }
    ]
  }"
