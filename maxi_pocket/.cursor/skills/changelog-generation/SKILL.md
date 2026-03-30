---
description: "Generate or update the project CHANGELOG.md"
globs: CHANGELOG.md
alwaysApply: false
---

# CHANGELOG.md Generator

Create a cursor skill that generates and maintains a `CHANGELOG.md` following the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format combined with [Semantic Versioning](https://semver.org/). The skill would:

- Scan `git log` for commits since the last tagged release.
- Classify changes into `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, and `Security` categories using Conventional Commit prefixes (`feat:`, `fix:`, `chore:`, etc.).
- Support both **full creation** (initialize changelog from git history) and **update** (append unreleased changes) modes.
- Cross-reference the version in `pubspec.yaml` to detect when a release entry should be finalized.
- Link each version heading to the corresponding git tag diff on the remote repository.

This pairs naturally with the README generator — the README's optional Changelog section can link to the generated `CHANGELOG.md`, and both skills share the same codebase-scanning philosophy.