# OpenClaw Configuration

Game Dev Studio skills for OpenClaw.

## Install

```bash
bash scripts/install.sh
```

Or manually:

```bash
openclaw skills install ./studio-config/openclaw/
```

## Skills Location

Skills are installed to `~/.openclaw/workspace/skills/`.

## Usage

```bash
# List installed skills
openclaw skills list

# Start a new game project
openclaw agent run --pipeline init

# Run a specific phase
openclaw agent run --pipeline qa --project ./my-game
```
