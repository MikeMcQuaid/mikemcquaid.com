---
title: "On-Call and First Responder: One Rotation to Rule Them All"
image: /images/a/first-responder-and-on-call.png
description: "Combine pager duty with incoming team requests to protect roadmap work and let engineers fix what woke them up"
---
On-call is a requirement for at least some engineers in all [SaaS](https://en.wikipedia.org/wiki/Software_as_a_service) companies.
At least some of your customers will not have identical working hours to you.
If your software fails to deliver what it needs to in that non-overlapping time, someone needs to fix it.
If you're on-call for a week: you may be less productive and more of a blocker for feature work.
Combine this with a first responder rotation to also focus standard working hours on normally shared team non-roadmap work.

## 📚 History

Before I worked at GitHub, I was used to having teams of "ops (engineers)" and teams of "(application) engineers".
Ops teams were/are sometimes (perhaps wrongly) called other things: sysadmins, infrastructure, devops, SREs etc.

Essentially this split software delivery into two parts:
- the people that build the software (and are not on-call)
- the people that are responsible for making sure the software gets delivered (and are on-call)

If you are still in the wonderful (or terrible, depending) situation described above: you've probably seen how it fails.
The ops folks get pissed when engineers deploy buggy code and the ops folks get woken up when it fails.
The engineers have a view of: well, we're trying our best here and it's the ops folks' jobs to answer pages.

This is a classic case of "perverse incentives".
It sucks to get woken up at 3am because software fell over.
It sucks more when you told someone to be careful with their memory use or this would happen and they didn't listen.

The "simple" solution the industry eventually got to: put engineers on-call for their own code.
Not sure if this came out of the "devops" movement or it just became a good idea.
Of course, the "engineers" generally hate it.

At GitHub, this move resulted in a significantly happier and more stable infrastructure team.
The previous approach with no "application engineers" on-call resulted in the ops team quitting en masse due to excessive paging and burnout.
It took a while to get to the right on-call shape but: any progress is better than none.

## 🏎️ Progress

On-call does not have to be terrible.
Ok, being woken up at 3am is always gonna feel terrible.
However, it can be made much less terrible by a few easy things:
- those on-call need to have at least some control of how/when/if they are paged
- those on-call need to only be woken up when there's something actionable for them to do
- everyone should feel bad for and try to help those woken up who were on-call
- being on-call should be regular enough to be not terrifying but rare enough to not destroy people's social lives

Some principles for getting here:
- LITERALLY EVERY TIME someone gets paged and shouldn't have been, someone (ideally they) should adjust the alert/trigger/whatever.
  Not just out of hours but also waking hours (as those will also result in out of hours pages).
- All levels of the technical management chain should be on an on-call escalation path
- Those on-call should be actively encouraged to page others when they don't know what to do
- There needs to be decent, written training, help, mentoring and support
- Stopping people getting paged takes priority over feature work, other bugfixing work, etc.
- Getting paged only happens when a customer will have major, new issues with using your software unless a human intervenes before the next workday
- If your changes can cause someone else to ever get paged, you should be on-call

In some countries/jurisdictions it's mandatory to pay people for on-call.
In others, it is not.
If it's not, it should be baked into a decent salary.
Either way: it should be seen as a consistent responsibility across all engineers at all levels.
Being too junior or too senior alone is not a good reason to not be on-call.
Being insufficiently trained (yet) may be.

## 🚑 First Responder

On-call in general can be described as a "first responder" pattern.
Your job is not to be the person to go and solve all problems.
You're the first person on the scene to decide what else is needed and from whom.

This actually works well as a within-working-hours pattern, too.
At GitHub we would often have people on "first responder" rotations which aligned with their on-call rotations.

If you were on-call for a given week, you'd also be "first responder" for your team that week.
That meant various other non-time-critical tasks:
- if someone @mentioned your @github/team, you were the person on the hook to respond if no-one else already had
- you would help triage incoming bugs for your team
- you were the primary (but not only) person making sure anyone who needed code review from your team could get it
- you could, if you still had extra time, pick up bugs/technical debt work
- you should, in exchange, do much less or even none of your normal feature/roadmap work

This works nicely with the principles above: if you're first responder and getting woken up in the night you can:
- skip your team's standup because you're sleeping in and not blocking or blocked on roadmap stuff
- drop what you'd normally be doing and fix the bug/alert/systems that woke you up last night
- take up some of the shit work to allow the rest of your team to focus more

This model worked well across most teams I worked on or with at GitHub.
The Platform API and webhooks team, the Platform Data database optimisation team and the Finance engineering teams were notable examples.
All of these teams had a lot of inbound review requests or "help me integrate with your system" work.
This ran the risk of drowning out feature work.
First Responder rotations made these teams both more responsive and more balanced in delivering their own roadmap and helping others with theirs.

## 📆 Today

No two companies (or two engineers) seem to agree on all of the above.
I've tried to introduce similar processes at every employer since GitHub.
Uptake has varied mostly based on on-call load.

Teams with zero or almost zero pages see little value in prioritising mitigation work.
Engineering teams that don't need a lot of cross-team review don't need a full first responder rotation.

Teams with excessively noisy on-call rotations may not be able to rely on any first responder work being done yet.
They should instead focus on reducing pager volumes to reasonable levels before attempting to introduce first responders.
In extreme cases, all roadmap work should be paused while the entire team focuses on solving on-call issues.

You can add ingredients like "follow the sun rotations", big on-call rotations across all services and smaller ones across fewer.

The exact specifics of what works best for your organisation will vary.
As long as you're broadly following these high-level principles, making progress and making on-call suck less: you're doing well.
Don't rest on your laurels, though.
A good on-call experience requires continuous improvement and maintenance to stay that way.
