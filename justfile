# Lint by default.
default: lint

# Install the repository's Git hooks.
@hooks:
    pre-commit install

# Run all static repository checks.
@lint:
    bash scripts/lint.sh

# Update all globally installed agent skills.
@update-skills:
    skills update --global --yes
