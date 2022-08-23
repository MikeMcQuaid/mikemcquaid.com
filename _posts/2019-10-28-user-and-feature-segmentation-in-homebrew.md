---
title: User and Feature Segmentation in Homebrew
redirect_from:
- /2019/10/28/user-and-feature-segmentation-in-homebrew/
---

Many software projects that operate at scale want ways to be able to expose some features or test some releases of their software on a subset of their users before they are released to the majority. In Homebrew we have two ways of doing this: developer segmentation and feature flags (that I stole from GitHub).

Many software projects have a “beta channel” that relies on users to know about it and (hopefully sensibly) self-select into it. This can work well if you have built-in exception reporting in your application, but for Homebrew we wanted a way to segment our users without their explicit intention. Additionally we needed to ensure that the users who received the beta channel were those who were willing and able to interact with the project through good bug reports and pull requests.

Homebrew has the concept of user commands and developer commands for interacting with the application. A user of Homebrew who does not wish to contribute to the project or run their own third-party repository (“tap”) will never need to run a developer command. As a result, the action of running developer command signals that the user is more likely to interact with the Homebrew project and ecosystem and have a better understanding of Homebrew internals or concepts. When a user runs a developer command we set a flag (which they can opt in or out of) which means their future updates will be on the beta channel. Technically this means that commits to ‘master’ are immediately deployed to these users while other users get these changes only when they arrive in a stable tag.

This segmentation results in 0.1% of our users being in the beta channel and 99.9% in the stable channel. We try to ensure that major changes sit in the beta channel for at least a workday before they make it into the stable branch. This has resulted in a more stable experience for most users and excellent bug reports and pull requests from the beta users. A small number of beta users complain when they realise how our segmentation works but are placated by the opt-out.

Sometimes new features are so unstable or unpredictable that we don’t want them to even go to our beta users yet. In this case we use feature flags through environment variables that enable the (new) functionality. These can be enabled manually by particularly brave guinea pigs (usually me), followed by other maintainers and/or our CI system and then go to the beta channel and stable users. This ability to gradually migrate drastic changes through increasingly large numbers of users through trivial runtime changes enables easy experimentation without damaging the stable experience we aspire to provide to most of Homebrew’s users.

---

Thanks to [Issy Long](https://issyl0.co.uk) for reviewing this post.
