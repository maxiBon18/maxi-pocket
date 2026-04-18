# README Reference

Section definitions and formatting rules for the README generator skill.

---

## Mandatory Sections

Every README **must** include these sections in order:

| #   | Section                         | Content Guidelines                                                                                                                                                  |
| --- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | **Project Title & Description** | Project name as H1. 1–2 sentence description. Badges row (build status, platform, Flutter version, license) below H1.                                               |
| 2   | **Screenshots / Demo**          | 2–4 screenshots or animated GIF. Markdown table with `Android` / `iOS` column headers. Placeholder with `<!-- TODO -->` if unavailable.                             |
| 3   | **Features**                    | Bullet list of user-facing features. Group by module if >10 items. `- [x]` for implemented, `- [ ]` for planned.                                                    |
| 4   | **Tech Stack**                  | Table: **Category** → **Technology** → **Version**. Categories: Framework, Language, State Management, Database, CI/CD, Design System.                              |
| 5   | **Architecture**                | Name the pattern (e.g., *Clean Architecture + MVVM, feature-first*).                                                                                                |
| 6   | **Getting Started**             | Numbered steps: (1) Install FVM, (2) `fvm install`, (3) `fvm flutter pub get`, (4) Firebase setup, (5) `fvm flutter run`. List prerequisites with minimum versions. |
| 7   | **Configuration / Environment** | Environment setup (dev / staging / prod). Location of `.env` or Firebase config files. State what is `.gitignore`-d.                                                |
| 8   | **State Management**            | Riverpod usage: provider scoping, `AsyncValue` pattern, `Notifier` pattern. Link to `.claude/rules/viewmodel-rules.md`.                                             |
| 9   | **Dependencies**                | Table: **Package** → **Purpose** → **Version**. Direct dependencies only. Exclude transitive/dev unless architecturally significant.                                |
| 10  | **Scripts & Commands**          | Table of common commands. All commands prefixed with `fvm`.                                                                                                         |
| 11  | **Testing**                     | Test strategy (unit, widget, integration). How to run: `fvm flutter test`. Test folder structure mirroring `/lib`.                                                  |
| 12  | **Contributing**                | Branch naming, commit message format (Conventional Commits), PR process, link to `.claude/rules/code-review.md`.                                                    |
| 13  | **License**                     | License type and link to `LICENSE` file.                                                                                                                            |

## Optional Sections

Include when the condition applies:

| Section                   | When to Include                                        |
| ------------------------- | ------------------------------------------------------ |
| **API Reference**         | App exposes or consumes documented REST / GraphQL APIs |
| **Deployment**            | CI/CD pipelines or app store deployment steps exist    |
| **Troubleshooting / FAQ** | 3+ recurring setup issues documented                   |
| **Changelog**             | Project maintains a versioned changelog                |
| **Acknowledgements**      | Third-party assets or tools deserve attribution        |
| **Roadmap**               | Public or team-visible feature roadmap exists          |

## Flutter-Specific Rules

- All CLI commands MUST use the `fvm` prefix.
- Include Flutter and Dart SDK versions in badges and Tech Stack table.
- State supported platforms with minimum OS versions (e.g., Android 7.0 / API 24, iOS 15.0).
- Firebase setup must be documented inline or linked to a dedicated guide.
- Explain `.fvmrc` and instruct contributors to run `fvm install` first.
- Use ASCII or Mermaid folder trees embedded in markdown. No external image files.
