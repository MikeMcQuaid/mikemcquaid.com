---
title: Sanductor
layout: product
body_class: landing-page
permalink: /sanductor/
redirect_from: /agentide/
description: Run Claude Code and Codex safely in parallel, always in YOLO mode. Agents run as a sandboxed non-admin macOS user separate from yours, with no access to your home directory, tokens or environment variables.
repository: https://github.com/MikeMcQuaid/Sanductor
headline:
  - Run agents in parallel.
  - Keep your tokens private.
image: /images/a/agentide.png
image_alt: The worktree sidebar, an agent's terminal and its review beside it
image_width: 3110
image_height: 2070
image_caption: On the happy path, go from a GitHub issue prompt through code review comments and failing CI to a merged pull request, entirely by clicking in the app.
benefits:
  - title: Protect your personal account
    description: Give agents access to shared repositories while keeping your personal files, GitHub credentials and host environment variables private.
  - title: Keep multiple projects moving
    description: Give each task its own Git worktree and run Claude Code or Codex across repositories at once. See which agents are working, finished or waiting for you in one window.
  - title: You control sensitive actions
    description: Review diffs yourself in the app, request human review on GitHub or get AI feedback from a fresh agent, Copilot or CodeRabbit. You control signing, pushing and pull requests.
detail:
  label: Why I built Sanductor
  title: My credentials stay outside.
  description: |
    As Homebrew's Project Leader and a CTPO, I take both developer productivity and coding agent security very seriously.
    I assume any token an agent can access will eventually be misused.
    I want agents to work unattended without giving them my GitHub credentials or access to the rest of my home directory.
    Sanductor puts that workflow in one native macOS app.
  link: /sandboxed-agent-worktrees-my-coding-and-ai-setup-in-2026/
  link_label: My sandboxed Homebrew workflow
install_heading: Install Sanductor
install_command: brew install sanductor
install_note: >-
  The cask installs [`herdr`](https://herdr.dev), [`ripgrep`](https://github.com/BurntSushi/ripgrep)
  and [`gh`](https://cli.github.com). You'll also need Git, sandvault 1.29 or later with its sandbox user configured
  and Claude Code or Codex CLI signed in inside the sandbox.
credits: |
  ### Built on open source

  Sanductor is free and open source under the AGPLv3 licence.
  It uses [sandvault](https://github.com/webcoyote/sandvault) for user separation and macOS sandboxing,
  [`herdr`](https://herdr.dev) for persistent agent sessions,
  [`gh`](https://cli.github.com) for pull requests and
  [`ripgrep`](https://github.com/BurntSushi/ripgrep) for search.
links:
  - label: Discussions
    url: https://github.com/MikeMcQuaid/Sanductor/discussions
  - label: Releases
    url: https://github.com/MikeMcQuaid/Sanductor/releases
  - label: AGPLv3 License
    url: https://github.com/MikeMcQuaid/Sanductor/blob/main/LICENSE
---
