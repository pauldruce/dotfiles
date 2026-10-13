---
name: writing-comments
description: Use when adding or updating a code comment or doc comment in any language. The rule is remove all comments, all the time - the outcome is DELETION. A comment is a defect you remove, not prose you polish. Make the code read clearly through names and structure; a named const, value, or type carries the fact a comment would, so the comment is redundant. A comment survives only if you can name a specific wrong edit a competent engineer would plausibly make during normal maintenance that nothing else - compiler, linter, or a test - would catch. A failing test is always the better guard; write the test, not the comment, whenever a test can catch the edit. The other exception is workflow/system-test step outlines. Trimming or rewording a bad comment - including deleting one clause and keeping another - is not the fix; delete it and move any real fact into the code or a test.
---

# Writing Comments

Use this skill when you add or change a comment in code, in any language.

## Remove All Comments

The rule is: remove all comments, all the time. Deletion is not the likely
outcome of this task - it is the outcome. Start from zero comments and stay there.
A comment is a defect you are removing, not prose you are polishing. If you finish
and a comment is still there, that is the surprising outcome - it needs a hard
reason, and the bar below is deliberately almost impossible to clear.

Write no comment. This is not "write fewer comments" - the working assumption is
that a comment must not be there at all. A comment is a sign the code failed to
say the thing by itself, so the fix is to make the code say it, not to add prose.

Outside the two named exceptions below - a comment that names a wrong edit no test
can catch, and workflow-test step outlines - a well-written file has no comments.
Most files have none. Across a whole change you keep zero, and that is the normal,
correct result. If you are keeping one, assume you are wrong: fix the code, or
write the test that guards the edit instead.

A comment is a cost. It goes stale, it repeats what the reader can already see,
and it hides a weak name or a weak structure behind an apology.

### A name already carries the fact

The most common self-deception is a comment that "explains" a declaration whose
name already says the same thing. The name is the explanation; the comment is
redundant narration. Delete it.

Bad - the comment restates what the two names already say:

```go
// The second argument controls whether close asserts the server logged no ERROR
// lines. It does not control the process lifecycle. These name the two intents.
const (
	assertNoErrorLogs = true
	allowErrorLogs    = false
)
```

`assertNoErrorLogs` and `allowErrorLogs` are the whole point - a reader who sees
`CleanupSession(session, allowErrorLogs)` needs no prose. Delete the comment. If
the name is not enough on its own, the fix is a clearer name or type, never a
comment.

## The Test: Name The Wrong Edit

Do not ask "is this surprising" or "does this help" - you will always answer yes,
and every line will earn a comment. Ask a falsifiable question instead. A comment
survives only if you can finish this sentence with a concrete, specific action:

> "Without this comment, a competent engineer who knows this language and this
> domain would **[make this exact edit]**, and it would break the code or the
> test."

The edit must be nameable: a rename, a "simplification", a refactor, an import,
a deleted line. If you cannot name the specific wrong edit, there is nothing to
protect - delete the comment. "It documents the design", "it explains the
intent", and "it helps the reader" do not name an edit. They are not reasons.

Names a real wrong edit - keep:

```go
// embed paths are always slash-separated, so path.Join, not filepath.Join.
return files.ReadFile(path.Join("testdata", name))
```

Without it a reader "fixes" `path.Join` to `filepath.Join` and breaks Windows.

Names no wrong edit - delete:

```go
// A wedged CLI would otherwise block until the package timeout, so bound it.
ctx, cancel := context.WithTimeout(t.Context(), timeout)
```

A deadline on an external call is standard. Nobody edits it wrong without the
comment. Delete it.

## Challenge The Wrong Edit

Naming a wrong edit is not enough - you can always invent one. This is exactly how
a bad comment survives: you picture someone changing the line, call the comment its
guard, and keep it. Attack the edit you named. It counts only if both hold:

- **Plausible.** A competent engineer doing ordinary maintenance would actually make
  it - a refactor, a rename, a consistency cleanup. Not vandalism, not "what if
  someone deletes the whole line".
- **Silent.** The compiler, the linter, and the existing tests all stay green while
  the edit is wrong. If any of them already catches it, that mechanism is the guard
  and the comment is redundant.

Apply both to the two examples above:

- The timeout comment fails both. "Someone removes the deadline" is not ordinary
  maintenance, and if it happened a test would hang - loud, not silent. Delete it.
- The `path.Join` comment passes both. "Normalise to `filepath.Join` for
  consistency" looks like a cleanup (plausible) and stays green on Linux CI,
  breaking only on Windows (silent). Keep it.

## A Failing Test Beats A Comment

When the wrong edit is plausible and silent, do not reach for a comment first -
make the edit loud. A test that fails on the wrong edit is a far stronger guard:

- It runs. A comment sits there hoping to be read; a failing test blocks the merge.
- It cannot rot unseen. If the code drifts the test breaks; a stale comment lies
  quietly and misleads.
- It states the invariant by example, in code the reader already trusts.

So when you find a plausible, silent wrong edit, add the test that catches it and
write no comment. Reach for a comment only in the narrow cases where no test you
can run would catch the edit:

