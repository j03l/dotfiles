# UV Python package manager aliases

# Project management
alias ui='uv init'
alias un='uv init --name'
alias us='uv sync'

# Package management
alias ua='uv add'
alias ur='uv remove'
alias ul='uv lock'

# Virtual environment
alias venv='uv venv'
alias uva='source .venv/bin/activate'

# Running commands
alias uu='uv run'
alias up='uv run python'
alias upi='uv run python -i'

# Tool management
alias ut='uv tool'
alias uti='uv tool install'
alias utr='uv tool run'

# Python version management
alias upy='uv python'
alias upyl='uv python list'
alias upyi='uv python install'

# Common development tasks
alias utest='uv run pytest'
alias ufmt='uv run ruff format'
alias ulint='uv run ruff check'
alias userver='uv run python -m http.server'
