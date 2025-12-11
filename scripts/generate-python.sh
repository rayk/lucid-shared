#!/bin/bash
# Generate Python protobuf code from .proto files

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
PROTO_DIR="$ROOT_DIR/proto"
OUTPUT_DIR="$ROOT_DIR/generated/python"

echo "Generating Python protobuf code..."
echo "Proto source: $PROTO_DIR"
echo "Output: $OUTPUT_DIR"

# Clean and recreate output directory
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Find all .proto files and generate Python code
find "$PROTO_DIR" -name "*.proto" -print0 | while IFS= read -r -d '' proto_file; do
    echo "Processing: $proto_file"
    python -m grpc_tools.protoc \
        --proto_path="$PROTO_DIR" \
        --python_out="$OUTPUT_DIR" \
        --pyi_out="$OUTPUT_DIR" \
        "$proto_file"
done

# Create __init__.py files for Python package structure
find "$OUTPUT_DIR" -type d -exec touch {}/__init__.py \;

echo "Python protobuf generation complete!"