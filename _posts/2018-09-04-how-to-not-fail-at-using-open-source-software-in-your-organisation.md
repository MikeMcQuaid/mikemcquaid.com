---
title: How To (Not) Fail At Using Open Source Software In Your Organisation
image: /images/a/how-to-not-fail-at-using-open-source-software-in-your-organisation.png
---

In the technology sector in 2018 the use of open source software (OSS) is routine. Despite this many organisations find using OSS frustrating or confusing. This is not the fault of OSS but an opportunity for organisations (and the individuals within them) to learn how to use OSS more effectively.

### Why use OSS?

Firstly, let's look at some good (and bad) reasons that organisations are now using OSS.

#### Costs of OSS

> proprietary software costs 💵 and OSS is 🆓!

While this statement is technically true it’s grossly oversimplified.

With proprietary software:

- obtaining a license for software costs 💵
- a support contract costs 💵
- training your staff in how to use it costs 💵

In comparison, with OSS:

- obtaining a license for software is 🆓
- a support contract still costs 💵
- training your staff in how to use it still costs 💵

In fact, you may find for a given proprietary vs. OSS comparison the [total cost of ownership](https://en.wikipedia.org/wiki/Total_cost_of_ownership) is lower for the proprietary product (particularly if you need high quality support or training).

You may have heard someone on the internet (not me 🐧) say:

> “Desktop Linux is only free if your time is worth nothing”

This alludes to the point I've made above. Desktop Linux works great for many people ([not me, sadly](/2010/09/21/why-i-left-linux/)) but it often requires more time to setup, configure and verify hardware compatability. When your time is less valuable (e.g. when I was a student) it's more appealing than when your time is more valuable (e.g. when I'm working and have a family).

> proprietary software costs 💵 and OSS is 🆓!

While this has elements of the truth, it’s a bad reason by itself to use open source.

#### OSS community support

> the community will help us and 🛠 all our problems for 🆓!

There's a fairly unfortunate and widespread assumption that when using OSS your training and support costs are reduced because you can contact the developers of the software directly. This leads to pretty unpleasant experiences; OSS maintainers end up massively overworked and corporate users are surprised that they aren't treated like important customers.

![As an OSS maintainer: as a user you are not my customer. You're trying to motivate me to spend time on you: if anything, I'm the customer.](/images/a/twitter-oss-maintainer-customer.png)

It doesn’t matter if you’re a "big customer" of OSS (e.g. using it on thousands of your machines) like with a proprietary software vendor because you aren't paying the OSS project proportionally to your usage (or, more likely: paying them anything).

Ruby on Rails has a [great contribution guide 📚](https://guides.rubyonrails.org/contributing_to_ruby_on_rails.html) that sums this up beautifully:
> Then, don't get your hopes up! Unless you have a “Code Red, Mission Critical, the World is Coming to an End” kind of bug, you're creating this issue report in the hope that others with the same problem will be able to collaborate with you on solving it. Do not expect that the issue report will automatically see any activity or that others will jump to fix it. Creating an issue like this is mostly to help yourself start on the path of fixing the problem and for others to confirm it with an "I’m having this problem too" comment.

The benefit of OSS are you can collaborate together with others on solving your own problems and you have the access to the code and tooling required to do so.

> the community will help us and 🛠 all our problems for 🆓!

In some cases with some software and some communities this may be true. However, if you’re a for-profit company relying on volunteers to fix your issues in a timely fashion, you’re being irresponsible towards your customers and a freeloader on the OSS community.

#### Increased OSS usage

> everyone else uses open source software now

Ten years ago this would be a contentious claim but it’s pretty hard to argue with now. Going from the earliest adopters of OSS to now we have:

- 🐧 "running Linux on my desktop" people
- ☁️ "running Linux on my server" people
- 🏢 small companies using OSS
- 🏙 big companies using, selling and supporting OSS
- 🎮 Microsoft releasing loads of OSS
- 🌍 everyone using OSS

This happened through the earliest to current widespread usage of different types of OSS:

- 🐧 servers, services (e.g. Linux kernel, Apache HTTP Server)
- 👩‍💻 server applications (e.g. WordPress content management system)
- 💡developer libraries (e.g. SQLite relational database)
- 🛠 developer tools (e.g. Git distributed version control system)
- 🆚 everything (e.g. .NET developer framework, Visual Studio Code text editor)

> everyone else uses open source software now 👍🏻

This is now both a true statement and a good reason to use OSS: it's become the industry standard. Unfortunately, using open source effectively hasn't yet become an industry standard.

### How to fail at using OSS 😭

#### Forking and not updating

[GitHub](https://github.com) has made it easy to quickly [fork](https://guides.github.com/activities/forking/) existing OSS to make your own modifications. The thought process one typically adopts when doing so is:

> let’s just fork 🍴 and edit this for now

You have some change that your organisation needs to make, do so in your fork and run the fork on your servers. It works fine, you forget about it and so it becomes:

> let’s just fork 🍴 and stay on our own fork forever

If you don’t have a plan on how you’re going to stop using the fork you've made, you're accumulating technical debt; each future update to a new release will be painful and more time-consuming. Helpfully, many organisations ignore this by thinking:

> updating to a new version might cause 🐛

Yeh, well, they might. However it’s also true to say:

> getting hacked might cause 🐛

On top of any resulting bugs in your application your customers also aren’t going to be too happy with you if you end up losing or leaking their data. If you're reliant on OSS at your organisation you should be able to answer the question:

> how many libraries you use are vulnerable 🚨 right now?

Do you have tooling to answer this question on all of your internal software projects? I’m willing to bet for many organisations at least 50% of their internally forked OSS projects are running an outdated (or even a known vulnerable) version. Proprietary software obviously also has vulnerabilities but it's not as trivial to have software to detect and address this (for good or for ill). If you're looking for a solution for this for your organisation I've had great experiences on my OSS projects with [Dependabot](https://dependabot.com).

#### Unreasonable expectations

> this issue is stopping me doing my job 👩‍💻!

Many OSS projects receive comments like this from Very Important Engineers (sometimes at some of the world's largest software companies who should really know better). Thankfully, those folks are entitled to a refund:

![If you’re unhappy with an open source project you’re entitled to a full, immediate refund to the $0.00 you paid for it. Alternatively, get involved with the project to make it better.](/images/a/twitter-oss-refund.png)

A little cheeky, I know, but it's worth remembering that, as I've written before, [open source maintainers owe you nothing](/2018/03/19/open-source-maintainers-owe-you-nothing/). They've provided you with software, tooling and a license to allow you to fix your own problems. If they fix your problems (lucky you!): great but you cannot expect someone you are not paying to do so for you.

#### Open sourcing internal projects for free labour

How many times have you seen an internal project get open-sourced to an internet that doesn't care?

> let’s open source this so people will make it 👍🏻 for 🆓!

This is a common reason for making new open source projects as a company. Unfortunately in reality it’s more like:

> let’s open source this so people will make it 👍🏻 if it’s already 👍🏻 and we help them!

[The Open Source Contributor Funnel](/2018/08/14/the-open-source-contributor-funnel-why-people-dont-contribute-to-your-open-source-project/) helps explain this a bit more; if you want to have lots of people contributing to or maintaining your recently open-sourced internal project you're going to need lots of people using it first. That requires it to be useful, well documented and for a bunch of people to have heard of it. [Homebrew](https://brew.sh) (which I maintain) has millions of users, thousands of contributors and tens of maintainers today. Consider this when your internal project has ten external users and you’re wondering why none of them are contributing back.

### How to win at using OSS 😎

The key to succeeding at using OSS is to participate in the community and let them help you (in the way they want to).

> everything should be upstream 🏞

The upstream of a fork is the original OSS project you forked it from. This just means "get your changes back into the original project ASAP" which in turn means:

> everything that can be should be someone else’s problem 🙅‍

Get those bug fixes and features on your outdated internal fork maintained by the upstream project and not you. This means you won’t need to manually apply security patches to your fork but can just upgrade like any other library. The process to forking a project well is:

- 🍴 fork the project
- 👷‍ test your changes (locally and in production)
- 💁‍ submit pull request to the upstream project
- 📇 address maintainer review comments, get merged
- 🆕 update the project to latest version (often)

If you follow these steps your experience using and modifying OSS will be much more pleasant. What if you don’t feel confident making changes?

> help others help you by helping yourself ☝️

You need to be willing to put in the time and effort to make it easier for others to help you. Starting with the easiest:

- 📖 read all the documentation before asking for help
- 🔍 create [minimally reproducible](https://stackoverflow.com/help/mcve) issues
- 👀 look at the code you think might be relevant
- 🛠 try to edit the relevant code and see if it fixes the problem
- 💁‍ submit the fix to the problem as a pull request

Similarly on your issues, pull requests, tweets and everything related to open source:

- ☀️ have reasonable expectations (most maintainers are volunteering in their free time)
- ⏱ prioritise maintainers’ time (there's more of you than there is of them so your time is less valuable)
- 👌 defer to maintainers (it's up to them if changes get made or merged; argue respectfully)
- 🤲 help others where you can (if you want help you need to give help)

If you want to read more about how to do all aspects of OSS well check out [the Open Source Guides](https://opensource.guide). These are the best single resource on the internet on how to contribute to, start and maintain an open source project.

Finally, just be a nice, kind human ☀️. It's surprising how appreciated (and how rare) kind words are in OSS. Use them generously and you'll reap the rewards.
