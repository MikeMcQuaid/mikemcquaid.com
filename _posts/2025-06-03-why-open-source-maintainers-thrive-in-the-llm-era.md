---
title: Why Open Source Maintainers Thrive in the LLM Era
---

At the time of writing (June 2025), the prevailing view in the software industry is that LLM-powered AI is either completely useless or will imminently destroy all software engineering jobs.
As you might expect, the reality is somewhere in between.
In this post, I'll share my journey with LLM tooling, from reviewing an early, internal alpha of GitHub Copilot to my current daily usage of Cursor, ChatGPT, and the latest Copilot offerings.
My perspective is that of a startup founder (of Workbrew) and long-time open source software maintainer (of Homebrew)

![Mike in Homebrew beer costume]({{ '/images/a/homebrew_beer_mike.jpg' | absolute_url }})

## 🎨 Background

I've been in open source for 20 years and in tech professionally since 2007.
My primary languages evolved from Java to C++ to Ruby, with production work in many others along the way.
Across the years and these various ecosystems, I've seen many different ways of building software.
Some ecosystems lean heavily into static checking, types and linting.
Others rely on high levels of test coverage, pairing or microservices.
While these approaches seem disparate, at various times, each has been championed as "The One True Path" to perfect software.

Modern LLMs, however, are perhaps the first technological shift in my entire career that truly feels likely to change everything.

## 🐣 Early LLMs

My first experience with LLMs was reviewing an early, internal alpha of GitHub Copilot for VS Code.
At GitHub, I was often tapped for such reviews, largely due to my dual role as an active open-source maintainer and an internal feature contributor.
Probably most importantly, though: even when it was politically inadvisable to say something was total shit: I would give that feedback were it the case.

I was very quickly and pleasantly surprised by GitHub Copilot.
When I used Eclipse for writing Java in the ~2005-7 era, it was joked that you could "Ctrl-Space your code into existence".
Given the hellish amount of boilerplate Java required in those days, that was much appreciated.
Copilot finally offered that same magic for Ruby: a decent autocompletion engine, something I hadn't found across many Ruby IDEs or plugins.
It immediately felt like it was saving me a bunch of typing and reminding me of APIs that I had forgotten.

The obvious downside of this early Copilot and ChatGPT 3 era was the regularity and sometimes subtlety of its hallucinations.
If you carefully reviewed everything it spat out, this wasn't a big problem.
I still found it to be faster than doing things entirely manually and missed Copilot in environments where I couldn't use it.
At this stage, ChatGPT felt more like a toy; I didn't trust its output over Google, and it couldn't provide (non-hallucinated) citations for verification.

## 🪏 Digging In

By the time ChatGPT 4 was rolling out, I was still a regular GitHub Copilot in VSCode user but had been mostly ignoring other AI developments.
I'm always keen to stay up-to-date and started hearing more engineers I respected finding value in these tools.
I decided to dive in: paying for ChatGPT, trying (and then paying for) Cursor, and defaulting to ChatGPT over Google.

Fast forward to 2025: paid-tier LLM hallucination rates are dramatically lower.
Genuinely useful agents are emerging, and I can now leverage citations to "trust but verify" LLM output effectively.
I now rarely use Google, defaulting to ChatGPT, especially for deep dives into niche technical topics.

## 🧐 Philosophy

There's a wide array in the degree of trust people give to LLMs.
Some argue that any possibility of hallucination renders them unworthy of attention.
Others "vibe-code" entire applications without reviewing any of the generated code.

The analogy that has resonated with me comes from open source: the "first time contributor".
It's fairly common on a project like Homebrew that you'll get a non-trivial pull request from someone you've never seen on the project before.
This contributor might have no prior open-source activity, no GitHub bio, or even an avatar.
How do you assess the trustworthiness of such a person's pull request?
By thoroughly reading, discussing, linting, and testing the code as required.

LLM code (or, to a lesser extent, prose) output is similar.
It might be absolutely perfect the first time.
It might be irredeemably terrible or wrong.
The only way to find out is to review the output.

