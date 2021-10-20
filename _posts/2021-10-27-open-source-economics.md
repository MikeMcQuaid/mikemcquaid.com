---
title: Open Source Economics (is not what you think)
image: /images/a/open-source-economics.png
---

"Open Source Economics" and the "Open Source Economy" are regularly discussed in the context of how to improve open source software's sustainability, contributor diversity and ecosystem quality. Too often, though, the use of the word "economics" brings incorrect assumptions about the problems to be solved.

### 👎 What aren't "Open Source Economics"?

When most people hear the term "economics" they tend to think about how 💵💶💷💴 flows around an economy and, particularly in a capitalist economy, how the allocation of capital affects the throughput of businesses operating in a free market.

As a result, when people hear the term "open source economics" they tend to jump to the same conclusions: it's about how 💵💶💷💴 flows between and is invested in open source projects. This is not a bad conclusion, it results in the creation of tools such as [GitHub Sponsors](https://github.com/sponsors) that benefit many open source maintainers but it's not the whole picture.

![GitHub Sponsors]({{ '/images/a/github_sponsors.png' | absolute_url }})

When you look just at the financial side of open source projects you tend to assume any problems they suffer are due to a lack of investment and can be solved by adding more 💵💶💷💴. For example, if a project struggles to make releases, review and merge pull requests, close issues or answer discussions: if they had more money they could pay someone to do that work and more of it will get done.

Unfortunately, money alone will not always fix any of these problems. Money can help but it needs correct investment and understanding of what the _real_ problem is.

### 👍 What are "Open Source Economics"?

An "economic problem" is one which requires the allocation of limited resources in order to solve a problem. In modern, capitalist economies: the limited resources are usually 💵💶💷💴. Where there is a labour constraint, this is solved by paying enough money to compensate or attract the right candidates to solve the problem.

Open source software is a little different because of small pool of "labour" (maintainers) with knowledge of a project (perhaps single person) most of whom do their work voluntarily for no direct financial compensation. Many widely used open source projects are built by a single maintainer and, if so, this maintainer is the only person who can make all releases, review and merge all pull requests. Even with multiple maintainers, a widely used project will have a much smaller number of people doing this work than consuming the results. This means that domain knowledge and access control is limited to this one person or limited group of people.

[The Open Source Contributor Funnel]({{ '/2018/08/14/the-open-source-contributor-funnel-why-people-dont-contribute-to-your-open-source-project/' | absolute_url }}) is pretty stark. In Homebrew's case: there's millions of users, thousands of contributors and tens of maintainers.

![The Open Source Contributor Funnel]({{ '/images/a/the-open-source-contributor-funnel.png' | absolute_url }})

Relatedly, the time that these maintainers spend on the project may not be optimally allocated for the continued progress of the project. It's easy for their time to become monopolised by niche problems from a few users that require a lot of individual attention at the detriment of writing code to improve the project for the majority of users. This makes sense from the incentives of each user to just get their problem solved but not for the project as a whole (and may not even be the best for the user if it slows or halts feature development).

Relatedly, this is why you should [stop mentoring first-time contributors]({{ '/2019/02/16/stop-mentoring-first-time-contributors/' | absolute_url }}).

[![Working In Public]({{ '/images/a/working-in-public.png' | absolute_url }})](https://www.amazon.co.uk/Working-Public-Making-Maintenance-Software/dp/0578675862)

> A tragedy of the commons occurs not from consumers over-appropriating the content itself, but from consumers over-appropriating a creator’s attention. <br>
> [Nadia Eghbal](https://nadiaeghbal.com), [Working in Public](https://www.amazon.co.uk/Working-Public-Making-Maintenance-Software/dp/0578675862)

As a result, the "open source economic problem" is solving how to have sufficient labour that is allocated efficiently. Money can be part of this by e.g. increasing the ability or motivation of a maintainer to spend more of their time on the project but unless this is allocated effectively the project may not be any better off.

There's also some thresholds effects for a project's income. For a project run by a single maintainer with a day job, if they are paid enough to quit and work full-time on open source that may hugely increase the throughput of the project. However, even at 5% less than the amount they require to quit, they may not be able to dedicate any more time to the project. In some situations they may be able to pay others to take work off their plate but not always.

### 👩‍🔧 What are some solutions?

Viewed through a labour-centric rather than money-centric lens, the "more money invested in a open source project translates directly to a more effective project" obviously falls short. However, there is a place for maintainers and sponsors of open source projects to solve these problems.

#### 🧘‍♀️ How to Focus

There are some aspects of running an open source project that can only be done by maintainers (or their automation). These include merging pull requests, making releases and closing issues. Without new commits, merged pull requests or releases: a project is effectively dead.

As a result, maintainers should focus their time on what only they can do and delegate as much as possible to automation and community members. For example:

[![Homebrew/brew issue form]({{ '/images/a/homebrew_brew_issue_form.png' | absolute_url }})](https://github.com/Homebrew/brew/issues/new?assignees=&labels=bug&template=bug.yml)

- instead of manually correcting style issues on pull requests, use a [GitHub Actions](https://github.com/features/actions) workflow to automatically run style checks
- instead of manually closing our stale issues, consider using the [GitHub Actions stale workflow](https://github.com/actions/stale) to do so
- instead of walking individual community members through the solutions to their problems, enable [GitHub Discussions](https://docs.github.com/en/discussions) (which maintainers that should not feel obligated to respond can unwatch) so community members where they can help each other
- instead of asking the same questions for every new issue that is opened, enable [Issue Forms](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-issue-forms) to make answering these questions a requirement to open a new issue

Finally, and most importantly, maintainers should primarily focus on what they most enjoy doing. In all open source projects (and particularly those that are mostly volunteer run): the motivation of the maintainers is what keeps the project running. Remember: [open source maintainers owe you nothing]({{ '/2018/03/19/open-source-maintainers-owe-you-nothing/' | absolute_url }})! If the maintainers spend most of their time doing things they don't enjoy, this motivation will deplete and eventually expire and the maintainer will abandon the project, perhaps with no-one to replace them.

#### 💷 How to Spend Money

As mentioned above, when a sufficient threshold is reached, a maintainer may be able to go full-time to work on their open source project(s). If the maintainer has stated this as a goal publicly, helping them to reach it by spreading the word may be tremendously valuable to the project.

This may not be their goal, though, many maintainers are happy with their day jobs and would rather top-up their existing income or spend the money elsewhere. Sponsorship of open source projects is particularly useful when it helps to save time for the maintainers e.g. software tools, infrastructure, etc.

[![Outreachy]({{ '/images/a/outreachy.png' | absolute_url }})](https://www.outreachy.org)

Although it requires a non-trivial investment of time from the maintainer, spending money by bringing more maintainers into the project through programs such as [Google Summer of Code](https://summerofcode.withgoogle.com), [Outreachy](https://www.outreachy.org) or [Major League Hacking Fellowship](https://fellowship.mlh.io) can help add more contributors (and hopefully maintainers) to the project and reduce the burden on the current maintainers.

### 🎬 Conclusion

Money is an important ingredient into improving the open source ecosystem but it must come along with prioritising the motivation of maintainers, how their time is spent and realising that it does not solve all problems.

---

Thanks to [Ron McQuaid](https://www.linkedin.com/in/ron-mcquaid-06501058/), [Denise Yu](https://deniseyu.io), [Neha Batra](https://github.com/nerdneha) and [Alan Donovan](http://alandonovan.net) for reviewing this post and providing helpful feedback.
