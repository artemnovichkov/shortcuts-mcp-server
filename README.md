# shortcuts-mcp-server

## Installation

```bash
git clone https://github.com/artemnovichkov/shortcuts-mcp-server
cd shortcuts-mcp-server
swift build
```

Add to MCP Client:

```json
{
  "mcpServers": {
    "shortcuts-mcp-server": {
      "type": "stdio",
      "command": "PATH_TO_PROJECT/shortcuts-mcp-server/.build/arm64-apple-macosx/debug/shortcuts-mcp-server"
    },
  }
}
```

## References

- [Run shortcuts from the command line](https://support.apple.com/en-kz/guide/shortcuts-mac/apd455c82f02/mac)
