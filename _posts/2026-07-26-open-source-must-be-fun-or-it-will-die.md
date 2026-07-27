---
title: Open Source Must Be Fun (Or It Will Die)
image: /images/a/open-source-must-be-fun-or-it-will-die.png
description: "Homebrew is thriving while other open source projects struggle. Its scarcest resource isn't money: it's maintainer motivation."
---
I was on a call with a bunch of people involved in other prominent open source projects a few weeks ago.
The organiser jokingly asked us to raise our hands if the previous six months had been better than what came before.
I raised my hand.
No one else did.
Why?
I've maintained [Homebrew](https://brew.sh), the package manager for everywhere, for nearly 17 years.
I've worked on it the vast majority of weeks in that time and I've never burned out.
I'm having more fun than ever.

The current narrative around open source is depressing.
Apparently it's "dying".

AI drive-by issues, pull requests and security reports are overwhelming maintainers.
Rising security expectations (thanks [Mythos](https://www.anthropic.com/research/mythos-preview)) require maintainers to do even more work.
Open source funding is hard to secure and insufficient.

Some of this is happening, but I'm sure as hell not seeing it in Homebrew.
Another Homebrew maintainer told me:

> I'm having more fun than ever before.

## 💎 The Scarcest Resource

As I've written before, the scarcest resource in open source is not money but the [motivation of the maintainers]({% post_url 2021-10-27-open-source-economics %}).
Sending Homebrew $1000 today doesn't magically create any more maintainer time (but please [donate if you can afford it](https://github.com/Homebrew/brew#-donations) to fund Homebrew's infrastructure, stipends, grants and meetups).
We all have jobs that aren't maintaining Homebrew.
We receive small amounts of money ([$300/month](https://docs.brew.sh/Maintainer-Stipends-and-Grants)) if we're actively maintaining Homebrew.
This is not a "market hourly rate".
Many children delivering newspapers get a higher hourly rate.

There is a threshold effect: funding only creates more time if it lets a maintainer reduce their paid hours or quit their job.
Work no maintainer wants to do is a good candidate for a paid contract.
If you can't fund it: don't do it.

Why do any of it then?
Fun.

Not everything is fun all of the time, but it needs to be "utilitarian net fun": more fun than not, overall.
This is primarily about volunteer-run open source, but that's most of it.
If you have a paid open source job and hate it: you should quit that too.

It's a Sunday afternoon.
I took the kids most of yesterday so I have a bit of "me" time today.
I've spent a bunch of that time on Homebrew.
Not because I "had" to; nothing urgent is coming in.
Not because of the "supply chain".
Not because of the money.
Because I wanted to.
Because it was fun.

## 🥳 Fun Is Social

My first real experience of OSS was with a successful, established project whose culture I could observe.
It was [KDE](https://kde.org/), the community behind a desktop environment for Linux.
In 2009, I attended [Akademy](https://akademy.kde.org/) (the KDE contributor conference) and [GUADEC](https://guadec.org/) (the [GNOME](https://www.gnome.org/) contributor conference), which were co-located in the Canary Islands.

Firstly, this was weird because, if you read the discourse online, you were typically in the camp of "KDE SUCKS, GNOME ROCKS" or "GNOME SUCKS, KDE ROCKS".
And yet: you had both groups working together.
Not just working together but eating, drinking, socialising and building new friendships.

Secondly, I could tell that, for many in the KDE camp, these were their people and this was the highlight of their year.
They came back re-energised and motivated to work on KDE.
Most people weren't being paid to fix, maintain or write KDE's code.
They didn't seem to be doing it for their users either.
They did it because they were having fun, both individually writing the code and helping their friends build something they cared about.

For the last few years, Homebrew maintainers have met annually at the "Homebrew AGM" [co-located with FOSDEM in Brussels](https://docs.brew.sh/How-To-Organise-the-AGM).
We meet, eat, drink, socialise and make plans for Homebrew.
Afterwards, we come back re-energised.
Since we started doing this, I've also seen people doing more for other maintainers than directly for users.
Open source transcends national boundaries: most of us don't care what country another maintainer is from or what nationality they are, only that we're friends building something we find fun together.
These relationships matter because, without the maintainers, the project is dead.

## 🍺 Keeping Homebrew Fun

This is why I've always been keen for Homebrew to be a fun project.
Dealing with [entitled behaviour]({% post_url 2022-09-20-entitlement-in-open-source %}) is not fun.
Setting SLAs is not fun.
Maintaining indefinite backwards compatibility is not fun.

Homebrew has been successful because fun, [automation]({% post_url 2017-09-29-homebrew-ci-evolution %}), community and putting maintainers first have been priorities from early on.
Concretely, we automated review comments so [robots are the pedants and humans can focus on empathy]({% post_url 2021-06-09-robot-pedantry-human-empathy %}).
Our [guardrails]({% post_url 2024-10-24-ruby-on-guard-rails %}) include CI, linting, typing and tests to catch routine mistakes before a maintainer has to point them out.
[Feature flags and staged rollouts]({% post_url 2019-10-28-user-and-feature-segmentation-in-homebrew %}) let us experiment without breaking things for everyone.
This means maintainers spend less time on repetitive corrections and more on work they find interesting.

AI is good at boring work like writing CI workflows, linters and documentation.
These practices help both AI and human contributors.
Maintainers can use or avoid AI, whichever better preserves their motivation.

If your eyes glaze over while reading low-effort AI-generated content: close it without comment or justification and block repeat offenders who do not learn or improve.
At Homebrew, [our pull request templates](https://github.com/Homebrew/brew/blob/cd454b3a669d4ba902e7bd4cd8db051dbc0d0ba4/.github/PULL_REQUEST_TEMPLATE.md) ask contributors to disclose AI usage and [CI jobs](https://github.com/Homebrew/.github/blob/aaf9401fdf463b562f403c26a6386e0df69493ad/.github/workflows/check-prs.yml)
automatically close pull requests with incomplete templates.
Issues or PRs opened through the API without our templates often suggest AI usage with insufficient human involvement.

## 🛑 Stop, Pay or Quit

[Homebrew is thriving](https://formulae.brew.sh/analytics/install/30d/), not dying.
It has [28 active maintainers](https://github.com/Homebrew/brew/blob/56dfdc06db96ae562ac8c73805110e24b482dd76/README.md#-who-we-are).
Of the [29 maintainers it had a year ago](https://github.com/Homebrew/brew/blob/d661cffc1f78fdccb2d740bffd88a3eb854b8ed6/README.md#who-we-are), 26 remain.
Under [our governance rules](https://docs.brew.sh/Homebrew-Governance), we remove maintainers after they miss an activity threshold for two consecutive quarters.

If your project is dying, maybe it's because it's not fun any more.
You should quit.
You [don't owe anyone anything]({% post_url 2018-03-19-open-source-maintainers-owe-you-nothing %}).
[Homebrew maintainers are encouraged to leave without guilt or explanation](https://docs.brew.sh/Maintainers-Avoiding-Burnout).

If you don't want to quit (or if you're on a project where you don't want others to quit) and things are going badly: change something.
Don't just ask for more money or sponsors or donations.
That will not magically make things fun again.
Getting more money is not in your locus of control.

Instead: stop doing the parts of your project that are not fun.
Maybe that's stable releases.
Maybe that's release notes.
Maybe that's backwards compatibility.
Whatever it is: again, you [don't owe anyone anything]({% post_url 2018-03-19-open-source-maintainers-owe-you-nothing %}).
You can do OSS however the hell you want to do it.

People running soup kitchens don't get constant complaints that the soup tastes like shit.
They aren't critiqued for not providing the optimum macronutrient balance.
They do what they can.
How sad is it, then, that some very well-compensated open source users with tech jobs treat volunteers so poorly?

## ⏭️ OK, What Now?

Are you a maintainer?
If so, consider what keeps maintaining your project fun or what would make it fun again.
If it isn't fun and you can't make it fun again: quit.

Are you a contributor?
Ensure that you're having fun contributing but not in a way that makes it less fun for the maintainers.
If you're submitting AI-generated content, carefully review and test it.
Speak to the human maintainers instead of deferring to your LLM.

Are you a user?
If you're filing a bug report, take your time and provide all the requested information.
Most importantly: be grateful for the gift of open source you're getting for free.
Keep your rants for the pub or coffee shop and off the internet.
Drive-by negativity kills open source.

Are you a company consuming open source?
Allow your employees to participate in [Open Source Friday]({% post_url 2017-06-29-contribute-on-open-source-friday %}).
Alternatively, look the other way when they participate in the [Open Source Resistance](https://ossresistance.com).
Sponsor some projects you rely on.

Keep having fun and the open source community will outlive us all.

---

Thanks to [John Peebles](https://peebs.org), [Graeme Arthur](https://www.graemearthur.com), [Patrick Linnane](https://www.linkedin.com/in/patrick916/), [Andrew Nesbitt](https://nesbitt.io) and Lindsay McQuaid for reviewing this post and providing helpful feedback.
