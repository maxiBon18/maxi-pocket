---
name: changelog-generation
description: "Generate or update the project CHANGELOG.md from git history"
paths:
  - CHANGELOG.md
---
# CHANGELOG Generator

Generate and maintain `CHANGELOG.md` following [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) + [Semantic Versioning](https://semver.org/).

## Mode Detection

- If `CHANGELOG.md` does **NOT** exist or is empty → execute **FULL CREATION** mode.
- If `CHANGELOG.md` exists with content → execute **UPDATE** mode.
- State which mode you are executing before starting.

## Data Collection (both modes)

Before writing, scan these sources silently:

1. `git tag --sort=-v:refname` → list of version tags.
2. `git log <last_tag>..HEAD --oneline` → commits since last release (or full log for FULL CREATION).
3. `pubspec.yaml` → current version number.
4. Remote URL (`git remote get-url origin`) → for tag diff links.

## Commit Classification

Map Conventional Commit prefixes to changelog categories:

| Commit Prefix      | Changelog Category      |
| ------------------ | ----------------------- |
| `feat:`            | Added                   |
| `fix:`             | Fixed                   |
| `refactor:`        | Changed                 |
| `docs:`            | Changed                 |
| `revert:`          | Removed                 |
| `BREAKING CHANGE:` | Changed (with ⚠️ marker) |

Ignore `chore:`, `ci:`, `build:`, `test:`, and `style:` commits unless they contain a `BREAKING CHANGE:` footer.

## FULL CREATION Mode

1. Scan full `git log` grouped by tags.
2. Generate a complete `CHANGELOG.md` with one section per tagged release + an `[Unreleased]` section at the top.
3. Each release section: `## [version] - YYYY-MM-DD` with subsections for each non-empty category (Added, Changed, Fixed, etc.).
4. Link each version heading to the tag diff on the remote repository.

## UPDATE Mode

1. Scan commits since the last tag.
2. Show a **change plan** listing new entries to add under `[Unreleased]`. Ask the user for confirmation before writing.
3. On confirmation, update `CHANGELOG.md`.
4. If `pubspec.yaml` version differs from the latest tag, ask the user: "Version in pubspec.yaml is X but latest tag is Y. Should I finalize the Unreleased section as version X? (y/n)"

## Formatting Rules

- H1: `# Changelog` (only once, at top).
- H2: `## [Unreleased]` and `## [X.Y.Z] - YYYY-MM-DD`.
- H3: `### Added`, `### Changed`, `### Fixed`, etc. Only include non-empty categories.
- Each entry: `- <description> ([commit_hash])`.
- Bottom of file: link definitions for version diffs.

## Constraints

- Do NOT invent entries not found in git log.
- Do NOT remove or modify existing manually written entries.
- Do NOT include merge commits or commits matching ignored prefixes.
