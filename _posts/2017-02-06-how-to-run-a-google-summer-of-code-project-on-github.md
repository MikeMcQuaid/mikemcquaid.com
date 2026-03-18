---
title: How To Run A Google Summer Of Code Project On GitHub
redirect_from:
- /2017/02/06/how-to-run-a-google-summer-of-code-project-on-github/
---
Google provides some guidance on how to effectively run a Google Summer of Code project but it's not tailored specifically to GitHub's workflow. To set clear expectations for mentors and students here's our ideas on how to successfully participate in Google Summer of Code as a mentor or organization administrator.

## The application process

### Document project ideas

Make a dedicated file or repository for documenting project ideas and discuss them in issues. The ideas should be things that are going to be useful to your project, would take a maintainer a week or two to complete and you think should take a student between a month and a month and a half to complete. You can populate these from `help wanted`-labeled issues in your repository. They should be brief enough to stimulate discussion on their implementation but not detailed enough for students to be able to copy-paste any part into their proposal.

For example, the Homebrew project has [a repository for these ideas](https://web.archive.org/web/20170206215645/https://github.com/Homebrew/Outreachy-and-Google-Summer-of-Code) (updated for GSoC 2017).

Strongly encourage students to adopt one of your ideas rather than their own. You have a much better idea than they do on what will be useful, achievable, and mergeable.

### Require a merged pull request to your project

Rather than angsting over student technical interviews or their proposals documents you should make your decision primarily on which students (if any) to accept based on a trial of the work you expect from them in the summer: a pull request to your project's repository. Google expects students to get involved in communities so requiring e.g. a one line change in a pull request is more time efficient than any other metric.

In general any established GitHub open source repository should have an easy way for new, aspiring contributors to submit a useful pull request. In Homebrew's case they have a `brew audit` linting tool where some lints are deliberately left unfixed to give newcomers an opportunity for an easy first pull request.

For example, the Homebrew project's process is [documented in their README](https://github.com/Homebrew/brew#contributing).

You should not help students any more than any new contributor or provide any more guidance than what's already documented in your project. If they ask for help, point them to the instructions (and consider improving them). If they cannot figure out what other contributors can: they are unfortunately not good candidates for GSoC which requires them to be self-motivated, driven and able to learn independently over the summer.

Provide regular review to student pull requests before the application deadline. Make it clear to the student that the pull request must go through the review process and get merged before you can accept their application. They're in a rush, but you shouldn't be. In respect of time, students shouldn't rush last minute to hit a deadline.

## The summer

### Favor small pull requests over large ones

This is a good principle in general but not the typical mindset for students who typically do work for a single output that's handed in. Encourage them to split their work up into multiple, regular pull requests over the summer so their pull requests can be more easily reviewed and merged.

For example, see [@AnastasiaSulyagina's pull request to remove some duplicated exceptions](https://github.com/caskroom/homebrew-cask/pull/22574) as part of Homebrew's 2016 GSoC. This was a small change review and a merge followed quickly.

### Maintain normal flow

Most of your interactions with your student should look like your interactions with other maintainers and contributors on your project. For example, if you talk with other maintainers on Slack, invite your student and encourage them to ask questions when they have them. If you can talk about things in issue comments and pull request reviews: do that instead of video calls or other private methods of communication so that other maintainers can help provide review and feedback.

### Brief, regular check-ins

Have a meeting that you both stick to every week (that neither of you are on vacation) on text (i.e. IM), audio or video chat. Defer to the student's preferences on IM vs. audio/video as they may feel more comfortable communicating over text if English isn't their first language. This should be your chance to see what progress there has been if there's been no public activity. That said, a week with no commits, issue comments, or PR comments is a sign of major concern that you should raise with the student.

### Strict failure requirements

As mentioned previously: you should not accept students who have not made a trivial pull-request to your project. Similarly, the focus of the summer should be around pull-requests too. If the student does not have a significant, non-trivial pull request opened by their mid-term: they should fail. If the student does not have a significant, non-trivial pull request merged by the end of the program: they should fail. Again, splitting the work up into multiple pull requests over the summer is vastly preferable to opening pull requests at the last minute.

Like many things in life: strict, no-compromise boundaries may sound harsh but end up being kinder to the student. You can communicate these expectations at the beginning of the program and then they don't need to worry about whether they will pass or fail. This is also a life lesson: many deadlines after graduation are not negotiable and it's better to fail at GSoC than many other things in life.

### That seems quite strict?

It does, yes. The requirements above may mean that you're not able to get any students who are good enough for your project or that you need to fail students. This is unfortunate but it's ultimately better for students and much better than having a bad GSoC experience.

For point of comparison while following the above system for the last two years the Homebrew project has always had more good students than mentors available for them, never failed any students, had the majority of students ship major features our users have been happy with and, best of all, had a minority of students become and stay Homebrew maintainers.

Now that you know how to effectively run a Google Summer of Code project on GitHub consider [applying as a GSoC organisation](https://summerofcode.withgoogle.com/org-signup/) before the February 9, 2017 at 17:00 (GMT) deadline and have a great summer!

---

*Originally published on the [GitHub Blog](https://github.blog/2017-02-06-how-to-run-a-google-summer-of-code-project-on-github/).*
