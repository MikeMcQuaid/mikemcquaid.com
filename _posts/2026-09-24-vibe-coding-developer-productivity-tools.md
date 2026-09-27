---
title: "Vibe Coding Developer Productivity Tools"
image: /images/a/agentide.png
description: "Agentic coding has let me replace everyday tools with software that works how I want."
---
I discussed in [my last post on the topic from April 2026]({% post_url 2026-04-14-sandboxed-agent-worktrees-my-coding-and-ai-setup-in-2026 %}) my agentic workflow using Superset, Fork and Zed.
I'm now completely off Superset and almost entirely off Fork and Zed by (vibe) building my own tool: [AgentIDE](https://github.com/MikeMcQuaid/AgentIDE/).
It's an "agentic IDE" built by me just for my workflows and it has made me more productive and happy working with agents.

## 🎄 Agents and Worktrees

Unfortunately, I'm fairly obsessed with continually improving my workflow to be more efficient.

I [submitted a few PRs to Superset](https://github.com/superset-sh/superset/pulls?q=sort%3Aupdated-desc+is%3Apr+state%3Aclosed+author%3AMikeMcQuaid) to try and make it work more how I wanted.

Fundamentally, though, there were a few big issues:
- I'm a macOS-only guy and I prefer native (i.e. Swift/Obj-C-based) tools
- I was using, and still loving, [Sandvault](https://github.com/webcoyote/sandvault) which Superset didn't interact with natively
- I wanted a way to run workflows remotely and couldn't at all trust a third-party service to do this
- I realised (quite late) that Superset isn't under a "real" (OSI compatible) open source software licence

No shade on the (great) Superset folks here: these are problems for me and not for most people.

I began to have a crazy idea: what if I just vibe-coded my own agent-first "IDE"?

## 🏗️ Vibe Engineering

I got [my brother](https://github.com/graeme), who has done a lot more Swift than I had, to help me design the architecture.
I leaned hard on strict compile-time checks, static analysis, testing and CI checks.
By the end of a weekend with Claude Max and Anthropic's Fable 5 model and ~4 hours interacting with my computer I had something that sort of worked.
Two weeks later, I'd entirely replaced Superset.
A week after that, I'd almost entirely replaced Fork and Zed.
I test all local changes manually before I merge them.

In the spirit of Unix philosophy, it builds heavily on a few other tools under the hood:
- `sv` ([Sandvault](https://github.com/webcoyote/sandvault)): creates the sandbox user and the shared workspace. Sandboxes your agent.
- `gh`: authenticate and communicate with GitHub. Agents never see it as it's only run as your user.
- [`herdr`](https://herdr.dev): used to multiplex agent sessions so they aren't tied to the GUI running.
- [`mosh`](https://mosh.org): used for more performant `herdr` sessions accessed from a phone.
- `brew` ([Homebrew](https://brew.sh)): install and update AgentIDE: I don't want to fuck around with the Mac App Store or Sparkle and this installs the above dependencies.
- [Moshi](https://getmoshi.app): an iOS SSH client for using `mosh` and `herdr` to communicate with AgentIDE agent sessions.

The beauty of building these tools for yourself is you can have whatever insane requirements you choose.
I was an early adopter of the macOS Golden Gate Public Beta so I thought, fuck it: I'll require that.
Because it was macOS only and I've got a newish MacBook: fuck it, I'll use Apple's local models for some stuff.

Shortly after Golden Gate got released, I had open-sourced AgentIDE.
It was added to Homebrew and used by a few coworkers and Homebrew maintainers.
You can install it now with `brew install agentide`.

## 🌊 AgentIDE Flow

![AgentIDE showing repositories, an agent session and a code review]({{ '/images/a/agentide.png' | absolute_url }})

It has a three-pane approach:
1. the left sidebar: lists all repositories/projects and any worktrees along with the branch/PR status
2. the middle pane: interact with your (sandboxed) OpenAI Codex or Claude Code agent.
3. the right pane: multi-function: review code/commits, view PRs and their blockers, syntax-highlighted text editor, shell, browser and application logs.

A typical session looks like:
- create a new worktree and agent session from a prompt, issue, existing PR or security advisory
- when the agent is done, review the code or commit(s), iterate until happy, edit by hand if needed
- open a PR, wait for CI results and code review from humans or Copilot
- pass any failing CI job logs or code review comments back to the agent, iterate until happy
- merge the PR, delete the worktree

I could do all this with Superset, it's just now I can do it all entirely in one app.
In the happy path where the agent one-shots the solution: I sometimes do all of this without typing a single character, only clicking.
I'm also nudged into the workflow I still want to use i.e. usually some manual code review before pushing (although, perhaps ironically, not for AgentIDE's Swift itself).
This was not easily possible with Superset, Fork and/or Zed.

## 🚅 Results

- I can do more work in less time
- I find it less frustrating because it works how I want (and when it doesn't: modification is trivial)
- Several coworkers and comaintainers get the above benefits, too

The biggest thing I never saw coming with agentic coding is just how easy it has become to build your own tools that work just how you want them.
Even if they aren't open source, even if no-one else ever uses them: if you use and prefer them: great.
If you know what you are doing and lean into [vibe/agentic engineering](https://simonwillison.net/2025/Oct/7/vibe-engineering/), you can get high quality software.
The wildest part: I have not (deliberately) read a single line of Swift code.
I don't need to.
It's been designed such that the trust boundaries are enforced by user separation and sandboxing through Sandvault.

Not everything needs to be as fully-featured and complex as what I've made here.
I've enjoyed a meeting reminder app called "In Your Face" for a few years and was paying £20 for its use.
I decided I'd try to build a replacement to address a few annoying edge cases.
Within ~2 hours it was just as good as In Your Face for my usage.
Within 2 weeks, it was better in every way.
It's called [MinMaxCal](https://github.com/MikeMcQuaid/MinMaxCal), it's also open source and can be installed with `brew install minmaxcal`.

![MinMaxCal showing calendar events, reminders and a meeting notification]({{ '/images/a/minmaxcal.png' | absolute_url }})

It has required even less maintenance than AgentIDE; less than an hour in months for a tool that Just Works.

## 🔮 Future

I am increasingly intolerant of friction in software.
I'll continue to try and contribute to open source projects to make this better.
When I can't, though, I'll just try to replace that software myself.
I've never had more fun building software and couldn't be happier with my output.

Think about how you can use these tools to improve your processes to make software more robust, reliable and performant.
Even if it's just for you: you will be happy you did.
