# Claude Code Configuration

Game Dev Studio skills for Claude Code.

## Install

```bash
bash scripts/install.sh
```

Or manually:

```bash
mkdir -p .claude/skills/
cp -r skills/* .claude/skills/
```

## Skills Location

Skills are installed to `.claude/skills/` in your project root.

## Usage

Once installed, reference any skill in your Claude Code session:

```
Use the brainstorm skill to help me develop a game concept.
Use the game-design-doc skill to write a GDD for my combat system.
Use the sprint-dev skill to plan this week's tasks.
```
