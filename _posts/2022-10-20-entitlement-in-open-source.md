---
title: Entitlement in Open Source
---

There have been discussions in the aftermath of the `log4j` vulnerability about whether or not open source is broken or sustainable, what we can do to improve the sustainability of the open source ecosystem moving forwards, and the entitlement of users and companies in expecting maintainers to fix their problems.

As the project leader of Homebrew, a macOS and Linux package manager with millions of users, I have experienced, and continue to experience, a lot of entitled behaviour from contributors and users of Homebrew.
Ironically, this is often worse coming from employed developers’ large tech companies with fantastic profit margins.
Similarly, being a staff engineer based in Scotland at GitHub and working in a very different time zone to my peers, I have learned that setting consistent, clear and firm boundaries with people in my open source and professional work results in a better experience for (almost) everyone.

Let’s start with a few definitions of terms I’ll use in this article so we’re all on the same page:

- **open source project**: a software project where the source code is freely released under an open source license (e.g. MIT, Apache, GPL). Often on GitHub, GitLab or a similar hosting platform.
- **user**: someone who uses open source software but has not yet been or become a contributor or maintainer
- **contributor**: someone who has submitted code to an open source project which was accepted and merged into this project but does not have write access to merge their own changes
- **maintainer**: someone with write access to an open source project who is able to merge changes from contributors, other maintainers or themselves

### A story of open source entitlement

To understand entitlement in open source, let’s use a fictional case study based on my experiences.

---

Bob works for TechCorp and discovered a few years ago that using a tool installed from Homebrew results in a 90% speedup on an otherwise boring, manual task he has to perform regularly.
This tool is increasingly integrated into tooling, documentation and process at TechCorp and everyone is happy, particularly Bob.
Bob receives a good performance review for improving the process at TechCorp.

Fast-forward a few years, one of Bob’s coworkers runs the tool that Bob built and it doesn’t work as expected, throwing a weird error no one has seen before.
They go to Bob and ask what the problem is.
Bob is in the middle of another project with a tight deadline so doesn’t really have time to help but feels some responsibility and jumps in and checks it out.

Bob discovers that a change in Homebrew has meant that the tooling will no longer work the way it used to.
As he digs in, he realises this was announced by Homebrew a few months ago but he never saw the messages.

Frustrated and stressed, Bob opens an issue on Homebrew where he makes clear how disruptive this change has been to him and his organisation, who are heavy users of Homebrew, and that it needs a fix ASAP so they can deliver what they have promised to customers.
His open issue awaits a response.

---

Reem is a Homebrew maintainer.
Most of the time, she works on Homebrew in the evenings and weekends when she’s finished with her day job.
She enjoys working on it and has been getting more and more confidence to make bigger changes.

Reem noticed that the tool Bob was using was badly outdated and the upstream software providers no longer supported the versions that Homebrew was distributing.
She’s concerned that this may expose Homebrew users to a security vulnerability so she posts an announcement in the Homebrew issue tracker, discussion forum, Slack and Twitter to let all Homebrew users of the tool Bob was using know that there are going to be some breaking changes coming up.

Fast-forward a few months and Reem has made these breaking changes and, until today, there had been no issues reported with it.
The other Homebrew maintainers said “well done” on her work but no users have commented positively or negatively on the 10 hours of evenings and weekends she’s spent working on this issue.

She sees the new issue opened by Bob.
She expresses sympathy with Bob’s position but closes the issue pointing to the deprecation notice and upstream changes and said that Homebrew cannot revert this change now without breaking things for even more users.

---

Bob is incredibly frustrated with Reem’s response.
He is already stressed at work and can’t believe that she has been so dismissive of his needs.
He insists the issue be reopened and someone fix these problems.

The issue is not reopened.
The behaviour remains unchanged.
Bob and others at his workplace make the necessary changes to adapt to the changes in the tool.

### What went wrong?

The above example has played out hundreds of times in my time working on Homebrew.
Hopefully, I’ve made it nuanced enough to make clear that I don’t think either Bob or Reem are bad people or are coming from an unreasonable place.

Unfortunately, Bob’s entitlement is very detrimental to the Homebrew project, Reem and the open source ecosystem as a whole.

Bob and TechCorp are benefitting from the work done in Reem’s free time and from the fact that they’re able to use Homebrew, and the tool installed from it, free of charge in a way that works for them 99% of the time.
Additionally, Homebrew’s MIT open source license, like almost all open source licenses, clearly states that Homebrew provides no promises of support, warranties or guarantees that the software will work as expected.

