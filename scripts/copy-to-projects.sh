#!/bin/bash
# Copy generated protobuf code to target projects

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
GENERATED_DIR="$ROOT_DIR/generated"

# Project paths (relative to lucid-shared parent)
LUCID_CLOUD="../lucid-cloud"
LUCID_APPS="../lucid-apps"

echo "=== Copying generated protobuf code to projects ==="

# Copy Python to lucid-cloud
if [ -d "$GENERATED_DIR/python" ]; then
    echo "Copying Python protobufs to lucid-cloud..."

    # Copy to lucid-core package
    CORE_PROTO_DIR="$LUCID_CLOUD/packages/lucid-core/src/lucid_core/proto"
    rm -rf "$CORE_PROTO_DIR/schemeserver"
    cp -r "$GENERATED_DIR/python/schemeserver" "$CORE_PROTO_DIR/"
    echo "  -> $CORE_PROTO_DIR"

    # Copy to schemeserver service
    SERVICE_PROTO_DIR="$LUCID_CLOUD/services/schemeserver/src/schemeserver/proto"
    rm -rf "$SERVICE_PROTO_DIR/generated"
    mkdir -p "$SERVICE_PROTO_DIR/generated"
    cp -r "$GENERATED_DIR/python/schemeserver" "$SERVICE_PROTO_DIR/generated/"
    echo "  -> $SERVICE_PROTO_DIR"
fi

# Copy Dart to lucid-apps
if [ -d "$GENERATED_DIR/dart" ]; then
    echo "Copying Dart protobufs to lucid-apps..."

    # Copy to lucid_core package (Dart)
    DART_PROTO_DIR="$LUCID_APPS/packages/lucid_core/lib/src/proto"
    mkdir -p "$DART_PROTO_DIR"
    rm -rf "$DART_PROTO_DIR/schemeserver"
    cp -r "$GENERATED_DIR/dart/schemeserver" "$DART_PROTO_DIR/"
    echo "  -> $DART_PROTO_DIR"
fi

echo ""
echo "=== Protobuf code copied to all projects ==="
