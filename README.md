# shortcuts-mcp-server

A Model Context Protocol (MCP) server that provides access to Apple Shortcuts functionality. This server allows AI assistants to list, view, and run your shortcuts through the MCP interface.

Compatible with Cursor, Claude Desktop, and other MCP-enabled applications.

## Installation

```bash
git clone https://github.com/artemnovichkov/shortcuts-mcp-server
cd shortcuts-mcp-server
swift build
```

<details>
<summary>Cursor</summary>

For project cofiguration, update `.cursor/mcp.json` file in your project directory. To use across all projects, create a `~/.cursor/mcp.json` file in your home directory.

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

Don't forget to replace the path to the executable.

[Read more](https://docs.cursor.com/context/model-context-protocol)

</details>

<details>
<summary>Claude Desktop</summary>

1. Open Settings -> Developer -> Edit Config
2. Open the config file at `~/Library/Application Support/Claude/claude_desktop_config.json` and update:

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

Don't forget to replace the path to the executable.

3. Restart Claude Desktop.

[Read more](https://modelcontextprotocol.io/quickstart/user)

</details>

<details>
<summary>VS Code</summary>

For quick install:

[![Install in VS Code](https://img.shields.io/badge/VS_Code-Install_Server-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://insiders.vscode.dev/redirect/mcp/install?name=shortcuts&config=%7B%22command%22%3A%22%2Fabsolute%2Fpath%2Fto%2Fshortcuts-mcp-server%2F.build%2Farm64-apple-macosx%2Fdebug%2Fshortcuts-mcp-server%22%2C%22type%22%3A%22stdio%22%7D)

For manual installation, add the following JSON block to your User Settings (JSON) file in VS Code. You can do this by pressing `Ctrl + Shift + P` and typing `Preferences: Open User Settings (JSON)`.

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

Don't forget to replace the path to the executable.

[Read more](https://code.visualstudio.com/docs/copilot/chat/mcp-servers)

</details>

## Tools

- **run** - Run a shortcut.
    - `name` - The name of the shortcut to run (string, required)
- **list** - List your shortcuts.
    - `show-identifiers` - Whether to show the identifiers of the shortcuts. (boolean, optional)
- **view** - View a shortcut in Shortcuts app.
    - `name` - Name of the shortcut to view (string, required)
    
## Resources

- **list** - List your shortcuts.

## Prompts

- **run** - Run a shortcut.
    - `name` - Name of the shortcut to run (string, required)
- **list** - List your shortcuts.
    - `show-identifiers` - Whether to show the identifiers of the shortcuts. (boolean, optional)
- **view** - View a shortcut in Shortcuts app.
    - `name` - Name of the shortcut to view (string, required)

## References

- [Run shortcuts from the command line](https://support.apple.com/en-kz/guide/shortcuts-mac/apd455c82f02/mac)
- [List of helpful links for shortcuts information](https://www.reddit.com/r/shortcuts/comments/gzjgbr/list_of_helpful_links_for_shortcuts_information/)
- [Shortcuts Library](https://matthewcassinelli.com/sirishortcuts/library/)
- [Shortcuts Directory](https://shortcuts.directory)
