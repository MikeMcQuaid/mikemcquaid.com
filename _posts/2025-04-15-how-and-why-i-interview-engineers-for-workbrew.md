---
title: How and why I interview engineers for Workbrew
description: "How I interview engineers for Workbrew: pairing on real code, short predictable loops, valuing open source work, skipping trivia, and the reasoning behind each step."
---

In the last
[two years building Workbrew (a remote-first, enterprise Homebrew startup)](https://mikemcquaid.com/two-years-building-workbrew-a-remote-first-enterprise-homebrew-startup/)
I've hired 5 engineers (and a hybrid PM/EM).
This has been my first time being a "hiring manager".
This post explains how I interview and why I do it how I do.

## 🎨 Background

I had designed the initial engineering hiring process at Mendeley and interviewed the first ~5 engineers there.
At GitHub, I was involved in screening, interviewing and tweaking hiring processes for around ~50 engineers.
Through these processes, and being interviewed myself ~15 times for engineering jobs over the years, I had a pretty good idea of what I loved and hated.

What I'd loved:

- 💕 **Pairing on real code.**
  Shout-out to AllTrails for my first interview where we actually paired together on a real bug in the Rails codebase I'd be working on.
  Felt the best representation of my actual skills in an interview setting, nerves aside.

- 🩳 **Short, predictable interview processes.**
  At Mendeley, as first employee, I went from having never heard of them to being interviewed and accepting an offer in a week.
  Huge companies can't do this.
  Startups can (if they can be bothered).
  No-one wants to wait three months to find out if they got the job.

- 🔓 **Valuing my open-source contributions.**
  I've maintained a [very widely used open-source project](https://brew.sh) when interviewing for my last 3 gigs.
  If you think I've done a good job doing this, it's appreciated when your interview process reflects this.

What I'd hated:

- 📚 **Factual recall or gotcha questions.**
  Don't ask me anything I can trivially get the answer from Google or ChatGPT.
  It's a waste of everyone's time for me to just memorise a bunch of facts for your interview.
  If you have to look up the answers to your own interview questions for a job you're not in the process of being fired from: you're doing it wrong.
  Even if I don't know today: I can probably learn it on the job.
  Relatedly, [requiring specific technology experience for senior+ engineers](https://mikemcquaid.com/stop-requiring-specific-technology-experience-for-senior-plus-engineers/)

- 📟 **Not considering relevant prior experience.**
  Moving back from marketing to engineering in GitHub I was put through the external senior engineer interview loop.
  I failed.
  This was after
  [shipping the "archive repository" feature](https://github.blog/news-insights/product-news/archiving-repositories/)
  while still in the marketing organisation (almost) single-handedly.
  A few months later, I was moved over anyway to work on GitHub Sponsors.
  One year later, I was a staff engineer.
  Three years later, I was a principal engineer.

- 🙋 **Assuming one-way interview.**
  I've had several interviews who clearly took pleasure in seeing people squirm when jumping through hoops.
  They assumed, sometimes rightly, that they could treat people how they liked as they have enough applicants for it to not matter.
  Interviews are always two-way.
  If you are exploiting the power dynamic in the interview process: it's a pretty good sign you'll be a shitty person to work for or with.

So, given all this, how did we decide to do it at Workbrew?

## 🎭 Stages

We split the interview process into a few stages.
If you passed one: you moved onto the next one as soon as possible (usually within a few days).
If you failed one: I let you know as soon as possible (ideally the same day).

For each stage when we're evaluating the candidate, we have a numeric rubric for each question or criteria.
This helps avoid biases where you "love" a candidate but, objectively, they scored lower than another.

Here's the breakdown of our hiring stages:

1. ✍️ **Writing the job posting.**
   I spent a pretty decent amount of time and got a bunch of feedback to ensure it conveys our values at Workbrew.
   We slimmed "requirements" down to the bare minimum (i.e. no-one would get a job who didn't 100% meet every one).
   We kept the "nice-to-haves" minimal but indicative of what would differentiate a good from great candidate.
   Rather than implicit ("unlimited holiday/vacation") we tried to be explicit ("less than 20 days is too few, more than 40 is too many").
   We decided to share it in various semi-public locations (e.g. various networks we're part of) rather than get a million applications from the entire public internet.
   We also directly reached out to some people who seemed like they'd be a good fit and were already in our network

2. 💌 **Application.**
   We asked people to send in their CV/resume so we could do an initial screen to ensure they met requirements.
   For example, if we said we wanted 10 years industry experience and you were still in high school then: sorry, it's a pass.
   I did all this myself because we're a small company and I wanted to ensure I got it right first before I eventually delegate/outsource it.
   We also asked people to clarify that the salary range in the job posting worked for them.
   This helped ensure alignment between experience, expectations and our budget.
   At this stage as a company, we’re careful about balancing expectations with experience.
   This also provides a screening process for people who link out to their social media on e.g. their CV and it's full of them being unkind to others.
   If your linked social media openly showcases behaviour clearly misaligned with our values: it’ll be a pass.

3. 📺 **Technical Screening Questions.**
   Next, we asked people to reply to the email with answers to a few technical screening questions.
   Could people just feed these into ChatGPT and get some half-decent answers out?
   Yup.
   While ChatGPT might produce passable answers, genuinely excellent, nuanced answers stand out immediately.
   If you’re skilled enough to leverage AI to produce that kind of clarity: good for you (more to follow on that in another post).

4. 🍐 **Live Pairing Interview.**
   Riffing off my favourite experience at AllTrails, we did a live pairing interview.
   Because we're remote-first: it was done over Zoom.
   I get it: no-one loves live technical interviews/pairing so we factor in nervousness.
   To avoid unfairness, I screen-shared my environment and let them connect remotely with Zoom and/or VS Code.
   This enabled us to work together on the same real problem in our actual codebase.
   Everyone worked on the same problem and had the same amount of time for a fair comparison.
   This was "open book"; it was fine to use Google, ChatGPT, Copilot, Cursor, etc.
   I'm fine with AI tool usage as long as it's disclosed.
   Some folks asked to skip this stage in favour of a take-home interview.
   We're not willing to do that; there's just too much cheating that happens with this now and it's more fair to compare all candidates in the same environment.

5. 🧫 **Cultural Cofounders Interview.**
   We're a small and new company but we identified [strong, shared cultural values](https://workbrew.com/about) early on.
   If someone strongly prefers to never travel to meet coworkers in person, that’s not a good cultural fit with us.
   To ensure all three founders were aligned: we all interview every candidate.
   This ensures that we're actively excited about each new person who joins and sets everyone up for success.
   It also allows the candidate to ask different (or the same) questions to different founders and get different perspectives.

6. 💸 **Offer.**
   We move to making offers ASAP.
   There might be further discussion and salary/equity/etc.
   We make clear that the higher the compensation: the higher the expectations.
   Ultimately, what value you bring is evaluated against how much you cost the company.
   If maximising salary is your primary goal, you’re very early career and/or in a particularly expensive city: it's a mutually poor fit for our current state.

7. 🛬 **Onboarding.**
   Despite working remotely for 16 years, I still find face-to-face working tremendously valuable.
   As a result, in the first week, we fly the new employee over to co-work with me in Edinburgh, Scotland.
   This helps with engineering and product onboarding and setting 7/30/90 day expectations.
   Most importantly, though, it helps us both get to know each other a bit better.
   It means when we read some text in Slack, we hear the human side.
   If we're hiring more than one person around the same time: we build a "cohort" and onboard them together.
   This means they can get to know each other, too.

## ⏭️ Exceptions

The above sounds great (and has been) but: sometimes there are exceptions.
We've hired people without going through every step of the process because I've worked with them on Homebrew for years and have extensively reviewed much of their code.
For this situation, putting them through a live coding exercise is pointless.

## 🪩 Reflections

Reflecting on the process so far, I’m really happy with the outcomes.
We've hired universally excellent candidates so far which makes me delighted with our process.
In fact, we've had more excellent candidates than we've had headcount/budget to hire them.

Doing this process (almost) entirely by myself is tiring but worthwhile.
I've never had such a high level of confidence in people before we've hired them.

We've seen particularly good results from hiring from shared employer backgrounds.
2 of our engineers were hired from Homebrew.
2 of our engineers (and our EM/PM hybrid and all 3 founders) had previously worked at GitHub.
1 was a (paid) referral from a respected Scottish founder.

Surprisingly, we're yet to hire a "cold inbound" engineering hire.
Several of these folks reached the pairing and cultural interviews and did well but everyone we ended up hiring did incredibly.
This has indicated to me that, at least when we're small, leaning on our networks is incredibly valuable and time-efficient.
It also helps a lot with "cultural onboarding" to have shared context.
