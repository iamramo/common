#!/bin/bash

set -e

# Extract skill name from source
extract_skill_name() {
    local source="$1"
    
    # If it's a GitHub URL with /tree/.../skills/...
    if [[ "$source" =~ ^https://github\.com/[^/]+/[^/]+/tree/[^/]+/skills/([^/]+) ]]; then
        echo "${BASH_REMATCH[1]}"
        return
    fi
    
    # If it's a GitHub URL
    if [[ "$source" =~ ^https://github\.com/([^/]+)/([^/]+) ]]; then
        echo "${BASH_REMATCH[2]}"
        return
    fi
    
    # If it's GitHub shorthand (owner/repo)
    if [[ "$source" =~ ^([^/]+)/([^/]+)$ ]]; then
        echo "${BASH_REMATCH[2]}"
        return
    fi
    
    echo "unknown"
}

# Update skills-lock.json
update_skills_lock() {
    local skill_name="$1"
    local source="$2"
    local lock_file="config/opencode/skills-lock.json"
    
    # Check if lock file exists
    if [[ ! -f "$lock_file" ]]; then
        echo "{
  \"version\": 1,
  \"skills\": {
    \"$skill_name\": {
      \"source\": \"$source\",
      \"sourceType\": \"github\",
      \"computedHash\": \"$(sha256sum config/opencode/skills/$skill_name/SKILL.md 2>/dev/null | cut -d' ' -f1)\"
    }
  }
}" > "$lock_file"
        return
    fi
    
    # Read existing content
    local content
    content=$(cat "$lock_file")
    
    # Check if skill already exists
    if echo "$content" | grep -q "\"$skill_name\""; then
        echo "Skill '$skill_name' already exists in skills-lock.json"
        return
    fi
    
    # Add new skill entry
    local new_entry="  \"$skill_name\": {
    \"source\": \"$source\",
    \"sourceType\": \"github\",
    \"computedHash\": \"$(sha256sum config/opencode/skills/$skill_name/SKILL.md 2>/dev/null | cut -d' ' -f1)\"
  }"
    
    # Insert before closing brace
    echo "$content" | sed "s/}$/,\n$new_entry\n  }/" > "$lock_file"
}

# Main logic
if [[ $# -eq 0 ]]; then
    echo "Usage: install-skills <source>"
    echo "  source: GitHub shorthand (owner/repo) or full URL"
    exit 1
fi

SOURCE="$1"
SKILL_NAME=$(extract_skill_name "$SOURCE")

echo "Installing skill: $SKILL_NAME"
echo "Source: $SOURCE"

# Step 1: Install skill
echo "Step 1: Installing skill with npx skills add..."
npx skills add "$SOURCE" --yes --agent opencode || {
    echo "Failed to install skill. Check if source is valid."
    exit 1
}

# Step 2: Move skill to config/opencode/skills/
if [[ -d ".agents/skills/$SKILL_NAME" ]]; then
    echo "Step 2: Moving skill to config/opencode/skills/..."
    mv ".agents/skills/$SKILL_NAME" "config/opencode/skills/"
    
    # Clean up empty .agents/skills directory
    if [[ -d ".agents/skills" ]] && [[ -z "$(ls -A .agents/skills 2>/dev/null)" ]]; then
        rmdir .agents/skills 2>/dev/null || true
    fi
    
    # Clean up empty .agents directory
    if [[ -d ".agents" ]] && [[ -z "$(ls -A .agents 2>/dev/null)" ]]; then
        rmdir .agents 2>/dev/null || true
    fi
else
    echo "Warning: Skill directory not found at .agents/skills/$SKILL_NAME"
    exit 1
fi

# Step 3: Update skills-lock.json
echo "Step 3: Updating skills-lock.json..."
update_skills_lock "$SKILL_NAME" "$SOURCE"

echo ""
echo "✓ Skill '$SKILL_NAME' installed successfully!"
echo "  Location: config/opencode/skills/$SKILL_NAME/"
echo "  Available via: skill $SKILL_NAME"
