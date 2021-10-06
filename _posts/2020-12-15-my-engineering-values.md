I've been encouraged by [a mentor](https://nathanherald.com) to think about what my core (engineering) values are (in the context of being recently promoted to be a "staff engineer" and having my eyes on being a "principal engineer" one day). This felt like something that could be of wider interest so here we go:

### Don't fix bugs speculatively

One I picked up from [Max Howell](https://mxcl.dev), the creator of Homebrew.

When you've got a non-empty issue backlog on your open source or commercial project: don't waste your time "fixing" things that aren't problems affecting users. Yes, refactoring that method so it returns an empty string instead of `nil` feels useful but if there's no way that bubbles up to a user issue: you have better things you could be doing with your time.

### Perfect is the enemy of good

A solution that's "good enough" (or even "better than the status quo") and can be shipped this week is always superior to one that can ship next week. Iterative improvement allows you to learn more every time you ship and encourages you to keep shipping.

Additionally, in both commercial and open source environments I've seen motivation to fix a problem today destroyed by promises of some big solution that will fix this problem (and many more!) in six months time. Relatedly: these big "fix everything" projects almost never end up shipping and then the "quick win" fix has been long abandoned.

### Apologies are easy and free

One from my Dad: it costs nothing to say sorry and it's worth saying even when you aren't convinced you're in the wrong. It's an easy way to demonstrate humility, make other people feel better and have _someone_ take accountability for mistakes rather than no-one.

### Don't make changes you don't understand

[Chesterton's fence](https://en.wikipedia.org/wiki/Wikipedia_talk:Chesterton%27s_fence), basically. Try to make your changes to methods/files/systems as small as possible in order to accomplish what you want to.

Refactoring for refactoring's sake ("I'm refactoring because the code is hard to read" often is "I'm refactoring because I didn't write this code") is an example of this in action; it often introduces new bugs and provides no direct benefit to the end-user.

Of course, if the code is unspeakably messy/buggy so that it takes forever to do any new development: refactoring may be in order. Just don't do it because "this looks messy".

### Don't repeat yourself

[DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) is a pretty obvious and basic engineering principle at this point but I like to take it to new extremes:

- don't repeat yourself between the code and the documentation if you can avoid it
- don't repeat yourself answering the same questions again and again without documenting them
- don't repeat yourself making the same mistakes repeatedly

### Motivation is the fuel of open source

I've written previously about how [open source maintainers owe you nothing]({{ '/2018/03/19/open-source-maintainers-owe-you-nothing/' | absolute_url }}) and this is essentially the same thing.

Motivation isn't the same for everyone. For some, it's financial (hence my work on [GitHub Sponsors](https://github.com/sponsors)). For others, it's about having fun (so blocking unfun, rude people makes sense).

When maintaining or developing open source: don't be drawn into doing things you don't want to do.

When using/contributing to/submitting issues for open source: don't try to make others do things that they (or, as a shortcut, you) don't want to do.

### Every time you agree to do something: write it down

I've written previously about [how I get things done]({{ '/2015/05/24/how-i-get-things-done/' | absolute_url }}) but this is the cornerstone.

Anyone I know who does this is generally fairly organised. Everyone I know who doesn't is not. The worst are those who have "a system" which doesn't involve writing anything down and they feel like they are organised and aren't. Don't be that person.

### Say no more often

Related to multiple of the above. Doing the most important/useful thing right now means fighting off the other 100 things that 10 people want you to do instead that are less impactful.

This is even more applicable when designing product and soliciting feedback from users/customers. Some of them will have universal ideas and some will have ideas that just a hack around their particular problem today.

If you say no to everything the first time you hear it then you'll be able to more easily prioritise the things that keep coming up again and again.

### Automate everything

People respond way better to [pedantry from robots and empathy from humans]({{ '/2018/06/05/robot-pedantry-human-empathy/' | absolute_url }}). As a result, prioritise your time as an engineer on turning your desire for cleanliness and pedantry into automated checks.

Don't check that list once a month, get a bot to do it for you. Don't remember to follow a deployment process, turn it into a script/application.

### Build things that are useful

Another one from [Max Howell](https://mxcl.dev).

If you're building software that is a tool for people (particularly a developer tool) and asking yourself how some feature should work: ask yourself how it can be most useful. This is often in tension with "be consistent" but often a better experience arises from being less consistent on the occasions where it makes a tool more useful (particularly if inconsistent with rules you've created).

### Negativity is better ignored than reciprocated

This has been a real big change for me in the last 5-10 years and one I'm not consistently good at (and props to [Nadia Eghbal](https://nadiaeghbal.com) for nudging me initially).

You can get a lot of drive-by negativity through open-source (and sometimes even just working in a big company). If you're someone (like me) who prioritises being responsive then it can feel like you should respond to this negativity with disagreement or criticism. Usually (particularly if you feel angry/sad) the best thing to do is just to ignore it and move on.
