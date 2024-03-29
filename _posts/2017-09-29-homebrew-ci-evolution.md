---
title: Homebrew's CI evolution
redirect_from:
- /2017/09/29/homebrew-ci-evolution/
---

When I started contributing to and then maintaining Homebrew in 2009 it had no continuous integration, automated testing or binary packages on the project. Contributors would create an issue with a link to a commit in their fork, Max Howell ([@mxcl](https://github.com/mxcl), Homebrew’s creator) or a maintainer would test the change locally and then push it to Homebrew’s `master` if it worked.

One day Max and I were chatting and he floated the idea of having binary packages in Homebrew for things that took a really long time to build (e.g. Qt and Boost). I went off, played around and came up with the [simplest thing that could work](http://www.extremeprogramming.org/rules/simple.html): a tarball of the package’s installation prefix in the Cellar. Keeping in with Homebrew’s beer theme I decided to call these binary packages “bottles”.

## Bottles v0.1

The first iteration of bottles was my manually building them on my local machine, uploading them to SourceForge and making changes to the formula (the package build instructions) file by hand. This ended up having a couple of issues relating to optimisation for the architecture of my specific machine and contamination from the packages I had installed.

## Bottles v0.2

To build generically optimised packages and avoid cross-contamination I started building bottles in VMware Fusion Mac OS X VMs on my local machine for each of the versions of Mac OS X we currently supported. We also switched to generic compiler flags for bottles rather than optimising for my or the virtual hardware. Clearly this process did not scale. My time and the performance of current Mac became a bottleneck not just for building packages but for allowing bottled packages to be upgraded to the latest version. Additionally, when I went to build these packages I’d sometimes find that they had unrelated build failures that users may or may not have hit already. We needed automation, hardware and a way to pay for it.

## The Kickstarter

It was 2013 and the hot thing in crowdfunding was [launching a Kickstarter](https://www.kickstarter.com/projects/homebrew/brew-test-bot). As we had a concrete goal and fixed costs (i.e. buy a Mac mini) it seemed like a good fit. We met our goal in 24 hours so extended it to buying multiple Mac minis. After the Kickstarter completed I was able to buy the four Macs, some networking equipment and get them set up to build bottles, test and upload them automatically on pull requests. This provided not just automated binary package building but also automated testing for the Homebrew project. This endeavour was aided by [The Positive Internet Company](https://positive-internet.com) allowing us to contaminate their beautiful Linux data centre with our Mac minis for free.

## Fixing issues

This setup was pretty rock-solid for a long time but as Homebrew continued to grow eventually the load on the Mac minis made them occasionally fall over. This was aided by transitioning each of the physical machines to being a single VM host using VMware Fusion. This seemed to be enough to prevent the host hardware from ever being taxed sufficiently to fall over. We also moved from SourceForge to Bintray during this period due to SourceForge’s regular downtime.

## Unresolved issues

The one thing we could never quite manage to get rid of was the overhead of day-to-day work on the machines. OS X versions came and went and required both host and guest hardware updates. Hardware went down and required power cycling. Eventually we had one of the Mac minis motherboard burn out and I figured: these aren’t going to last forever. We needed a new approach before more of our hardware failed and something that required less maintenance.

## Enter MacStadium

Back at the time of the Kickstarter MacStadium had kindly offered to provide us with some hosting. As both Homebrew and MacStadium had grown in that time and I’d figured out how to ask for sponsorship properly I chatted with them again and they were happy to help out. They provided us with 3 Xserves running VMware’s ESXi (a variation of their [Private Cloud](https://www.macstadium.com/cloud/) package). Due to the shared FibreChannel storage, increased memory and CPU cores we were able to double the workers we had for each macOS version. The hosts are now always-on ESXi boxes run by MacStadium so require no maintenance from us and we are able to migrate VMs between hosts, make use of snapshots and use MacStadiums knowledge and network to improve our reliability.

## What about the minis?

After such a pleasant experience with MacStadium’s setup eventually our physical Mac minis were decommissioned, brought offline and returned to my house. As we wanted to do something with them we’ve tried to emulate MacStadium’s setup as much as possible, installed ESXi on them and have them hosted by [Commsworld](https://www.commsworld.com) in Edinburgh to provide CI slack for when e.g. we have a new macOS release (these were used to focus on building new bottles for macOS High Sierra’s release).

## What next?

Homebrew will continue to grow but our current CI setup should be something that lasts us for a long time. Thanks to MacStadium, Commsworld, Bintray, Positive Internet, SourceForge and Homebrew’s Kickstarter backers for getting us to where we are today!