- **It breaks only where your tests do not run** - a platform or environment CI
  does not exercise, such as a Windows-only path bug when CI is Linux-only.
- **The test would be edited too.** A deliberately surprising behaviour that a test
  already pins, which a maintainer would "fix" by changing the test and the code
  together. The comment tells them the behaviour is intended, so they stop.
- **It surfaces far from the change.** Fixture or seed setup where a mismatch is not
  a compile error but a failure somewhere else at run time, with no clear cause.

If none of these applies, the comment is redundant with a test you should write
instead. Write the test.

## These Are Not Surprises

Agents keep classifying ordinary code as surprising. These never earn a comment:

- A timeout or deadline on an external call, subprocess, or request.
- Error wrapping, logging, retries, or a `defer` cleanup.
- What a test helper does - its signature and name show it.
- "We reuse this slice / this variable" - the reader sees the variable.
- Restating what an assertion, condition, or return checks.
- A standard-library idiom any competent user of the language knows.

## Trimming Is Not The Fix

Do not shorten or reword a bad comment. A shorter narration comment is still a
narration comment. The only two moves are:

- **Delete it** and, if it was carrying a real fact, move that fact into a name
  or a structure. This is the answer almost every time.
- **Keep it in full** because it clears the test above. Rare.

Deleting one clause and keeping another is trimming. When a comment mixes a real
fact with narration, do not "keep the good half" by reflex. Delete the whole
comment, then ask the test above of the bare fact from a blank slate: keep it only
if that fact, alone, names a wrong edit that is plausible, silent, and beyond a
test to catch. Otherwise it all goes - into a name, a structure, or a test.

There is no "tidy it up" middle option. If your instinct is to reword a comment
to make it acceptable, that instinct is telling you to delete it.

## Make The Code Readable First

Before you keep a comment, remove the need for it. Work through these in order.
Each one moves the fact into the code, where it cannot go stale.

1. **Rename.** Put the reason in the name. A loop over "all scopes" reads best
   from a variable named `allScopes`, not from a comment above a raw slice.
2. **Extract a named value.** Give an intermediate result or a literal a name
   that states its role. A `const` or a well-named variable often replaces a
   whole sentence.
3. **Extract a named function or helper.** A call named for its purpose
   (`rejectBeforeSideEffects`, `assertOwnerOnly`) says what a comment would say.
4. **Restructure.** Split a step out, reorder, or add a named type so the shape
   of the code shows the intent.
5. **Use the test name and structure.** In a unit test, the reason usually belongs
   in the test name and the Arrange / Act / Assert blocks, not in prose. A subtest
   named for the scenario removes the comment above it.
6. **Write a test.** If the reason is that a wrong edit would break behaviour, add
   the test that fails on that edit. The test guards the invariant where a comment
   only hopes to. See "A Failing Test Beats A Comment".

If any of these carries the reason, do that and write no comment.

This section is about removing comments that describe code. It does not apply to
step comments in a workflow test - see the next section.

## Workflow And System Tests Are Different

A system or workflow test documents a product workflow: the ordered steps a user
or a caller goes through, and the state the product must hold after each one. Here
the sequence of steps is the thing under test, so step comments are wanted. They
give the reader the workflow at a glance, independent of the API calls that
implement each step.

Outline the workflow with short step comments:

```go
// Step 1: register the toolkit's marketplace.
sut.UpdateMarketplace(groups)
// Step 2: install the skill groups at the user scope.
sut.ApplySkillGroups(groups, userScope)
// Step 3: clean up, and confirm the plugins are uninstalled.
sut.Cleanup()
```

A step comment names the workflow step in domain terms - "register the
marketplace", "install the skill groups" - not the Go call. It is the one place
the "what" is worth stating, because the test exists to pin that sequence.

Keep the rest of the rule inside each step. Do not restate an assertion, and put
a comment that names a wrong edit on its own line as usual. This exception covers
the step outline, not every line of the test.

## Do Not

- Do not narrate what the next line does.
- Do not restate the next line, an assertion, or a variable in words.
- Do not explain a step that a better name would explain.
- Do not use a comment as a documentation dump.

Bad - narrates the code:

```go
// increment the counter
counter++
```

Bad - restates a call the reader can see:

```go
// Reuse the same group slice so both calls land on the same toolkit.
sut.UpdateMarketplace(groups)
sut.ApplySkillGroups(groups, scope)
```

The reader can see it is the same `groups` variable. Delete the comment.

Good - names the wrong edit an outside fact would cause:

```go
// The API counts from 1, so align the local index before the lookup.
counter++
```

## Go Rules

- Do not write a package comment. A file header is separated from `package` by a
  blank line, so it is not a package comment.
- Do not write a doc comment whose first word is the declared name of the
  `func`, `type`, `var`, or `const`. Go doc linters ask for this pattern. This
  repo forbids it, because it narrates the name instead of the reason.

## Exported API

If a language or linter requires a comment on an exported item, describe the
contract or the effect. Do not describe the internal steps.
