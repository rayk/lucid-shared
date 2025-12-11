#!/bin/bash
# Generate Dart protobuf code from .proto files

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
PROTO_DIR="$ROOT_DIR/proto"
OUTPUT_DIR="$ROOT_DIR/generated/dart"

echo "Generating Dart protobuf code..."
echo "Proto source: $PROTO_DIR"
echo "Output: $OUTPUT_DIR"

# Clean and recreate output directory
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Check if protoc-gen-dart is available
if ! command -v protoc-gen-dart &> /dev/null; then
    echo "Error: protoc-gen-dart not found"
    echo "Install with: dart pub global activate protoc_plugin"
    exit 1
fi

# Find all .proto files and generate Dart code
find "$PROTO_DIR" -name "*.proto" -print0 | while IFS= read -r -d '' proto_file; do
    echo "Processing: $proto_file"
    protoc \
        --proto_path="$PROTO_DIR" \
        --dart_out="$OUTPUT_DIR" \
        "$proto_file"
done

echo "Dart protobuf generation complete!"