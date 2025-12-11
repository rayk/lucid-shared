#!/bin/bash
# Generate protobuf code for all target languages

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Generating protobuf code for all languages ==="
echo ""

# Generate Python
"$SCRIPT_DIR/generate-python.sh"
echo ""

# Generate Dart
"$SCRIPT_DIR/generate-dart.sh"
echo ""

echo "=== All protobuf code generated successfully ==="