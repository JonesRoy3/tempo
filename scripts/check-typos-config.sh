```bash
#!/usr/bin/env bash
set -euo pipefail
```

# Simple helper to dry-run the `typos` configuration used in this repo.
# Requires `typos` to be installed:
#   https://github.com/crate-ci/typos

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v typos >/dev/null 2>&1; then
  echo "typos is not installed. Please install it first." >&2
  exit 1
fi

echo "Running typos in dry-run mode against repository…"
echo "Root: ${ROOT_DIR}"
echo

cd "${ROOT_DIR}"
typos --config typos.toml --format brief || {
  echo
  echo "typos reported issues. Review the output above."
  exit 1
}

echo
echo "✅ typos completed without errors."
