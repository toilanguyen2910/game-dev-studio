# OpenClaw Game Dev Studio — Install Guide

Install the game-dev-studio skills into OpenClaw so your coding agent has
access to all game development workflows: architecture, prototyping, sprint
development, art bibles, QA testing, releases, and more.

---

## Prerequisites

- [OpenClaw](https://openclaw.dev) installed and configured
- `openclaw` CLI available in your terminal
- Game Dev Studio cloned or copied to your local machine

Verify your OpenClaw installation:

```bash
openclaw --version
openclaw status
```

---

## Quick Install (Recommended)

From the project root:

```bash
# Option A: Use the installer script
openclaw skills install ./skills

# Option B: Use the project installer
bash scripts/install.sh
# Then select "openclaw" when prompted
```

---

## Step-by-Step Install

### Step 1: Locate the skills directory

```bash
cd path/to/game-dev-studio
ls skills/
```

You should see skill directories like:
```
architecture/    art-bible/    brainstorm/    game-design-doc/
prototype/       qa-test/      release/       setup-engine/
sprint-dev/      start/
```

### Step 2: Install via OpenClaw CLI

```bash
# Install all skills from the skills directory
openclaw skills install ./skills
```

This registers each skill directory (containing `SKILL.md`) with OpenClaw.

### Step 3: Restart the gateway

Skills take effect after a gateway restart:

```bash
openclaw gateway restart
```

Or, equivalently:

```bash
openclaw restart
```

### Step 4: Verify installation

Check that the skills are registered:

```bash
# List all installed skills
openclaw skills list

# Inspect a specific skill
openclaw skills inspect architecture
```

Expected output for `skills list` should include entries like:
- `game-dev-studio/architecture`
- `game-dev-studio/art-bible`
- `game-dev-studio/brainstorm`
- `game-dev-studio/game-design-doc`
- `game-dev-studio/prototype`
- `game-dev-studio/qa-test`
- `game-dev-studio/release`
- `game-dev-studio/setup-engine`
- `game-dev-studio/sprint-dev`
- `game-dev-studio/start`

---

## Manual Install (Alternative)

If the CLI install doesn't work for your setup, copy skills manually:

```bash
# Copy skills to the OpenClaw workspace skills directory
mkdir -p ~/.openclaw/workspace/skills
cp -r ./skills/* ~/.openclaw/workspace/skills/

# Verify
ls ~/.openclaw/workspace/skills/
```

Then restart the gateway:

```bash
openclaw gateway restart
```

---

## Converting to Other Platforms

This project also supports other coding agents. Use the conversion script:

```bash
# Convert to all supported platforms
bash scripts/convert.sh

# Convert to a specific platform only
bash scripts/convert.sh --tool claude
bash scripts/convert.sh --tool cursor
bash scripts/convert.sh --tool gemini

# Dry run (preview without writing)
bash scripts/convert.sh --dry-run
```

See [convert.sh](convert.sh) for full documentation.

---

## Verification Checklist

After installation, confirm:

| Check | Command | Expected |
|-------|---------|----------|
| Skills registered | `openclaw skills list` | 10+ skills listed |
| Gateway running | `openclaw status` | `running` |
| Individual skill | `openclaw skills inspect architecture` | SKILL.md content |
| Agent can find skills | Start a session and ask "list game dev skills" | Skills are loaded |

---

## Troubleshooting

### Skills not showing up after install

```bash
# Restart gateway
openclaw gateway restart
```

### "Command not found: openclaw"

Make sure OpenClaw is installed:

```bash
npm install -g openclaw
# or the appropriate install method for your system
```

### Permission errors

Ensure you have write access to the OpenClaw config directory:

```bash
ls -la ~/.openclaw/
# If permissions are wrong:
chmod -R u+w ~/.openclaw/
```

### Skills directory already exists

The `openclaw skills install` command will merge existing skills. If you want
a clean install, remove existing skills first:

```bash
# Backup first!
cp -r ~/.openclaw/workspace/skills ~/.openclaw/workspace/skills.bak
rm -rf ~/.openclaw/workspace/skills/*
openclaw skills install ./skills
openclaw gateway restart
```

---

## Next Steps

- Try the **start** skill: `openclaw skills inspect start`
- Run a sprint: trigger the **sprint-dev** skill in a game project
- Create a game design doc with the **game-design-doc** skill
- Set up a new engine project with **setup-engine**
- Run quality checks with **qa-test**

For agent definitions (Creative Director, Technical Director, etc.), see the
[agents/](../agents/) directory.
