# lucid-shared

<purpose>
Shared protobuf definitions for Lucid ecosystem. Source of truth for message schemas used by Flutter apps (lucid-apps) and Python backends (lucid-cloud). Includes AI agent communication protocols for Google ADK integration.
</purpose>

## Structure

```
lucid-shared/
├── proto/              # Source .proto files
│   └── schemeserver/
│       └── v1/
│           └── messages.proto
├── generated/          # Generated code (gitignored)
│   ├── python/
│   └── dart/
└── scripts/            # Generation scripts
```

## Protobuf Generation

```bash
# Generate all languages
./scripts/generate-all.sh

# Generate specific language
./scripts/generate-python.sh
./scripts/generate-dart.sh

# Copy generated code to projects
./scripts/copy-to-projects.sh
```

## Prerequisites

### Python (grpcio-tools)
```bash
pip install grpcio-tools
```

### Dart (protoc_plugin)
```bash
dart pub global activate protoc_plugin
```

### protoc
```bash
brew install protobuf  # macOS
```

## Adding New Messages

1. Create or edit `.proto` files in `proto/`
2. Run `./scripts/generate-all.sh`
3. Run `./scripts/copy-to-projects.sh`
4. Update Flutter and Python code to use new messages

## Message Types

### Core Messages
- `Envelope` - Wrapper for all WebSocket messages
- `PingRequest` / `PongResponse` - Keep-alive
- `AuthenticateRequest` / `AuthenticateResponse` - Auth flow

### Agent Messages (Google ADK)
- `AgentRequest` - Send message to AI agent
- `AgentResponse` - Complete agent response
- `AgentStreamChunk` - Streaming response chunk
- `ToolCall` - Tool invocation by agent

## Versioning

- Use `/v1/`, `/v2/` directories for breaking changes
- Add new fields with new field numbers (never reuse)
- Mark deprecated fields with `[deprecated = true]`
