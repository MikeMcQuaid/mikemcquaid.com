---
title: Sanductor
layout: product
body_class: landing-page
permalink: /sanductor/
redirect_from: /agentide/
description: Securely run [Codex CLI](https://github.com/openai/codex) and [Claude Code](https://code.claude.com/docs) without permission prompts under a sandboxed non-admin user with no access to your credentials, environment or home directory.
repository: https://github.com/MikeMcQuaid/Sanductor
icon: /images/a/sanductor-icon.png
product_colour: green
minimum_macos: "26"
image: /images/a/agentide.png
image_alt: The worktree sidebar, an agent's terminal and its review beside it
image_width: 3110
image_height: 2070
image_caption: Go from an issue or security advisory, fixing code review comments and CI, to a merged pull request, entirely through buttons and no typing (in the happy path).
install_heading: Install Sanductor
install_command: brew install sanductor
credits: |
  ### Built on open source

  Sanductor is free and open source under the AGPLv3 licence.
  In the spirit of Unix philosophy, it combines small, effective standalone tools:
  [`sandvault`](https://github.com/webcoyote/sandvault) for user separation and macOS sandboxing,
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

I wanted one native macOS app for the workflow I had spread across Superset, Fork and Zed.
It has replaced Superset and almost all of what I used Fork and Zed for.
I use it for almost all my work on [Homebrew](https://brew.sh), beyond reviewing others' PRs on GitHub itself.

### No write access to my `$HOME` or GitHub

You know the "infinite monkeys with typewriters will eventually produce Shakespeare" idea?
Agents are the same.
Give an agent enough time and access and it will eventually `sudo rm -rf /` or, in my case, use a writable GitHub token to do bad things on Homebrew.
I don't trust agents nearly enough to give them GitHub write access and neither should you.

My agents run in parallel [Git worktrees](https://git-scm.com/docs/git-worktree) as a [sandboxed non-`admin` macOS user](/sandboxed-agent-worktrees-my-coding-and-ai-setup-in-2026/) (`sandvault-mike`), separate from mine (`mike`).
They cannot access my home directory, GitHub credentials, signing keys or host environment variables through good old Unix permissions and user separation.
[`sandvault`](https://github.com/webcoyote/sandvault) throws them in a sandbox too, for good measure.
That lets them work unattended without agent permission prompts.

### My Sanductor workflow

I start from a prompt, GitHub issue, existing pull request or security advisory.
When my agent is done, I usually [review the code myself](/why-open-source-maintainers-thrive-in-the-llm-era/) and reprompt as necessary.
When I'm happy, I sign, rebase, push and open a pull request with one click.
I then can wait for human or bot (e.g. CodeRabbit, Copilot) review or failing CI checks to pull these blockers into a prompt with one click.
Alternatively, if I'm confident they will be good, I can enable "autofix" to apply them automatically.

Agents keep running and stay reachable over SSH (only as the non-`admin` user) when I quit the Mac app.
There is no Sanductor account, subscription or hosted relay, and I have no plans to add one.
You shouldn't trust your agents and you shouldn't trust a relay to be able to have this level of access.
Also, even if your SSH gets compromised somehow, remember that user has no GitHub write access anyway.

If interesting, I've written more about [building Sanductor and my coding workflow](/vibe-coding-developer-productivity-tools/).

Enjoy Sanductor!
