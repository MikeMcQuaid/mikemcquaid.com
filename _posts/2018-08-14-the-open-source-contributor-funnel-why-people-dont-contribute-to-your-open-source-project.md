---
title: "The Open Source Contributor Funnel (or: Why People Don’t Contribute To Your Open Source Project)"
image: /images/a/the-open-source-contributor-funnel.png
redirect_from:
- /2018/08/14/the-open-source-contributor-funnel/
- /2018/08/14/the-open-source-contributor-funnel-why-people-dont-contribute-to-your-open-source-project/
---

Homebrew, the macOS package manager I maintain, is one of the most active community projects on GitHub. We regularly attract large numbers of new contributors and valuable, [first-time open source contributions]({% post_url 2019-02-16-stop-mentoring-first-time-contributors %}). We've done this by thinking about our users, contributors and maintainers going through a "contributor funnel". If you're wondering why people aren't contributing to your open source project (😭): thinking this way will help you fix this.

### Who uses your software?

Let's start with defining groups of open source project users by looking at how they are interacting with your project.

- 👩‍👩‍👧‍👦 the **users** of an open source project are the people who use the software but aren't submitting code, documentation or performing issue triage. They may file issues but often these will be more of a "please help me" than a reproducible bug. Hopefully the project has at least one user: you.
- 📣 the **contributors** to an open source project are those who are submitting code or documentation (i.e. as a pull request if on GitHub) but need someone to give them code review and merge their contribution. They do not have commit access to merge their own changes. You may not have any contributors to your project (yet).
- 🛠 the **maintainers** of an open source project are the people who review and merge contributors from contributors and generally run the project. They have commit access. A maintained project has at least one of these: the person who started the project. Once there are no more maintainers, the project is abandoned.

You want to have more contributors and maintainers on your project. A few guidelines in thinking about this:
`

- most contributors were users first ("scratching your own itch": most people start contributing to an open source project to solve a problem they are experiencing)
- most maintainers were a contributor and user first (people don’t just jump into maintaining a project without helping to build it first)
- maintainers cannot do a good job without remaining a user (to maintain context, passion and empathy)

Combined, these start to look a bit like a [sales funnel](https://www.mailmunch.com/blog/sales-funnel/). People have to travel through each of the stages and there's a fairly hefty drop-off at each one.

![The Open Source Contributor Funnel]({{ '/images/a/the-open-source-contributor-funnel.png' | absolute_url }})

In Homebrew's case, we have millions of users, thousands of contributors and tens of maintainers (ever). Think about these numbers when you're wondering why your project with ten users doesn't have more contributors. That said, you can help to push people through this funnel with some gentle nudges.

### How to get more, better contributions

![Twitter mention to issue report]({{ '/images/a/twitter-issue.png' | absolute_url }})
When your project gets a random Twitter mention you can consider asking them to submit an issue instead (and your issue template may help them submit a good one).

![Step by step issue creation guide]({{ '/images/a/step-by-step.png' | absolute_url }})
If you get a bad issue report consider asking people questions like this to figure out what the actual problem is and teach people how to file better issues in future.

![Try to open a pull request]({{ '/images/a/try-open-pr.png' | absolute_url }})
People will need encouragement to fix their own issues. Encourage them to submit a pull request rather than just asking for help. It helps if you can document how to create pull requests for your project (e.g. check out [Homebrew's "How To Open A Homebrew Pull Request" documentation](https://docs.brew.sh/How-To-Open-a-Homebrew-Pull-Request.html)). You may need to help some people use Git and GitHub to do this. Some people have amazing coding skills but have not used GitHub before.

Look at the contributors to your project to find new maintainers but bear in mind new maintainers will usually need to be talked into it. Maintainers don’t tend stick up their hands and say “me me”; in my experience, when they do it’s often a bad sign. They need to be encouraged and invited. Document what the expectations are for maintainers so they can see before you ask them (e.g. check out [Homebrew's "New Maintainer Checklist" documentation](https://docs.brew.sh/New-Maintainer-Checklist.html).

### Do you have a leaky funnel?

There's no point in you getting more contributors, maintainers and even users if they leave your project quickly. I’m not talking about their initial attraction but retention on your project. Each group of your users need different things to stick around:

- 👩‍👩‍👧‍👦 **users**:
  - 💰 Keep your project high quality. If you do a mass refactoring and introduce loads of bugs: people aren't going to want to use your software.
  - 😰 No "guilty merges". Don't merge work from contributors you know isn't good enough just because you feel bad about the work they've put in.
  - 🏗 No v2.0. By this I mean don't do a mass rewrite or refactor that makes using your software radically different. Respect your users' existing workflows and learnings on how to use your software.
- 📣 **contributors**:
  - 🚳 No [bikeshedding](https://en.wiktionary.org/wiki/bikeshedding). Avoid long discussions about things that don't really matter. It's a waste of everyone's time.
  - ☎️ Open discussions. Conversely, ensure there's a place contributors can talk about the development of your software and ask questions that aren't bug reports.
  - 🔐 No feature issues. Don't fill your issue tracker with "feature requests" you know will never be implemented. Learn to say "no".
- 🛠 **maintainers**:
  - 💝 Code of Conduct. These help set expectations of acceptable behaviour on a project. Toxic users, contributors or maintainers make open source no fun and people don't want to spend their time on projects that aren't fun.
  - 🔏 Private chat. Give the maintainers somewhere to bond, discuss and resolve conflict privately. Not everyone feels comfortable doing this publicly.
  - 🌳 Keep adding maintainers. Most maintainers have a shelf-life so you need to keep looking for more maintainers for when the current ones leave. This also allows people to focus on the bits they find most enjoyable.

After doing the above you'll understand why people contribute to your project 😍 (and how to find more). Good luck!
