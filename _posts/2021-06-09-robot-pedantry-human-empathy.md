---
title: Robot Pedantry, Human Empathy
image: /images/a/robot-pedantry-human-empathy.png
redirect_from:
  - /2018/04/08/robot-pedantry-human-empathy/
  - /2018/06/05/robot-pedantry-human-empathy/
---

Homebrew was the first open source project I've maintained where I've had to review and merge contributions from other users. Homebrew is also one of the most active community projects on GitHub with a consistently small team of maintainers (always under thirty in total, always under ten doing work every week). As a result I've had to figure out over the last twelve years how best to manage large numbers of contributions from users in pleasantly and efficiently for both maintainers and contributors.

## 👩‍💻 Manual Process

I've [written before about how Homebrew's CI system has evolved over time]({{ '/2017/09/29/homebrew-ci-evolution/' | absolute_url }}) but not what I've had to learn to make it work as well as it does.

In the earlier days of Homebrew all review and testing was manual. This involved a maintainer checking out a GitHub pull request onto their local Homebrew installation and verifying it worked as expected. I'm obsessed in my personal, professional and open source lives in reducing the friction to perform common tasks so [my first commit to the Homebrew package manager (i.e. not a package) was to add a `brew pull` command to simplify this process](https://github.com/Homebrew/brew/commit/7933bd4e657ee82207914683d0e689c48465d83a).

When maintainers found problems in a pull request they reported back to contributors, contributors fixed them and the pull request got merged. Contributors did not expect a merge of their contribution unless it worked, after all. Where it got tricky was when a change "worked" but violated a technical standard. Often when giving feedback in these cases there would be accusations of pedantry or personal preference.

![brew pull command]({{ '/images/a/brew-pull.png' | absolute_url }})

The first attempt at addressing this was [the addition of a `brew audit` command](https://github.com/Homebrew/brew/commit/c51d74a2e36b9ca339a2b4ebd83c1c000e6f058b) by [@adamv](https://github.com/adamv) (the first Homebrew maintainer that wasn't [@mxcl](https://github.com/adamv), the creator of Homebrew). This command, simple at first, was turning lessons learned from code review into a command run to verify correctness. Maintainers and contributors ran this command on their local machines and contributors accepted that a warning flagged by this command was not personal preference but a codified standard.

## 🤖 Enter [BrewTestBot](https://github.com/BrewTestBot)

![brew-test-bot Kickstarter]({{ '/images/a/brew-test-bot-kickstarter.png' | absolute_url }})

This process still required a bunch of manual intervention from contributors and maintainers; what we needed was to automate this process. To meet this goal I started and ran a [successful Kickstarter project](https://www.kickstarter.com/projects/homebrew/brew-test-bot) to fund CI machines for Homebrew. After I'd set up these machines, the automatic `brew audit` of GitHub pull requests provided much quicker feedback to contributors.

I started to notice that when we turned "pedantic" comments by maintainers on pull requests into `brew audit` checks run locally and by CI, contributors ceased accusations of pedantry and usually complied without argument to the requests of the tool, often without any human intervention being necessary.

Over the years we've tried to turn all repeatable review comments into code checks on pull requests using `brew audit` and tools like [RuboCop](https://github.com/rubocop-hq/rubocop) to enforce consistent Ruby code style. This has now even enabled us to run `brew audit` checks directly in your text editor. This avoids different standards between maintainers and the previous arguments about pedantry: developers accept that robots are by definition pedantic and consistent so don't try to convince the robot to make an exception.

It's hard to state how much time it saves to not have arguments between maintainers and contributors on pull requests on style preferences or technical minutiae. Instead these discussions are on the original implementation of the rules instead of their application.

I've been glad to see this pattern expand to many other GitHub projects. [GitHub Actions](https://github.com/features/actions) has become an easy way to enforce checks onto your project. A particular favourite of mine is the [actions/stale](https://github.com/actions/stale) which closes issues and pull requests with inactivity.

## 🏎 Speedy Empathy

What robots can't do is empathy and building human communities. On a project like Homebrew that receives large numbers of contributions from large numbers of people, it's easy to overlook the work of the individuals that goes into it. A longer, heartfelt message on a less busy project becomes a "Thanks" on a busier one.

I wanted to address this but at the same time recognised that this isn't something to automate; a heartfelt thanks or welcome from a robot doesn't have the same degree of positive emotional impact as coming from a human. I wanted to make it as frictionless as possible to express my gratitude.

My first implementation of this was using [TextExpander](https://textexpander.com/) to allow me to e.g. type `;thx` and have it expand to `Thanks so much for your contribution! Without people like you submitting PRs we couldn't run this project. You rock!`. This can then be further tweaked to add their name, a note about their specific contribution or if it's their first to further add a human touch. People have told me both online (and in person when I've met them at conferences) that this made them feel great about their contribution and made them want to contribute again. They still felt this way even when I told them how I did so because they understood that my underlying gratitude is not proportional to the time I spent typing a message. A robot messaging them would not have had the same positive effect.

![GitHub saved replies]({{ '/images/a/saved-replies.png' | absolute_url }})

As I work at GitHub I've been able to further improve my process to [add keyboard shortcuts to GitHub's saved replies](https://blog.github.com/2018-03-02-saved-replies-keyboard-shortcuts/) which means that I don't need other software and can do this all in GitHub.

## ⚙️ Automate (Almost) Everything

My main takeaway from this has been that you should seek on your project to automate as much as you can ([particularly turning documentation into code](https://github.blog/2015-10-06-runnable-documentation/)), while remembering that the human touch is still necessary to praise and be kind to your contributors.

Let robots 🤖 handle your project's pedantry and humans 🥰 handle your project's empathy.
