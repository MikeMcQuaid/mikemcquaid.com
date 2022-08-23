---
title: Some Things Good Engineers Do
redirect_from:
- /2019/10/21/some-things-good-engineers-do/
---

I have not been working as an engineer long enough to feel like an industry expert but I have noticed patterns in new engineers that seem to result in them being more or less successful. I’ve had some requests to share these in a post so I hope they are useful.

## Ask for help

In engineering the one consistency is that you are going to have to work on or with things that are new to you. What differentiates good from the rest is how they handle this unfamiliarity. The good engineers I’ve worked with are cautious with unfamiliarity; they write more tests, read more documentation, code more defensively and ask for help.

Asking for help when you’ve been struggling with something for too long (and read the documentation) shows humility and allows teams to better pool knowledge. Even more importantly than asking on unfamiliarity is asking on mistakes. It’s never nice to admit a failing but the good engineers I’ve worked with realise that their personal reputation is less important than resolving an issue they may have created. They rapidly disclose their errs so they may be assisted by others. This applies more when you are less experienced and work with those with more experience: quickly admitting a mistake may allow them to intervene and prevent an issue from affecting your users.

## Work on one thing at a time

In software development we rarely have the luxury of a todo list with a single item on it. Despite this, we are not able to work on two things simultaneously. Every time you work on one thing and change to another you pay the cost of mentally (and sometimes in development environment) context switching. As a result the most efficient way to work is generally to take one task to completion before starting another task. Obviously there are times when you may be blocked for long enough that you can finish another task before you’re unblocked but prioritise finishing (or eliminating) a task before moving on.

A good tool I find in doing this is your [GitHub "created pull requests" page](https://github.com/pulls). This lists the pull requests that you created that are open (i.e. not closed or merged). Every day I like to ask myself: how can I finish (or otherwise close) one of these today? Prioritise doing that over starting yet another one.

## Prioritise unblocking

If the cause of having to work on multiple things at once is being blocked on input from a coworker, do what you can to avoid this becoming a problem. Firstly, be the change you want to see in the world and make it a high priority to ensure you’re not blocking your coworkers. This means being responsive to your direct mentions or messages on Slack and GitHub and review requests on GitHub (particularly if you have a workflow that requires review before deployment or merge). You may find my ["Managing large numbers of GitHub notifications" post on the GitHub blog](https://github.blog/2017-07-18-managing-large-numbers-of-github-notifications/) helpful in this endeavour. It also means ensuring that questions you're asked repeatedly have their answers documented and tasks you perform that can be automated have automation created.

For your own work, try to ensure that you gather the requirements for a task before you start it. This may involve asking the right  questions from the right people before you start coding. Similarly, when you’ve started a task, if you are blocked by another, ask yourself how can use your best judgment to cut scope or build based on your current assumptions and disclose these when you’re finished.

---

Thanks to [Graeme Arthur](https://www.graemearthur.com) for reviewing this post and pointing out that avoiding multitasking and proriotising unblocking are [tenets of Kanban](https://en.wikipedia.org/wiki/Kanban_(development)).
