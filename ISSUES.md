# XestiText — Issue Analysis Report

## Overview

This report documents issues found during analysis of the XestiText repository.
The project builds cleanly (Swift 6.2, language mode v6) and all 6 existing tests
pass. Of the 12 issues identified in the original analysis, 9 have been resolved
and 3 remain open.

---

## Resolved Issues

### ~~1. README references wrong project name~~ — FIXED

**Commit:** `ed4ef32 Update project name from XestiXML to XestiText`

Line 19 of `README.md` now correctly reads "XestiText".

---

### ~~2. Infinite loop in `wrapping(at:)` when `width <= 0`~~ — FIXED

**Commit:** `01ada4f Add guard for positive width in wrapping function`

`String+Wrap.swift` now guards `width > 0` before proceeding, returning
`[self]` for non-positive widths.

---

### ~~3. `Formatter.hangIndent` can trigger the infinite loop~~ — FIXED

**Commit:** `4230f6e Refactor text wrapping logic in Formatter.swift`

`Formatter.swift` now computes `wrapWidth = totalWidth - columnWidth` and
guards `wrapWidth > 0`, returning `result + text` when the wrap width is
non-positive.

---

### ~~4. `Table.Renderer` doesn't validate `header.span`~~ — FIXED

**Commit:** `d13d0f7 Adjust header span calculation to respect column count`

All three sites in `Table.Renderer.swift` that use `span` now clamp it with
`min(table.configuration.header.span, columnCount)`, preventing out-of-bounds
access into `colWidths` and `centerJoiners`.

---

### ~~5. `repeating(to:)` crashes on negative count~~ — FIXED

**Commit:** `6704178 Prevent repeating string for non-positive counts`

`String+Repeat.swift` now guards `count > 0`, returning `""` for non-positive
counts instead of forwarding to `String(repeating:count:)`.

---

### ~~6. Documentation examples in `String+Wrap.swift` show wrong output~~ — FIXED

The doc comments now use a shorter example string (`"The quick brown fox …"`)
with accurate output for both `wrapping(at:)` and `wrapping(at:splitWords:)`.

---

### ~~7. `TableMaker.Column` inits allow invalid state~~ — FIXED

Both initializers in `TableMaker.Column.swift` have been corrected:

- **Fixed-width init:** `width` is clamped between `minimumColumnWidth` and
  `maximumColumnWidth` before assigning both `minimumWidth` and `maximumWidth`
  to the clamped value.
- **Flexible init:** After independently clamping the two parameters, the
  results are reconciled so that `maximumWidth >= minimumWidth` is always true.

---

### ~~8. `TableMaker.make()` crashes on empty rows~~ — FIXED

`TableMaker.make()` now includes a precondition that checks `!isEmpty`,
providing a clear message before the downstream `Table.init` precondition
would fire.

---

### ~~9.~~ — NOT FIXED (would break API)

See open issue #9 below.

---

### ~~10. `Terminal.swift` uses Darwin symbols without explicit import~~ — FIXED

`Terminal.swift` now includes platform-conditional imports for `Darwin` and
`Glibc`.

---

## Open Issues — Design / Robustness

### 9. `JSONFormatter.format()` silently returns empty string on failure

**File:** `Sources/XestiText/KeyValueFormat/JSONFormatter.swift`, lines 44–51

JSON serialization or UTF-8 encoding failures are silently swallowed, returning
`""`. Callers cannot distinguish "empty result" from "serialization error."

The natural fix — making `format()` throw — would be a breaking change to the
`KeyValueFormatter` protocol and all downstream consumers. Documenting the
silent-failure behavior (done) is the only non-breaking mitigation.

---

## Open Issues — Test Coverage Gaps

### 11. Most source files have no tests

Only 6 of 25 source files have corresponding tests:

| Has Tests              | No Tests                          |
|------------------------|-----------------------------------|
| String+Compress        | Table (all 6 files)               |
| String+Fit             | TableMaker (all 4 files)          |
| String+Pad             | KeyValueFormat (all 4 files)      |
| String+Repeat          | Terminal                          |
| String+Truncate        | Formatter                         |
| String+Wrap            | String.Box, String.Alignment      |

### 12. Existing tests are missing edge cases

Even the tested extensions lack coverage for important scenarios:

- **All extensions:** No tests for `width <= 0` or `width == 0`.
- **`String+Fit`:** Only tests `.center` alignment; `.left` and `.right` are
  untested. Never tests `usingEllipses: true` (the default).
- **`String+Wrap`:** No tests for empty strings, `splitWords: false` with a word
  longer than `width`, or `width == 1`.
- **`String+Repeat`:** No tests for `count == 0` or `count == 1`.
- **`String+Pad`:** No tests for empty strings or `width == count`.
- **`String+Truncate`:** No tests for empty strings, `width == 1` with ellipsis,
  or `width >= count`.
- **`String+Compress`:** No tests for empty strings or all-whitespace input.
