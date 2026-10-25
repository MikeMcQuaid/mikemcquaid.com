---
title: AgentIDE
layout: product
body_class: landing-page
permalink: /agentide/
description: A native macOS app for Claude Code and Codex. Take a GitHub issue through coding, review and a merged pull request entirely by clicking.
repository: https://github.com/MikeMcQuaid/AgentIDE
headline:
  - From issue to
  - merged pull request.
image: /images/a/agentide.png
image_alt: The worktree sidebar, an agent's terminal and its review beside it
image_width: 3110
image_height: 2070
image_caption: A native SwiftUI workspace with repositories, agent conversations and code review in one window.
benefits:
  - title: Start from an issue
    description: Select a GitHub issue and launch Claude Code or Codex to work on it. Each task gets its own git worktree, so several agents can work at once.
  - title: Review and fix
    description: Read the diff beside the conversation. Request an agent, Copilot or CodeRabbit review, then start an autofix loop to address review comments and failing checks.
  - title: Merge the pull request
    description: Use an AI-drafted commit message, sign and push, then open and merge the pull request. Split larger changes into stacked pull requests and merge them from the app too.
detail:
  label: Built with SwiftUI
  title: A native Mac app.
  description: |
    Native windows, menus and notifications, with Shortcuts and Siri support for starting work.
    Agents run as a separate, non-admin sandvault user, away from your personal files and credentials.
    Their sessions keep running when you close the app.

    Schedule recurring tasks daily, weekly or monthly while the app is open.
    See agent activity and CI checks across repositories in the sidebar, with notifications when an agent finishes or needs you.
  link: /sandboxed-agent-worktrees-my-coding-and-ai-setup-in-2026/
  link_label: The workflow behind AgentIDE
install_heading: Install AgentIDE
install_command: brew install --cask agentide
install_note: >-
  The cask installs [`herdr`](https://herdr.dev), [`ripgrep`](https://github.com/BurntSushi/ripgrep)
  and [`gh`](https://cli.github.com). You'll also need Git, a configured sandvault user
  and Claude Code or Codex CLI signed in inside the sandbox.
credits: |
  ### Built on open source

  AgentIDE uses [`herdr`](https://herdr.dev) for persistent agent sessions,
  [`gh`](https://cli.github.com) for pull requests and
  [`ripgrep`](https://github.com/BurntSushi/ripgrep) for search.
  All three are installed by [Homebrew](https://brew.sh).
links:
  - label: Discussions
    url: https://github.com/MikeMcQuaid/AgentIDE/discussions
  - label: Releases
    url: https://github.com/MikeMcQuaid/AgentIDE/releases
  - label: AGPLv3 License
    url: https://github.com/MikeMcQuaid/AgentIDE/blob/main/LICENSE
---
