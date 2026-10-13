---
name: simplified-technical-english
description: Use when writing or editing project-facing text that will be saved in a repository, including README files, documents, guides, help text, templates, release notes, and project instructions. Applies ASD-STE100 Simplified Technical English style. For the content of code comments, the `writing-comments` skill holds the rule.
---

# Simplified Technical English

Use ASD-STE100 Simplified Technical English (STE) for project text. This skill gives a practical writing standard for agents; it is not an official STE checker.

## Project Dictionary

This skill holds the writing rules. A project holds its own term definitions. Before you write, find the project's dictionary and use it as the source of truth for terms.

To find it, check the repo root for one of these, in order:
- `GLOSSARY.md`
- `DICTIONARY.md`
- a "Terminology" or "Glossary" section in `README.md` or the agent instructions file

If the project defines a term, verb, or abbreviation, use that spelling and meaning. Do not redefine it here. If you add a domain term to a project, add it to the project dictionary in the same change. If the project has no dictionary and terms are drifting, propose one.

## Scope

Apply these rules to text that will be saved in a project:
- Code comments and doc comments
- README files
- Design documents
- User and developer guides
- Help text, templates, release notes, and project instructions

Do not rewrite these items only to satisfy STE:
- Code identifiers, command names, API names, product names, or quoted text
- Required legal, regulatory, or brand text
- Existing text outside the requested change

## Core STE Rules

- Use short, direct sentences. Aim for 20 words or fewer.
- Put one instruction, condition, or idea in each sentence.
- Use active voice with an explicit subject.
- Use present tense unless the time is important.
- Use imperative sentences for procedures: "Run the command." "Set the value."
- Use one term for one meaning. Do not add synonyms for variety.
- Use project terms exactly as the repo uses them.
- Define abbreviations the first time if the repo does not already make them obvious.
- Use "must" for a requirement and "must not" for a prohibition.
- Use "can" for ability or possibility.
- Use "do not" instead of "don't".
- Use "if" for conditions and "when" for time.
- Avoid idioms, metaphors, jokes, rhetorical language, and marketing language.
- Avoid vague intensifiers and filler words, such as "very", "basically", "obviously", "simple", "easy", and "just".
- Avoid long noun strings. Split them into shorter phrases.
- Prefer lists and tables for procedures, options, and conditions.

## Code Comments

The `writing-comments` skill holds the full comment rules. This section keeps a short version for text-editing work.

The default is to remove all comments. A well-written file has no comments. First make the code say it through a name, a value, or a structure. Keep a comment only in the rare case the `writing-comments` skill allows.

Keep a comment only when it explains why:
- A constraint exists
- An invariant must hold
- An external system behaves in a surprising way
- An edge case must be protected
- A tradeoff is intentional
- A workaround exists for a tracked defect or dependency behavior

Do not add comments that narrate what the code does or how it does it.

Bad:

```go
// Loop through users and add active users to the result.
for _, user := range users {
```

Good:

```go
// The API returns deleted users for 24 hours, so filter locally.
for _, user := range users {
```

If a language or linter requires an exported API comment, describe the contract or effect. Do not describe internal implementation steps.

## Documents And Guides

- Start with the user task or project outcome.
- Put prerequisites before steps.
- Use numbered lists for ordered steps.
- Use bullets for options and unordered facts.
- Show commands exactly as the user must run them.
- State the expected result after commands that change state.
- Keep warnings specific: state the condition, the risk, and the required action.
- Do not describe features, shortcuts, or workflows that the project does not provide.

## Self-Check

Before saving text, check:
- Does each comment explain why, not what or how?
- Can a name, function, or structure remove the need for the comment?
- Are sentences short and direct?
- Is each instruction or condition separate?
- Are terms consistent with the repo?
- Are requirements written with "must" or "must not"?
- Did you preserve identifiers, commands, and product names exactly?
