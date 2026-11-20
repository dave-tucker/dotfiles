# Agent guidance

## Validation

Run `scripts/lint.sh` for static syntax, style, and formatting checks.

For a changed chezmoi template, perform task-local validation: render the affected branch with `chezmoi execute-template`, inspect the output, and run the parser or command appropriate to that output. Keep these checks in the work session rather than adding repository tests for chezmoi's role or OS gating behavior.
