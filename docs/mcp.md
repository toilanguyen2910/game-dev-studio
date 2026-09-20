# MCP Integration

Game Dev Studio can be extended with Model Context Protocol (MCP) tools. MCP
servers should expose small, inspectable operations for game projects.

Recommended tools are `project_status`, `run_validation`, `read_logs`,
`check_assets`, and a confirmation-gated `build_preview`.

Keep read-only tools separate from tools that write files or run builds. Validate
paths, return structured errors, redact secrets, and require human confirmation
before export, deletion, publishing, or network access. Record the engine and
tool versions in every build result.

See the [MCP tools specification](https://modelcontextprotocol.io/).
