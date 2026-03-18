---
title: "Runnable Documentation: Code For Humans"
redirect_from:
- /2015/10/06/runnable-documentation-code-for-humans/
---
On GitHub Enterprise we've moved our release process to using what we like to call "Runnable Documentation": a step-by-step series of instructions that can be run by any person without requiring special domain knowledge. When creating and optimizing Runnable Documentation you should apply code refactoring principles to make it better.

## Knowledge to Documentation

Having only a single person with knowledge of how to do something is never a good idea. It provides a single point of failure, puts undue pressure on that person and the knowledge can be lost if something happens to the person. Unfortunately due to specialization and ownership in organizations these single points of failure can creep up on you without realizing. With the GitHub Enterprise release process we've made improvements over the last year to ensure that knowledge is distributed, documented and, where possible, automated.

Initially we did have most of the knowledge around the release process in the head of a single person and knew this had to change. After some synchronous conversations we were able to get the first version of their knowledge committed to a repository as step-by-step documentation. You can think of this like the `Initial commit` of some legacy code that lived outside of version control.

At this point it was tempting to change elements of the process after writing it down; "these steps could be reordered", "we could write a script for that", "this could be automated". These were good instincts to have but it was important to not change the process just yet. Like when dealing with an untested legacy codebase you need to focus on testing before refactoring to provide you with three things:

1. An understanding of how and why the code/process works how it does
2. Validation that the code/process does work how it claims to
3. A safety-net to ensure that the code/process remains the same after refactoring

It's probably not useful or practical to write automated unit tests to try and spot errors in documentation but doing some trial runs of the process is the closest human equivalent.

## The Trial Runs

We now had enough documentation in place to walk through a trial run of a GitHub Enterprise patch release. Like running new code for the first time not everything behaved quite as expected. There were edge-cases that weren't handled, environmental conditions that were assumed and some steps that were unnecessary.

All software has a "minimal optimum version" of the code hiding out of sight. By "minimal optimum" we mean it does everything it needs to consistently with as little code as possible. The same instinct engineers have to try and pare down to this minimal optimum code is the same instinct we took with Runnable Documentation. For example, after a few trial runs through the documentation we were able to cut out a bunch of things, clarify others and work out where it was important to focus time and what could be skimmed over. We resisted the temptation to automate at this time; it's important to ensure the existing process is 100% understood before trying to automate it.

## The Process (v2)

By this stage we've had a working version of the process documented as some Runnable Documentation from a few trial runs. It's an entirely manual process but we understand the problem sufficiently now to focus on optimization. Let's think about optimizing code first. The following code isn't great:

```
puts 1
puts 2
puts 3
```

Computers are good at things like running the same command multiple times with varying input data so it'd be better to do something like:

```
(1..3).each {|i| puts i}
```

Similarly this documentation isn't great:

```
- run `build.sh 1.0.0`
- run `package.sh 1.0.0`
- run `test.sh 1.0.0`
```

Why are we asking the user to run multiple scripts with the same input each time? A better idea would be to combine them into a single script (or create a new script that calls all three).

```
- run `release.sh 1.0.0`
```

Our goal with the Runnable Documentation was to optimize for as little documentation as possible. Why ask the reader to call three scripts if they can call one? Why ask the reader to manually check things if they can be automated?

## The Automation

If you're really lucky you may be able to replace all your Runnable Documentation with a single script (e.g. `script/release`) or an automated task. We prefer code over documentation (where possible) because it's much easier to automatically verify that code is working and engineers tend to be more vigilant in fixing broken code than outdated documentation.

GitHub's Enterprise release process was too complicated for a single script and instead requires multiple, time-separated steps with some human interaction and judgement between them. For example, deciding whether we want to build another prerelease is dependent on judgement on the results of manual QA, the importance of new additions and the risk of destabilizing by changing things too late in the release cycle.

GitHub makes heavy use of Hubot ChatOps internally for semi-automated processes where we move from following documentation and manual commands run on developers' machines to commands run in a chat application. This provides a few benefits:

- Script output can be made richer in a chat room than in a terminal (e.g. using HTML/Markdown)
- Environment setup can be handled on a shared, central machine rather than requiring everyone to set up the same thing on their own machine
- You can run commands anywhere you can run a chat client

For example, in GitHub Enterprise (and most release processes) we needed to know what's changed between the release we're releasing and the previous one. Knowing these changes allows you to write release notes and ensure QA can focus on relevant areas. While you could have the release person work this out by checking Git repositories this could be better handled by ChatOps that takes the current and previous release versions as arguments and summarizes the pull requests that have gone into this release.

GitHub also provides webhooks. These allow calling external HTTP endpoints on repository events. For GitHub Enterprise's release process we wrote a small web application called [HookHand](https://github.com/mikemcquaid/HookHand) to provide a service for calling arbitrary scripts from webhooks. A particularly useful script uses the GitHub API to automatically update a release dashboard to display all the pull requests that have been merged to the current release's branch.

## An Example

This is a small section of runnable documentation from GitHub Enterprise's release process documentation:

```
## Step 11: Upload Final Release
Create the release tag in all Enterprise projects from the last
prerelease tag and rename the final prerelease for releasing
by running from Chat:

/ghe-tag --publish enterprise-2.3.0.GM2 2.3.0

Check the S3 and CloudFront checksums match by running from Chat:

/ghe-checksums 2.3.0

If they don't, then you either need to wait a bit longer for the
CloudFront invalidation to complete.

You'll need to wait 15-30m for the AMI to no longer be pending and
then make them public by running from chat:

/ghe-set-access public 2.3.0
```

The three commands here were separated as they require a time-gap with human discretion between each. Each command performs multiple tasks which could be done manually but automation makes it less time-consuming and error-prone for the person running the release.

## Conclusion

We've found that having Runnable Documentation has improved the quality, speed and accessibility of the GitHub Enterprise release process. Now anyone can jump in and help out with a release, see the current state on a dashboard and analyze differences between releases without needing to be walked through it by other developers or perform any setup on their local machine.

---

*Originally published on the [GitHub Blog](https://github.blog/2015-10-06-runnable-documentation/).*
