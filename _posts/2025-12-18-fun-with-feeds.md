---
title: POSSE, Blog and Feed Updates
---
I've been following what [Justin Searls](https://justin.searls.co/) has been doing with his blog for some time.
He's been leaning into the ["POSSE" (Publish on your Own Site, Syndicate Elsewhere)](https://www.citationneeded.news/posse/) philosophy more and more.
In practice, this looks like building your own version of a single-serving social network on your own site and exposing RSS/Atom feeds to other services to consume.
Justin recently released [POSSE Party](https://posseparty.com) which makes this easier by cross-posting to various social networks.
I've complained for a while about
[(anti)social networking]({% post_url 2015-03-01-antisocial-networking %})
so I'm always up for new ways to use social networking less.

### 🙋 Why?

I don't have analytics for this blog.
I have no idea how many people read it or why they read it.
As I care about backwards compatibility, a blog post is the only reliable way to communicate changes to subscribers.

### 🧑‍💻 What Changed?

As a result of leaning more into POSSE, on this site I've made a few changes:

- Built my own mini Twitter/Bluesky/Mastodon/Threads equivalent called "Thoughts" at [`/thoughts`]({{ '/thoughts' | absolute_url }})
- Moved the homepage at [`mikemcquaid.com`](https://mikemcquaid.com/) to be all recent Articles, Thoughts, Talks and Interviews.
- Added a dedicated [`/articles`]({{ '/articles' | absolute_url }}) for all Articles instead.
- Kept the original Atom/RSS feed at [`/atom.xml`]({{ '/atom.xml' | absolute_url }}) just for Articles (backwards-compatibility and all that)
- Added new dedicated Atom/RSS feeds:
  - [All Feed]({{ '/all.xml' | absolute_url }}) (all homepage content, excluding Thoughts)
  - [Talks Feed]({{ '/talks.xml' | absolute_url }})
  - [Interviews Feed]({{ '/interviews.xml' | absolute_url }})
  - [Thoughts Feed]({{ '/thoughts.xml' | absolute_url }})
- Wired these up to POSSE Party and my newsletter to send relevant content elsewhere to my Twitter/Bluesky/Mastodon/Threads/email subscribers.

If you're interested in the technical side, you can see what I did [on GitHub](https://github.com/MikeMcQuaid/mikemcquaid.com).
Given we're in 2025, yes, I leaned pretty heavily on OpenAI Codex and ChatGPT for a lot of this.
In the spirit of ["vibe engineering"](https://simonwillison.net/2025/Oct/7/vibe-engineering/) rather than "vibe coding", I reviewed and edited all the code by hand.

### 🫵 What Do You Need To Do?

**TL;DR: If you're subscribed to [`/atom.xml`]({{ '/atom.xml' | absolute_url }}), nothing changes.**
**If you want additional content: subscribe to one or more of the new feeds above.**

Thanks for reading this blog ❤️.
It will be 20 years old in 2026 and it's nice to see the current blogging resurgence.