Open-source maintainers, especially on projects like Homebrew, have honed the skill of rapidly reviewing large volumes of unfamiliar or newly contributed code.
This skill is useful, perhaps even essential, for effectively leveraging LLM output.
I suspect at least some of the loud LLM skeptics are actually just very poor at code review and have no interest or desire to get better.
AI code review tools (e.g. Copilot, CodeRabbit) are good companions to human code reviewers, particularly for [pedantry](https://mikemcquaid.com/robot-pedantry-human-empathy/), but not replacements.

Similar to managing open-source contributions, a few strategies can optimise both human and LLM-generated work.
First, consider giving up when it's clear the amount of back-and-forth is actually slower than you just manually doing it yourself.
Second, heavily leverage linting, testing, and other automated tooling to establish robust [guardrails](https://mikemcquaid.com/ruby-on-guard-rails/).
With LLM agents, you can even instruct them to self-verify their output by executing relevant commands or tests.
For example, when working on Homebrew, I'll ask agents to run `brew style` (for RuboCop code linting), `brew typecheck` (for static type checking) and `brew tests` (for unit tests) to automatically verify behaviour.

## 📵 LLM Modes

Based on these learnings, I've developed a few distinct "LLM modes" in my workflow:

1. Constantly: I'm writing code, my editor of choice (Cursor, today) is just providing a nice autocomplete and quick, inline lookup for stuff I've forgotten.
2. Regularly: I'm blocked and would normally be Googling or looking at Stack Overflow for a solution.
   Instead, I'll now ask the LLM in my editor or ChatGPT for a solution or ideas.
   This excels at rapidly deciphering confusing error messages or sifting through large log dumps to pinpoint the source of issues.
3. Rarely: I get the LLM to generate a large amount of boring and fairly trivial code based on a lot of initial research I've done.
   An example would be in the [MCP Server for Homebrew](https://github.com/Homebrew/brew/pull/20041) where I got Cursor to generate a first pass for a couple of methods.
   I then edited this extensively and made it look and work how I wanted through manual edits and LLM refactoring.
   After this, I used it to similarly generate most of the first versions of the unit tests to hit decent code coverage.
   Throughout this process, I maintain frequent local `git` commits, enabling me to use `git diff` for careful review of each generated change.
4. Rarest: I haven't decided how I want something to work yet, so I get LLM to generate all of the code, don't even look at the code and repeatedly change prompts based on the generated UI or CLI output.
   Once the functionality is achieved, I then step away, and the following day, conduct a thorough line-by-line review and editing pass.
   This was similar to the writing workflow I took when writing [Git in Practice](https://mikemcquaid.com/gitinpractice/) where I'd write until I hit a page count without reading things back and then do an edit pass the next day.
   Similarly to writing, there's limit as to how much code you can effectively review like this so you need to avoid things ballooning out of control.

I would say I do 1) hourly, 2) daily, 3) weekly and 4) monthly at this point.
This pattern emerged from a continuous assessment of what maximises my personal and team productivity, balancing rapid development while minimising bugs for users.

## 🪩 Reflection

I've found LLM tooling like Cursor and ChatGPT to be an essential part of my workflow.
Depending on the task, I'd say they provide anywhere between a 1% to 100% speedup.
For me, ChatGPT has replaced 99% of my prior Google usage.

I'm genuinely curious to see what the future holds for LLMs.
I suspect with AI hype, we're seeing a certain amount of the
[Gell-Mann amnesia effect](https://en.wikipedia.org/wiki/Gell-Mann_amnesia_effect)
i.e. people find AI the most impressive when performing tasks they are the least familiar with.
Similarly, as much as people talk about "exponential progress" with AI and imminent AGI (whatever that means today), it's feeling more like asymptotic progress on the underlying technology.
I expect the remaining large user-facing improvements of this generation of AI to be primarily be around UI and UX.
The belief that we'll "any day now" achieve deterministic results from fundamentally stochastic systems seems to stem from either a technological misunderstanding or wishful thinking.

All that said, [I'd rather hire someone today](https://mikemcquaid.com/how-and-why-i-interview-engineers-for-workbrew/) who overuses LLM tooling over someone who refuses to use any.
Ultimately, as technologists in a for-profit company within a capitalist economy, we are hired to generate business value.
LLM tools allow businesses to do more (features, tests, automation, etc.) with less (employees, hours, budget).
Lean into that.
The LLMs aren't going to take your software job, but they will let you be better at it.

Many promising engineers end up descending into masturbatory levels of obsession with how code looks rather than how value is generated.
Ultimately, the business may decide it wants a shitty, vibe-coded app tomorrow rather than your perfect code in 6 months.
Yes, ChatGPT may generate "junior engineer"-level code, but it's also a wee bit cheaper than any junior engineer I've found.

The optimal path in 2025 is to embrace LLM tools, balancing pragmatic optimism with healthy skepticism regarding dramatic claims from either side.
Build your app with [guardrails](https://mikemcquaid.com/ruby-on-guard-rails/) to protect both human and AIs from stupid mistakes.

Let's build some cool shit (and faster than we could in 2020).
I've helped companies dramatically boost developer velocity and PR throughput (e.g. by 40%) through smart automation and AI integration.
If you're looking to optimise your team's workflow in the LLM era, [email me and let's talk](https://mikemcquaid.com/about/).

---

Thanks to [Luke Hefson](https://lukehefson.com), [Justin Searls](https://justin.searls.co/), [Gemini 2.5 Flash](https://gemini.google.com/) and [ChatGPT o3](https://chatgpt.com) (I also tried but didn't like the feedback from ChatGPT 4.5, ChatGPT 4o and Claude Sonnet 4) for reviewing drafts of this post.
