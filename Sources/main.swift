import MCP
import Foundation
import Subprocess

let runTool = Tool(name: "run",
                   description: "Run a shortcut.",
                   inputSchema: .object([
                    "type": "object",
                    "properties": [
                        "name": .object([
                            "description": "The name of the shortcut to run.",
                            "type": "string"
                        ]),
                    ],
                    "required:": .array(["name"])
                   ]))

let listTool = Tool(name: "list",
                    description: "List your shortcuts.",
                    inputSchema: .object([
                        "type": "object",
                        "properties": [
                            "show-identifiers": .object([
                                "description": "Whether to show the identifiers of the shortcuts.",
                                "type": "boolean"
                            ])
                        ],
                    ]))

let viewTool = Tool(name: "view",
                    description: "View a shortcut in Shortcuts.",
                    inputSchema: .object([
                        "type": "object",
                        "properties": [
                            "name": .object([
                                "description": "The name of the shortcut to view.",
                                "type": "string"
                            ])
                        ],
                        "required:": .array(["name"])
                    ]))

let tools = [runTool, listTool, viewTool]

let server = Server(
    name: "Shortcuts MCP Server",
    version: "1.0.1",
    capabilities: .init(tools: .init(listChanged: false))
)

let transport = StdioTransport()
try await server.start(transport: transport)

// MARK: - Resources

let shortcutsURI = "shortcuts://list"

await server.withMethodHandler(ListResources.self) { _ in
    ListResources.Result(resources: [.init(name: "Shortcuts", uri: shortcutsURI, mimeType: "text/plain")])
}

await server.withMethodHandler(ReadResource.self) { params in
    guard params.uri == shortcutsURI else {
        throw MCPError.invalidParams("Invalid uri: \(params.uri)")
    }
    let result = try await run(.name("shortcuts"), arguments: ["list"])
    return ReadResource.Result(contents: [.text(result.standardOutput ?? "", uri: params.uri)])
}

// MARK: - Tools

await server.withMethodHandler(ListTools.self) { params in
    ListTools.Result(tools: tools)
}

await server.withMethodHandler(CallTool.self) { params in
    guard let tool = tools.first(where: { $0.name == params.name }) else {
        throw MCPError.invalidParams("Wrong tool name: \(params.name)")
    }
    do {
        let result = try await call(tool: tool, params: params)
        return CallTool.Result(content: [.text(result)], isError: false)
    } catch {
        return CallTool.Result(content: [.text(error.localizedDescription)], isError: true)
    }
}

func call(tool: Tool, params: CallTool.Parameters) async throws -> String {
    let executable = Executable.name("shortcuts")
    let arguments: Arguments
    switch tool.name {
    case "run":
        let name = try getParam(name: "name", params: params)
        arguments = ["run", name, "|", "cat"]
    case "list":
        let showIdentifiers = params.arguments?["show-identifiers"]?.boolValue ?? false
        if showIdentifiers {
            arguments = ["list", "--show-identifiers"]
        } else {
            arguments = ["list"]
        }
    case "view":
        let name = try getParam(name: "name", params: params)
        arguments = ["view",  name]
    default:
        throw MCPError.invalidParams("Unknown tool name: \(tool.name)")
    }
    let result = try await run(executable, arguments: arguments)
    return result.standardOutput ?? ""
}

func getParam(name: String, params: CallTool.Parameters) throws -> String {
    guard let value = params.arguments?[name]?.stringValue else {
        throw MCPError.invalidParams("Missing parameter: \(name)")
    }
    return value
}

// MARK: - Prompts

struct ShortcutPrompt {

    enum PromptType: String {
        case run
        case list
        case view

        var description: String {
            switch self {
            case .run: return "Run a shortcut."
            case .list: return "List your shortcuts."
            case .view: return "View a shortcut in Shortcuts."
            }
        }
    }

    let type: PromptType

    func prompt(with arguments: [Prompt.Argument]) -> Prompt {
        Prompt(name: type.rawValue, description: type.description, arguments: arguments)
    }

    func result(for params: GetPrompt.Parameters, messages: (GetPrompt.Parameters) throws -> ([Prompt.Message])) rethrows -> GetPrompt.Result {
        GetPrompt.Result(description: type.description, messages: try messages(params))
    }
}

let runPrompt = ShortcutPrompt(type: .run)
let listPrompt = ShortcutPrompt(type: .list)
let viewPrompt = ShortcutPrompt(type: .view)

await server.withMethodHandler(ListPrompts.self) { params in
    let nameArgument = Prompt.Argument(name: "name",
                                       description: "The name of the shortcut to run.",
                                       required: true)
    let showIdentifiersArgument = Prompt.Argument(name: "show-identifiers",
                                                  description: "Whether to show the identifiers of the shortcuts.")
    return ListPrompts.Result(prompts: [runPrompt.prompt(with: [nameArgument]),
                                        listPrompt.prompt(with: [showIdentifiersArgument]),
                                        viewPrompt.prompt(with: [nameArgument])])
}

await server.withMethodHandler(GetPrompt.self) { params in
    guard let type = ShortcutPrompt.PromptType(rawValue: params.name) else {
        throw MCPError.invalidParams("Unknown prompt name: \(params.name)")
    }
    return switch type {
    case .run:
        try runPrompt.result(for: params) { params in
            let name = try getParam(name: "name", params: params)
            return [.init(role: .user, content: .text(text: "Run \(name) shortcut"))]
        }
    case .list:
        listPrompt.result(for: params) { params in
            var text = "List shortcuts"
            if params.arguments?["show-identifiers"]?.boolValue == true {
                text += ", show identifiers"
            }
            return [.init(role: .user, content: .text(text: text))]
        }
    case .view:
        try viewPrompt.result(for: params) { params in
            let name = try getParam(name: "name", params: params)
            return [.init(role: .user, content: .text(text: "View \(name) shortcut"))]
        }

    }
}

func getParam(name: String, params: GetPrompt.Parameters) throws -> String {
    guard let value = params.arguments?[name]?.stringValue else {
        throw MCPError.invalidParams("Missing parameter: \(name)")
    }
    return value
}

// MARK: - Run

await server.waitUntilCompleted()
