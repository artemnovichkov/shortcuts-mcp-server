# shortcuts-mcp-server

## Installation

```bash
git clone https://github.com/artemnovichkov/shortcuts-mcp-server
cd shortcuts-mcp-server
swift build
```

## MCP Client Configuration

### Cursor

To add the server in Cursor:

1. Open Cursor and go to **Settings** > **MCP Servers**.
2. Use the UI to add a new server, or (if supported) edit the config file directly.
   - **Global config**: `~/Library/Application Support/Cursor/mcp.json` (macOS)
   - **Project config**: `.cursor/mcp.json` in your project folder
3. Example config:

```json
{
  "servers": {
    "shortcuts-mcp-server": {
      "type": "stdio",
      "command": "/absolute/path/to/shortcuts-mcp-server/.build/arm64-apple-macosx/debug/shortcuts-mcp-server"
    }
  }
}
```

> **Tip:** You can manage servers via the MCP settings page in Cursor, or by editing the config file directly for advanced use cases.

<details>
<summary>Claude Desktop</summary>

To add the server in Claude Desktop:

1. Open (or create) the config file at `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS).
2. Add or update the `mcpServers` section:

```json
{
  "mcpServers": {
    "shortcuts-mcp-server": {
      "type": "stdio",
      "command": "/absolute/path/to/shortcuts-mcp-server/.build/arm64-apple-macosx/debug/shortcuts-mcp-server"
    }
  }
}
```

> **Note:** Restart Claude Desktop after editing the config.

</details>

<details>
<summary>VS Code</summary>

You can add the MCP server in two ways:

#### 1. Workspace (Project) Settings

- Create or edit `.vscode/mcp.json` in your project folder:

```json
{
  "servers": {
    "shortcuts-mcp-server": {
      "type": "stdio",
      "command": "/absolute/path/to/shortcuts-mcp-server/.build/arm64-apple-macosx/debug/shortcuts-mcp-server"
    }
  }
}
```

#### 2. User (Global) Settings

- Open your global `settings.json` (via Command Palette: Preferences: Open Settings (JSON)) and add:

```json
"mcp": {
  "servers": {
    "shortcuts-mcp-server": {
      "type": "stdio",
      "command": "/absolute/path/to/shortcuts-mcp-server/.build/arm64-apple-macosx/debug/shortcuts-mcp-server"
    }
  }
}
```

> **Tip:** You can also use the Command Palette (`MCP: Add Server`) to add servers interactively.

</details>

## Tools

- **run** - Run a shortcut
    - `name` - Name of the shortcut to run (string, required)
- **list** - List all shortcuts
    - `show-identifiers` - Show identifiers (boolean, optional)
- **view** - View a shortcut
    - `name` - Name of the shortcut to view (string, required)
    
## Resources

- **list** - List all shortcuts

## Prompts

- **run** - Run a shortcut
    - `name` - Name of the shortcut to run (string, required)
- **list** - List all shortcuts
- **view** - View a shortcut
    - `name` - Name of the shortcut to view (string, required)

## References

- [Run shortcuts from the command line](https://support.apple.com/en-kz/guide/shortcuts-mac/apd455c82f02/mac)
- [List of helpful links for shortcuts information](https://www.reddit.com/r/shortcuts/comments/gzjgbr/list_of_helpful_links_for_shortcuts_information/)
- [Shortcuts Library](https://matthewcassinelli.com/sirishortcuts/library/)
- [Shortcuts Directory](https://shortcuts.directory)
