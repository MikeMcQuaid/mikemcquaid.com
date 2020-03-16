---
title: Making Homebrew Financially Sustainable
---

More and more open source projects are seeking to get financial support from their users. In this post I’m going to talk about the approaches we’ve taken in Homebrew and their pros and cons.

In 2013 Homebrew’s method of building binary packages (bottles) involved me manually doing so in a VM on my Mac. Similarly, user contributions were tested by being run on the machines of the reviewing maintainer. This wasn’t going to scale. I decided the solution was for us to have our own dedicated Macs to run CI on pull requests and build our binary packages.

[Homebrew launched a Kickstarter](https://www.kickstarter.com/projects/homebrew/brew-test-bot) to pay for these Macs and it was completely funded in less than 24h and we made nearly 10x our original goal. The lovely [Positive Internet Company](https://positive-internet.com) also offered to host the new Mac Minis for free so we had a high-speed, reliable connection and host.

This predated the existence of free, decent Mac CI or cloud hosting services (and my becoming a father) so a lot of time had to be invested for initial setup and configuration and ongoing maintenance and upgrades. Most of this fell on my shoulders as I was the main person willing and encouraging the work.

As time went on our financial, legislative and technical CI systems became limited again. A one-off payment to a UK bank account, no legal/non-profit presence and maintenance falling on my shoulders meant we had to look for better solutions.

The [Software Freedom Conservancy](https://sfconservancy.org) accepted Homebrew as a member project and we transferred our existing funds to them and, through them, now had a [501c3](https://www.501c3.org/what-is-a-501c3/) to receive charitable donations and a legal entity to control our finances, expenses and nudge us into having some structure (a project leadership committee) to manage these.

With a goal to move more of our self-hosted to cloud hosting (free or paid if needed) and pay for a conference for maintainers to meet one another we wanted to receive regular, predictable donations to the project and notify our users that we needed their donations.

For predictable donations we set up the standard (at the time at least): a Patreon account. We offered nothing in exchange for donations but to told people we were an entirely volunteer-run project.

We’d had [a section of our README soliciting donations](https://github.com/Homebrew/brew#donations) but this never got too much uptake. We’d previously wanted to make a similar global notification to users about our [opt-out analytics](https://docs.brew.sh/Analytics). This approach (a one-time message on interactive sessions) felt appropriate for donations too. We show users a one-time message on first install or on a Homebrew update to tell them we needed donations and where and how to do so.

As soon as this message rolled out we saw a huge jump on donations eventually settling between [$2500-$3000 a month on Patreon](https://www.patreon.com/homebrew) along with some (large) one-off donations through the Software Freedom Conservancy. This provides us with the ability to pay for services and software we need and for maintainers to meet each other for high-bandwidth communication in person. This was achieved without selling our users attention or data (advertising), nagging them regularly (nagware) or making them pay for Homebrew (proprietary software licenses) so resulted in no backlash and a better funded project. Win/win!

---

Thanks to [Nadia Eghbal](https://nadiaeghbal.com) for reviewing this post.
