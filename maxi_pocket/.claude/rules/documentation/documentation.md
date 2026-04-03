---
description: "Code documentation and commenting rules"
paths:
  - "lib/**/*.dart"
---
# Documentation

## Language

- English.

## Philosophy

- Comment **why**, not **what**. The code should be self-explanatory.
- Write for the reader. If you found an answer to a question, document it where you first looked.
- No useless documentation. If a doc comment restates the obvious from the name, remove it.
- Use consistent terminology throughout.

## Commenting Style

- Use `///` for doc comments.
- Start with a single-sentence summary ending with a period.
- Add a blank line after the first sentence to separate summary from body.
- Do not repeat the class name or method signature in the doc comment.
- For properties with both getter and setter, document only one.
- No trailing comments.
- No commented-out code — Git preserves history.
- Write clear comments for complex or non-obvious code. Avoid over-commenting.

## Writing Style

- Be brief.
- Avoid jargon and acronyms unless widely understood.
- Use Markdown sparingly. Never use HTML for formatting.
- Use backtick fences for code blocks and specify the language.

## What to Document

- Always document public APIs.
- Document private APIs when non-obvious.
- Consider library-level doc comments for general overviews.
- Include code samples where they clarify usage.
- Describe parameters, return values, and exceptions in prose.
- Place doc comments before annotations.
