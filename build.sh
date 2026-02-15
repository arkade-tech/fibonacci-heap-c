#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./build.sh [debug|release|sanitize] [--run] [--clean]
  debug     : -O0 -g (default)
  release   : -O3 -DNDEBUG
  sanitize  : ASan+UBSan (debug-like)

Examples:
  ./build.sh release
  ./build.sh sanitize --run
  ./build.sh debug --clean
EOF
}

mode="debug"
run=0
clean=0

for arg in "${@:-}"; do
  case "$arg" in
    debug|release|sanitize) mode="$arg" ;;
    --run) run=1 ;;
    --clean) clean=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $arg" >&2; usage; exit 2 ;;
  esac
done

if (( clean )); then
  make distclean
fi

case "$mode" in
  debug)    make BUILD=debug ;;
  release)  make BUILD=release ;;
  sanitize) make BUILD=sanitize ;;
esac

if (( run )); then
  make run
fi
