---
name: install-skills
description: Install skills from GitHub and move them to config/opencode/skills/
license: MIT
allowed-tools: Bash
---

# Install Skills

This skill installs AI agent skills from the skills ecosystem and moves them to OpenCode's project skills directory.

## What It Does

1. Installs a skill using `npx skills add`
2. Moves it from `.agents/skills/` to `config/opencode/skills/`
3. Cleans up the old location
4. Updates `skills-lock.json` with the new skill

## Usage

### Install from GitHub shorthand
```
install-skills vercel-labs/agent-skills
```

### Install from full URL
```
install-skills https://github.com/vercel-labs/agent-skills
```

### Install specific skill from repo
```
install-skills https://github.com/vercel-labs/agent-skills/tree/main/skills/web-design-guidelines
```

## Implementation

The skill runs `config/opencode/skills/install-skills/install.sh` which:

1. Extracts skill name from source URL
2. Runs `npx skills add <source> --yes --agent opencode`
3. Moves `.agents/skills/<name>` to `config/opencode/skills/`
4. Cleans up empty `.agents` directories
5. Updates `skills-lock.json` with hash

## Bash Tool

This skill uses the Bash tool to execute the installation script.

## Skill Name Extraction

The skill extracts the name from the source:
- `vercel-labs/agent-skills` → `agent-skills`
- `https://github.com/vercel-labs/agent-skills` → `agent-skills`
- `https://github.com/owner/repo/tree/main/skills/name` → `name`

## Output

After successful installation, the skill is available via the `skill` tool in OpenCode.
