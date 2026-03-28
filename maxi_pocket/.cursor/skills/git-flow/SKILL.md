---
name: git-flow
description: Automate git add, commit, and push following Conventional Commits with human review steps.
disable-model-invocation: true
---

# Git Flow Skill

Automate the git add, commit and push flow with AI-generated commit messages following **Conventional Commits rules**.

## Tools

- `git` CLI
- `git hooks`
- `husky` (git hooks in `.husky/`)
- `@commitlint/cli` (commit message validation)

## Conventional Commits Format

Generate commit messages using this format:

<type>(<scope>): <short description>

<body (optional)>

<footer (optional)>

## Allowed types

| Type | When to use |
| --- | --- |
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code restructuring without behavior change |
| `docs` | Documentation only |
| `revert` | Reverting a previous commit |

## Scope

- Use the feature or module name as scope (e.g., `registration`, `auth`, `core`, `profile`)
- If multiple features are involved, use the most relevant one

## Rules

- Short description: imperative, lowercase, no period, max 72 characters
- Body: explain WHAT changed and WHY (not HOW), wrap at 100 characters max
- Footer: reference issue/ticket if available (e.g., `Refs: #123`) or for breaking changes
- If there are breaking changes, add `BREAKING CHANGE:` in the footer
- Husky hooks (`pre-commit`, `commit-msg`, `post-commit`) are triggered automatically by Git. Do not execute them manually.
- **CRITICAL**: You MUST stop and ask for human confirmation at specific steps. Do NOT proceed to the next step without explicit user approval.

## Examples

1. feat(registration): add email verification page

Implemented the email verification flow with OTP input and resend functionality.
Uses Firebase Auth email verification under the hood.

Refs: #42

2. fix(auth): handle token expiration on app resume

The token was not refreshed when the app returned from background,
causing 401 errors on subsequent API calls.

## Instructions

### Step 1 — Stage files

- Navigate to the root project directory
- Run `git add .`

### Step 2 — Analyze changes

- Run `git status` to see staged files
- Run `git diff --cached --stat` to see a summary of changes
- Run `git diff --cached` to read the actual code changes

### Step 3 — Generate commit message

- Based on the diff analysis, generate a commit message strictly following the Conventional Commits format above

#### 🛑 STOP 1 — Human Review (Commit Message)

**Stop execution and show the generated commit message to the user.**
Ask: "Do you approve this commit message? (y/edit/n)"

- **y** → proceed to Step 4
- **edit** → ask what to change, regenerate, and stop again for approval
- **n** → abort the flow

### Step 4 — Execute commit

- Run `git commit -m "<approved_message>"`
- Husky hooks will execute:
  1. `commit-msg` → commitlint validation against Conventional Commits
  2. `post-commit` → notification with commit result
- If any hook fails, show the error and stop

### 🛑 STOP 2 — Human Review (Pre-Push)

**Stop execution and show the commit result to the user.**
Run `git log --oneline -1` to display the committed change.
Ask: "Ready to push to remote? (y/n)"

- **y** → proceed to Step 5
- **n** → abort (commit is preserved locally, user can amend later)

### Step 5 — Push

- Run `git push`
- Show the push result
- If push fails (e.g., conflicts), show the error