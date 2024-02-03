---
redirect_from:
- /2015/05/24/how-i-get-things-done/
- /2021/07/21/how-i-get-things-done/
---

The first thing you need to accept is: your memory sucks. If you have tasks you want or need to do in life (for yourself or for others) chances are you can't remember them all. That's why organised people don't rely on their own memory and instead have a system to track their commitments. In this post I'll explain my system and why it is the way it is.

![Notes.app]({{ '/images/a/notes.png' | absolute_url }})

Firstly, when someone asks me to do something I immediately write it down in my Apple's Notes app. This doesn't have any mechanism for storing dates or times but just lets me enter text. This is good because it's available and synced everywhere. If I have time (or when I next do) I then sort into lists based on topic matter. Some of my long-running lists are: [**GitHub**](https://github.com/) (my current employer), **Open Source** (encompassing [Homebrew](http://brew.sh) and open-source projects I work on) and **Random** (a short dump for other tasks). Every time I do work for GitHub, open-source or myself I look on the relevant location to see what I should do.

I try my long-running notes structured into sections headed:

- **Urgent** - tasks that need done soon
- **Don't Do** - the sort of tasks I shouldn't be doing
- **Todo** - tasks that need to be done eventually
- **Blocked** - tasks I can't do until something happens
- **Notes** - a dumping ground for anything that doesn't fit above

![Reminders]({{ '/images/a/reminders.png' | absolute_url }})

When there's a task with a time or date I put it into either Apple's Reminders or Calendar app. Reminders gets anything that needs done on a particular date or repeatedly but doesn't require me to go anywhere. Calendar is generally when I need to go somewhere or if it's e.g. an online meeting that has a specific start and end time. These apps will pop up alerts on my Apple devices with a noise or vibration so I actually remember them.

![Calendar]({{ '/images/a/calendar.png' | absolute_url }})

The above was sufficient in 2015 when I first wrote this post but since I got promoted to Staff Engineer at GitHub I've had to get a lot better at keeping track of what I plan to work on in future, am working on right now and have completed. I've found a personal GitHub Projects board to be a good fit for this. I have columns headed:

- **Backlog** - tasks I may or may not ever do but want to keep track of
- **Up Next** - tasks I plan to work on in the near future
- **WIP (Work In Progress)** - tasks I'm working on right now
- **Blocked** - tasks I can't do until something happens
- **Done This Week** - tasks I've completed this week; I'll report on these and archive

![Projects]({{ '/images/a/projects.png' | absolute_url }})

If you have any familiarity with [Getting Things Done](https://en.wikipedia.org/wiki/Getting_Things_Done) then some of the above may seem familiar. I tried to follow it strictly in the past but found the structure overkill for me personally. I tend to keep my various TODO lists short enough that I can quickly scan and mentally prioritise them daily.

So far it's relatively straightforward but I've omitted the most common productivity nightmare: email. I've heard the main problem with email being that it's basically a TODO list that anyone can add to at any time. This is a problem.

First thing to do with your email is trying to keep [Inbox Zero](https://www.43folders.com/43-folders-series-inbox-zero). In short: the default state of your inbox should be to have no emails in it and when you check your email you should end up with an empty inbox afterwards. This sounds like a bit of a pipe dream so let me tell you how I try to do this.

You probably get a bunch of email that you expect. Someone commented on your GitHub issue. Your company's weekly newsletter got sent round. That person in your office who sends you only junk. These all patterns and patterns are good because a computer can handle them trivially for us. What I do is set up filters (in Gmail, iCloud, Outlook, etc.) which sorts each type of email into a folder ("label and archive" in Gmail). My long-running personal email folders are **Bills**, **GitHub**, **News**, **Social** (all social media notifications) and **Software**. This immediately let's me prioritise these groups. Anything in these folders is never urgent during work time. If I'm emailed by someone I didn't expect (e.g. my dog) it may be urgent so it ends up in the inbox instead of a folder.

![Dogmail]({{ '/images/a/dogmail.jpg' | absolute_url }})

I also keep my personal, Homebrew and GitHub emails in separate email accounts with different filtering rules. This makes it easier for me to ignore Homebrew and GitHub emails when I'm not working or on my phone. If you're interested in my GitHub filtering rules, [I wrote a post on the GitHub blog about managing large numbers of notifications](https://github.blog/2017-07-18-managing-large-numbers-of-github-notifications/).

![Mail]({{ '/images/a/mail.png' | absolute_url }})

It's important to ask yourself when you get a new email: was this expected, somewhat urgent/important or even desirable? If not, filter it into a folder, unsubscribe from the mailing list, tweak your social media notifications or setup a filter to just automatically mark it as read and archive/delete it. Stop wasting your time repeatedly ignoring the same emails.

![Filters]({{ '/images/a/filters.png' | absolute_url }})

The tricky thing with the above system: what do you do if you don't have the time to reply immediately to an email or it's generally something you want to deal with later? I used to enjoy the [Mailbox](https://en.wikipedia.org/wiki/Mailbox_(application)) (an email client from DropBox) "Later" feature which could remind me of an email at a later point. Mailbox is no longer around and I've been burned too many times by my email clients going away that I feel I can no longer rely on this functionality (until it's in Apple Mail or Gmail).

I now have returned to will leaving email in my inbox if it needs actioned imminently (i.e. this month) or flag ("star" in Gmail) if I need it at some point in future. Both Apple's Mail app and particularly Gmail provide good enough search that I can always find what I need (as I always archive and never delete emails).

![Slack]({{ '/images/a/slack.png' | absolute_url }})

Slack has become a bigger part of my life for GitHub and Homebrew since I originally wrote this post in 2015. I tend to treat it pretty similarly to email: it can be a bit of a TODO list but I don't want others to control it. Thankfully, it does have a pretty decent reminders feature that gets me back what I lost from Mailbox.

---

I hope you found this post to be useful. To summarise: immediately write down tasks you need to do on your phone/computer, triage them regularly, assign times/dates when possible and automate your email for easier prioritisation.

Finally, a pet hate: if you commit to doing something for someone please immediately make a note of this and actually do it in a timely fashion or let the person know if you can't. This alone will make you seem like A Productive Person. Don't try to just remember (because you won't) or write it on a scrap of paper because you'll lose it.

Good luck!
