---
title: Two Years Building Workbrew, a Remote-First Enterprise Homebrew Startup
---

I left GitHub after 10 years to cofound Raise.dev.
After an early failed experiment building IoT developer tools, we pivoted and built
[Workbrew](https://workbrew.com): an enterprise-friendly layer over
[Homebrew](https://brew.sh), a project I've maintained since 2009 and led since 2019.
Two years in, we’ve raised VC funding, built a remote team, and have happy, paying customers.
Here's what I learned so far.

## Leaving GitHub

![GitHub Sponsors Team]({{ '/images/a/github_sponsors_team.jpg' | absolute_url }})

GitHub was a good ride.
I got my dream of working for a "Big Tech" US tech company through an acquisition while working entirely remotely from Scotland.
When we were acquired by Microsoft in 2018 I predicted to my wife that at some point the bureaucracy would be so stifling that I'd quit.
To Microsoft's credit, this took 4.5 years, much longer than I would have predicted.

When I joined GitHub as employee #232, it was already the second-largest company I’d ever worked for.
No longer having [Neha Batra, the best manager I've ever had in my career](https://www.linkedin.com/in/nbatra/), as my manager was the straw that broke the camel's back.
When I'd mentioned this was part of my reasoning for leaving, I was told it could be fixed instantly but: that's not really how I roll.
I'd also previously told myself if I get to 10 years with any employer: I should quit to avoid stagnation, even if I loved it.

I still enjoyed it but: I no longer loved it.
It just took too long to get anything meaningful done any more and I'm primarily motivated by making developers more productive, not meeting OKRs while achieving the opposite.
The money was good but, at least for me, feeling like you're actually having individual impact has to take priority.

## Raise.dev

The startup I joined as a CTO and cofounder on March 1st 2023 was named "Raise.dev".
It had been started in 2019 by John Britton, my friend and former manager at GitHub.
In 2021 Vanessa Gennarelli, another friend and former teammate joined him there.
I _almost_ joined him in February 2020 but my youngest child's refusal to sleep and the prospect of a staff engineer promotion changed my mind.

![Mike and John]({{ '/images/a/mike_john.jpg' | absolute_url }})

John, the classy guy that he is, didn't do a "hard sell" for me to join him at Raise.dev.
If anything, it was the opposite.
He introduced me to various other founders and actively encouraged me to interview elsewhere and think about it.
He also said he was looking for a cofounder rather than an employee; something that was initially intimidating for me.

A person who helped swing it for me was [Brian Corcoran](https://www.linkedin.com/in/briandcorcoran/), friend and lynchpin of the Scottish tech scene.
I described my various options I was weighing up and he said "oh, so you're cofounding the startup then?".
When I said I hadn't decided, he told me that it was obviously the option I was most excited about.

## ESP32s

![ESP32]({{ '/images/a/esp32.jpg' | absolute_url }})

When I joined John and Vanessa, they had done a bunch of market research and figured out that there was an opening for developer tools in the IoT space.
In true startup style, for my first week John flew over to Edinburgh and stayed in my guest room while we figured out what we were going to build.
We zoomed in on shipping something for [ESP32s](https://www.espressif.com/en/products/socs/esp32) that would enable a GitHub-like deployment flow.

~12 weeks later, we had it in the hands of some potential users.
Things did not go well: the onboarding proved punishing and not always successful.
The rough edges were things that we did not have control over (e.g. GitHub Actions, C++).

When we next met up as a three to discuss what features to build next: I proposed we pivot.
I didn't know what to, just that what we were doing didn't seem to match our strengths.

John had been trying to convince me for literally about 10 years at this point to make "a [Homebrew](https://brew.sh) startup".
If you haven't heard of it, Homebrew is an open-source package manager I've been working on since 2009.
He (and others) had intro'd me to VCs several times and I'd always gone "where's the business here, though?" and declined to take it any further.
It also felt, in that era of open-source, that most "open-source startups" were a bait-and-switch where a free, liberally licensed project was inevitably yanked away from the community for "commercial reasons" later.
I wanted no part in helping someone make a quick buck out of the Homebrew community I'd worked so hard to cultivate.

![Mike in Homebrew beer costume]({{ '/images/a/homebrew_beer_mike.jpg' | absolute_url }})

John said: "well, if we're going to play to our strengths: that's the Homebrew startup".
I left the meeting, had dinner with my kids and thought: shit.
He's right.
We couldn’t play more to our strengths than this.
Homebrew now has solid
[finances](https://mikemcquaid.com/making-homebrew-financially-sustainable/) and
[governance](https://docs.brew.sh/Homebrew-Governance),
meaning it’s resilient against negative disruption from any organisation.
John, Vanessa and I all have most of our background in developer tools and open source.
It just made sense.

Of course, minutes into the next meeting discussing it, John comes up with the perfect name: "Workbrew".

## Workbrew

A major advantage of being open-source was having more than a decade’s worth of public requests from large companies that Homebrew decided not to build.
Many of these people were told "no" by me.
[Apparently I'm good at that](https://mikemcquaid.com/saying-no/).

With a bit of digging, the main things that jumped out were:

- Homebrew's inability to play nicely with [MDM](https://en.wikipedia.org/wiki/Mobile_device_management) tools
- A need to restrict access to Homebrew packages that violate compliance or regulatory requirements
- Security concerns around Homebrew's filesystem permissions model

![Workbrew 1.0 architecture]({{ '/images/a/workbrew_1_0.png' | absolute_url }})

I realised fairly quickly this would necessitate the:

- **Workbrew Installer**: install Homebrew and Workbrew, play nicely with MDMs (written in macOS `.pkg` and Bash)
- **Workbrew Agent**: send state/receive commands to Console, provide security-enhanced wrapper for Homebrew (written in Go)
- **Workbrew Console**: used by administrators to send commands/receive state from devices (written in [Ruby on (Guard)Rails](https://mikemcquaid.com/ruby-on-guard-rails/))

I built the basic architecture solo, dogfooded it with myself, John and Vanessa and showed it to some people.
This would make the open-source Homebrew project better and allow us to build an independent commercial product, Workbrew, to handle enterprise needs that Homebrew wouldn’t or couldn't.
We got a better response than I anticipated.
I guess it was time to go raise some funding.

## VCs

Raise.dev already had some money in the bank from an existing round that was sustaining the three of us.
With Workbrew gaining momentum, we knew it was time to raise more funding to grow the team.

![John, Mike and Vanessa]({{ '/images/a/john_mike_vanessa.jpg' | absolute_url }})

The TL;DR is we spoke to many VCs, I learned to be less Scottish in terms of both self-deprecation and swearing and raised a round.
In true remote-first fashion, we got our first offer before the three of us had even been in the same room together as cofounders.
[HeavyBit](https://www.heavybit.com) were our lead investor and have proved to be a great partner and source of wisdom for us.
They were (pleasantly) starting to badger me to go and hire a team so: it was time.

## Hiring

I left GitHub as a ["Principal Engineer"](https://mikemcquaid.com/what-is-a-staff-plus-principal-engineer/): lots of technical mentoring, but no formal management or hiring responsibilities.

![Workbrew Engineers]({{ '/images/a/workbrew_engineers.jpg' | absolute_url }})

I've written
[a longer post on exactly what my interview process was](https://mikemcquaid.com/how-and-why-i-interview-engineers-for-workbrew/)
but, suffice to say, it worked out pretty well.
We've got an incredible, world-class remote-first team with strong cultural alignment.
Today, ~63% of us are ex-GitHub employees.
Only the cofounders came directly from there.
Our shipping velocity is absurdly fast (with [guardrails](https://mikemcquaid.com/ruby-on-guard-rails/)).
We help each other, we improve each other and we prioritise kindness and empathy.
We work mainly async together across 7 countries and 3 continents.
I love it.

## Customer Feedback

So far, we have managed to get a decent number of happy, paying customers.
Customer feedback is a beautiful and valuable thing.
We're following our tweaked versions of a few great existing processes:

- [Shape Up](https://basecamp.com/shapeup) for 6 week "sprints" on feature work, 2 week "cooldowns" for less structured work
- the "First Responder" pattern for managing engineering support escalations and other unplanned work
- shipping "minimum loveable products" of our features with the goal of getting something useful out to customers ASAP and iterate based on their feedback

In the words of Level:

> We're happy to have integrated Workbrew into our stack.
> We also wanted to mention that the Workbrew team has been very responsive to even the silliest of questions and it's been a real delight conversing with them.
>
> <https://levelvc.com/brewing-better-builds-with-workbrew/>

## The Future

![Workbrew MacBook]({{ '/images/a/workbrew_macbook.jpg' | absolute_url }})

Things are going well and everything is trending in the right direction.
We're working with our sales and GTM folks to delight existing and new customers.

## Reflections

I'd read a lot about cofounding a company before doing it.
I swore I'd never do it.
Whoops.
The only thing I knew for sure was that I didn’t want to do this alone (and I’m glad I didn’t).
John and Vanessa and I all love, help, praise, improve and irritate each other in equal measure.
It's an incredibly intense relationship and experience.
Vaguely similarly to being a parent: the highs are higher and the lows are lower than I expected.
I've never felt like I've been growing more and faster than I am now, though.
It's incredibly motivating to be learning so much and building a company of people who love being here.

## Advice

I feel like I have almost zero actual advice to give other founders but I feel obligated to try some:

- Starting a company requires ignoring just the right amount of conventional wisdom.
  Not all of it, definitely not none of it.
- You'll get lots of (unsolicited) advice from lots of people.
  Listen to all of it.
  A broken clock is right twice a day.
  Ignore most of it, particularly strong opinions from those who've never been near a startup.
- Play to your strengths.
  It might be that you, as a CTO, are ok at management but still very productive with coding.
  Stopping all coding and fixating on management, even if wiser minds nudge you in that direction, seems like a mistake with that in mind.
  "Minimum viable management" is helpful.
  Zero management is not.

Thanks for reading!
