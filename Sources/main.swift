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
                        ])
                    ],
                    "required:": .array(["name"])
                   ]))

let listTool = Tool(name: "list",
                description: "List your shortcuts.",
                inputSchema: .object([
                    "type": "object",
                ]))

let viewTool = Tool(name: "view",
                   description: " View a shortcut in Shortcuts.",
                   inputSchema: .object([
                    "type": "object",
                    "properties": [
                        "name": .object([
                            "description": "The name of the shortcut to run.",
                            "type": "string"
                        ])
                    ],
                    "required:": .array(["name"])
                   ]))

let tools = [runTool, listTool, viewTool]

let server = Server(
    name: "Shortcuts MCP Server",
    version: "1.0.0",
    capabilities: .init(tools: .init(listChanged: false))
)

let transport = StdioTransport()
try await server.start(transport: transport)

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
        guard let name = params.arguments?["name"]?.stringValue else {
            throw MCPError.invalidParams("Missing name argument")
        }
        arguments = ["run", name]
    case "list":
        arguments = ["list"]
    case "view":
        guard let name = params.arguments?["name"]?.stringValue else {
            throw MCPError.invalidParams("Missing name argument")
        }
        arguments = ["view",  name]
    default:
        throw MCPError.invalidParams("Unknown tool name: \(tool.name)")
    }
    let result = try await run(executable, arguments: arguments)
    return result.standardOutput ?? ""
}

await server.waitUntilCompleted()
