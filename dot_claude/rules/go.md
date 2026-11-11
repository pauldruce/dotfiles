# Go

- Use the LSP tool to find a Go symbol: its definition, its references, and its implementations.
  If the LSP tool is not loaded, load it with ToolSearch first.
  Use `rg` only for text that is not a symbol, such as a string or a comment.
- Do not remove a flag that a Makefile or a task already sets, such as `-race`.
- Name a test file after the file that it tests: `appdata.go` has `appdata_test.go`.
- Do not put `if` or `switch` logic on test data in a test.
  Use a table-driven test, and use mocks for the dependencies.
