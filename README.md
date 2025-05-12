# shortcuts-mcp-server

## Installation

```bash
git clone https://github.com/artemnovichkov/shortcuts-mcp-server
cd shortcuts-mcp-server
swift build
```

## MCP Client Configuration

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

[![Install with Docker in VS Code](https://img.shields.io/badge/VS_Code-Install_Server-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://insiders.vscode.dev/redirect/mcp/install?name=github&inputs=%5B%7B%22id%22%3A%22github_token%22%2C%22type%22%3A%22promptString%22%2C%22description%22%3A%22GitHub%20Personal%20Access%20Token%22%2C%22password%22%3Atrue%7D%5D&config=%7B%22command%22%3A%22docker%22%2C%22args%22%3A%5B%22run%22%2C%22-i%22%2C%22--rm%22%2C%22-e%22%2C%22GITHUB_PERSONAL_ACCESS_TOKEN%22%2C%22ghcr.io%2Fgithub%2Fgithub-mcp-server%22%5D%2C%22env%22%3A%7B%22GITHUB_PERSONAL_ACCESS_TOKEN%22%3A%22%24%7Binput%3Agithub_token%7D%22%7D%7D)

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