The lifeblood of volunteer-run open source projects, which is most of them, is ultimately the motivation of the maintainers who work on them.
Some are doing it in their free time outside of full-time employment or education, some are doing it as part of their full-time employment and some may receive sponsorship for their work.
Regardless of their status: they can generally choose what they work on, when they work on it and which issues they decide to fix.

The general state of the open source ecosystem is that most maintainers are building software they want other people to use and find useful.
When they break the software in a way that makes it no longer usable, they will generally try to fix this breakage.
When users have complaints, they will generally try to alleviate these.

The problem is that these generalities turn into expectations of behaviour, those expectations turn into entitlement and entitlement turns into toxic behaviour that makes maintainers quit open source.

### How could these problems have been avoided?

With examples like the above, I have had the (dubious) benefit of being on both Bob’s and Reem’s end of this story multiple times.
Many things could have been done differently, so I’ll spell them out separately.
Bob in leadership could have:

- set up the initial tool inside TechCorp he could have noted in the tool documentation, for the benefit of his coworkers and himself, that it relies on a volunteer-maintained open source project, so may break or require updates in future.
- ensured there was a team staffed to keep an eye on dependencies (like this tool and Homebrew) and prioritised and performed the necessary work based on the deprecation notice before the breaking change occurred.
- ensured there was a team staffed to fix issues with open source tools when they crop up so it didn’t fall on Bob to do so.
- entered a consulting relationship with one or more Homebrew maintainers or contributors to make the changes they needed in Homebrew or the tool to support their needs.
- ensured that their use of Homebrew or this tool were isolated so they were not affected by auto-updates breaking their workflows.
- relied on a fork of Homebrew and/or this tool to ensure that they can manage exactly how these tools are rolled out on their systems.

There are probably more options here that could resolve the issues with these interactions in different ways.
The thread that links them all is that the maintainer is offering a free gift of the open source software to Bob and TechCorp but actually keeping that software efficiently running is up to them, not Reem or Homebrew.

### How else does this go wrong?

The story I provided above is one where Bob’s, and indirectly TechCorp’s, entitlement to Homebrew and the unnamed tool results in demands on the time and emotional energy of Reem and the other Homebrew maintainers.
I would be happy if a maintainer I was mentoring responded how Reem did above, that’s one of the best-case scenarios.
She was under no obligation to offer a deprecation period, fix issues or express sympathy but did so anyway.

Sadly, maintainers like Reem are often pushed into a situation where they feel obligated to sacrifice their time and mental health to satisfy folks like Bob and TechCorp because they “feel bad”.
I want to be very careful to avoid victim-blaming in this situation but there are some resources I’ve personally found helpful dealing with being in a leadership or maintainer position in a widely used open source project for over a decade.

### Coping strategies

Firstly, you should only be maintaining open source software you use yourself.
This is partly because you can’t be a good maintainer unless you can empathise with your users but also because your open source work should be enjoyable and you’re unlikely to enjoy satisfying the demands only of others and not yourself.

Secondly, remember and really deeply internalise the fact that you can stop working on any open source project at any time.
Open source maintenance is a job and, like a job, when it stops working for you and you have better options, you can go elsewhere.
You should not feel bad about this; instead, you should feel good about the fact that every contribution you continue to make or made in the past were good deeds given freely to others.
When your life or the project means it no longer feels good to work on it anymore — stop.

Third, your time as a maintainer is simply more valuable than that of your users.
In Homebrew’s case, there’s 30 maintainers and millions of users.
It does not scale to prioritise user time over maintainer time.
In many, perhaps most open source projects there’s a single maintainer.
As a result, this maintainer should only be doing the tasks that users and other contributors cannot do.
Alternatively, this maintainer should only be doing the tasks that they want to do.

Finally, maintainers need to learn to say “no” again and again.
No to new features.
No to breaking changes.
No to working on holiday.
No to fixing issues or merging pull requests from people who are being unpleasant.
No to demands that something has to be fixed right now.

---

Open source software is a wonderful thing that many individuals and organisations are heavily reliant upon.
Much of it is built on the backs of volunteers, though, and all the folks involved with its creation could decide to walk away.
As a result, we need to be careful to ensure that maintainers in open source projects maintain boundaries to avoid burnout and users of open source projects avoid entitlement and learned helplessness to solve their own problems.

---

This article was [originally published on WTF is Cloud Native](https://blog.container-solutions.com/entitlement-in-open-source).
