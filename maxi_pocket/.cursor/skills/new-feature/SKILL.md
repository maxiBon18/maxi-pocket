---
name: new-feature
description: Used to create all the folders for new feature
disable-model-invocation: true
---

# New Feature Skill

Run bash script **.cursor/skills/new-feature/scripts/create_clean_arch_folders.sh** to create all necessary directory for a new application feature

## Instructions

### Step 1 — Navigation

- Navigate to `.cursor/skills/new-feature/scripts/`

### Step 2 — Feature name

- Run `.cursor/skills/new-feature/scripts/`

#### 🛑 STOP 1 — Human Input (Feature name)

**Stop execution and show this input prompt to the user.**
Ask: "Which is the name of new feature? (user input)"

**User input:**

The value **MUST NOT BE EMPTY**.

### Step 3 — Feature name change

After the user has entered the feature name change the value in `create_clean_arch_folders.sh` of <featureFolderName> with the entered feature name and continnue execution
