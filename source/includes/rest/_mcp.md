# MCP Server

> Drip MCP server (Streamable HTTP):

```text
https://api.getdrip.com/mcp
```

Drip runs a remote [Model Context Protocol](https://modelcontextprotocol.io) (MCP) server, so AI
assistants and agents can work in your Drip account: look up and update subscribers, apply tags,
record events, read workflows and email metrics, build broadcasts, and more.

The server URL is `https://api.getdrip.com/mcp`, using the Streamable HTTP transport.

The server uses OAuth. The first time your client connects, it opens a browser window where you
sign in to Drip and approve the connection. You don't need an API key, and Drip supports dynamic
client registration, so you don't need to register an OAuth application or supply a client ID.

When you approve the connection, you choose:

- **Which accounts it can access:** All accounts, or a single account.
- **Read**, **Write**, or both. Write covers creating, updating and deleting. A connection
  without Write access doesn't see the write tools.

## Claude Code

> Add Drip for all of your projects:

```bash
claude mcp add --transport http --scope user drip https://api.getdrip.com/mcp
```

Run the command, then run `/mcp` in Claude Code and follow the steps in your browser to sign in.
Leave out `--scope user` to add Drip to the current project only. See
[Claude Code's MCP docs](https://code.claude.com/docs/en/mcp).

## Claude and Claude Desktop

Add Drip as a custom connector. It's available in Claude on the web and in Claude Desktop.

1. Go to **Customize > Connectors**.
2. Click **+ Add**, then **Add custom connector**.
3. Name the connector `Drip`, enter `https://api.getdrip.com/mcp` as the remote MCP server URL,
   and click **Continue**.
4. Review the authentication settings Claude detected, click **Continue**, then click **Add**.
   You don't need your own OAuth client or any request headers.
5. Sign in to Drip and approve the connection.

On Team and Enterprise plans, an Owner adds the connector under **Organization settings >
Connectors**, and each member then clicks **Connect** on it. See
[Get started with custom connectors using remote MCP](https://support.claude.com/en/articles/11175166-get-started-with-custom-connectors-using-remote-mcp).

## Cursor

> Add to `~/.cursor/mcp.json` (all projects) or `.cursor/mcp.json` (one project):

```json
{
  "mcpServers": {
    "drip": {
      "url": "https://api.getdrip.com/mcp"
    }
  }
}
```

Add the configuration to `~/.cursor/mcp.json` for all of your projects, or to `.cursor/mcp.json`
in one project. Cursor signs in with OAuth the first time it connects. See
[Cursor's MCP docs](https://cursor.com/docs/context/mcp).

## VS Code

> Add Drip to your VS Code user profile:

```bash
code --add-mcp '{"name":"drip","type":"http","url":"https://api.getdrip.com/mcp"}'
```

> Or add it to one workspace in `.vscode/mcp.json`:

```json
{
  "servers": {
    "drip": {
      "type": "http",
      "url": "https://api.getdrip.com/mcp"
    }
  }
}
```

Run `code --add-mcp` to add Drip to your user profile, or add the configuration to
`.vscode/mcp.json` to add it to one workspace. VS Code opens a browser window to sign in the
first time it connects. See
[VS Code's MCP configuration reference](https://code.visualstudio.com/docs/copilot/reference/mcp-configuration).

## Gemini CLI

> Add Drip for your user:

```bash
gemini mcp add --transport http --scope user drip https://api.getdrip.com/mcp
```

> Or add it to `~/.gemini/settings.json`:

```json
{
  "mcpServers": {
    "drip": {
      "httpUrl": "https://api.getdrip.com/mcp"
    }
  }
}
```

Gemini CLI detects that Drip requires OAuth and opens a browser to sign in, so it needs a local
browser. Run `/mcp auth drip` to sign in again. See
[Gemini CLI's MCP docs](https://geminicli.com/docs/tools/mcp-server/).

## Using the Tools

Call `list_accounts` first. It returns the Drip accounts the connection can access, and every
account-level tool takes one of their ids as its `account_id` argument.

Some tools that can't be undone, or that affect many records, ask the agent to confirm with you
before they run.

The tools are built on the REST API in this reference. Your client lists the full set, which
depends on the access you approved. The families, with a few tools from each:

<!-- Generated 2026-11-06 from the Drip MCP server's tool definitions (examples per family, not the full list); regenerate rather than hand-edit. -->
- **Accounts and users**: `list_accounts`, `get_account`, `whoami`
- **Subscribers**: `list_subscribers`, `get_subscriber`, `create_or_update_subscriber`, `delete_subscriber`
- **Tags and custom fields**: `list_tags`, `apply_tag`, `remove_tag`, `list_custom_fields`
- **Events**: `record_event`, `list_event_actions`, `batch_record_events`
- **Orders**: `create_order`, `batch_create_orders`, `create_refund`
- **Broadcasts**: `list_broadcasts`, `get_broadcast`, `get_broadcast_audience`, `create_broadcast`
- **Email series campaigns**: `list_campaigns`, `get_campaign`, `activate_campaign`, `pause_campaign`
- **Workflows**: `list_workflows`, `get_workflow`, `activate_workflow`, `pause_workflow`
- **Forms and segments**: `list_forms`, `get_form`, `list_segments`, `get_segment`
- **Email metrics**: `get_email_metrics`
- **Webhooks**: `list_webhooks`, `get_webhook`, `create_webhook`, `delete_webhook`
