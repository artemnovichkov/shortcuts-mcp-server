# shortcuts-mcp-server

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fartemnovichkov%2Fshortcuts-mcp-server%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/artemnovichkov/shortcuts-mcp-server)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fartemnovichkov%2Fshortcuts-mcp-server%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/artemnovichkov/shortcuts-mcp-server)

A Model Context Protocol (MCP) server that provides access to Apple Shortcuts functionality. This server allows AI assistants to list, view, and run your shortcuts through the MCP interface.

Compatible with Cursor, Claude Desktop, and other MCP-enabled applications.

![Shortcuts MCP Server Preview](.github/preview.gif)

## Getting started

### Prerequisites

- macOS 14.5 or later
- Xcode 16.x or later
- mise

### Setup with mise

To install mise:
```bash
brew install mise
```

For more information about mise, visit the [official documentation](https://mise.jdx.dev/).

### Quick install

[![Install MCP Server](https://cursor.com/deeplink/mcp-install-dark.svg)](https://cursor.com/install-mcp?name=shortcuts-mcp-server&config=eyJjb21tYW5kIjoibWlzZSB4IHViaTphcnRlbW5vdmljaGtvdi9zaG9ydGN1dHMtbWNwLXNlcnZlckBsYXRlc3QgLS0gc2hvcnRjdXRzLW1jcC1zZXJ2ZXIifQ%3D%3D)

[![Install in VS Code](https://img.shields.io/badge/VS_Code-Install_Server-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://insiders.vscode.dev/redirect/mcp/install?name=shortcuts-mcp-server&config=%7B%22command%22%3A%22mise%22%2C%22args%22%3A%5B%22x%22%2C%22ubi%3Aartemnovichkov%2Fshortcuts-mcp-server%40latest%22%2C%22--%22%2C%22shortcuts-mcp-server%22%5D%7D)

### Manual installation

Update your MCP configuration with the following server:

```json
{
  "mcpServers": {
    "shortcuts-mcp-server": {
      "command": "mise",
      "args": [
        "x",
        "ubi:artemnovichkov/shortcuts-mcp-server@latest",
        "--",
        "shortcuts-mcp-server"
      ]
    }
  }
}
```

## Usage

Just ask LLM to run a shortcut, show a list of added shortcuts or view a shortcut in Shortcuts app. 

If your MCP client supports Prompts and Resources you may check it as well:
![Prompts and resources](.github/prompts-and-resources.png)

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
