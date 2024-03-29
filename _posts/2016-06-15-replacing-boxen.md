---
redirect_from:
- /2016/06/15/replacing-boxen/
---
When I started working at [GitHub](https://github.com) my GitHub-provided MacBook was bootstrapped with [Boxen](https://github.com/boxen/boxen/). Boxen is a tool for managing OS X development machines using Puppet to install and update packages, start persistent services, install and bootstrap projects and apply security policies. Over time I went from a Boxen novice to power user to internal and external maintainer and finally to implementing its replacement for GitHub.

Boxen relies heavily on Puppet so Puppet's strengths and weaknesses tend to be the same as Boxen itself. In my experience tools like Puppet and Chef work well given the following requirements:

- Puppet/Chef are the sole method of modifying configuration files and installing software on a machine
- The consumers of Puppet/Chef's output are people who understand at least the basics of how Puppet/Chef work
- Operations that fail will not usually succeed when immediately retried

In my experience maintaining Boxen none of these requirements held true. Users expected to be able to able to install random software with Homebrew and random versions and not have it interfere with Boxen, they wanted to be able to customise configuration in a way that Boxen disagreed with, they found Boxen's output confusingly non-actionable and flaky internet connections and Puppet logic meant that "rerun `boxen`" was the best way to fix problems.

I noticed that some of the engineers in GitHub had stopped using Boxen in favour of just using Homebrew and some manual personal configuration. As a result I decided to plan a new replacement for Boxen to handle each of Boxen's main requirements:

1. bootstrap an OS X system to install things all developers will need and sensible security defaults
2. bootstrap projects to install and setup all their system-level/shared dependencies
3. allow user customisation of their environment and extra packages to be installed so they can reproduce their current setup on another machine

Rather than trying to do this in a single piece of software that I would maintain myself I decided to try and make use of the software that already existed in the Homebrew ecosystem. This provided a few benefits: following a more Unix-like philosophy of combining several small tools to create a larger system, improving open-source software with existing communities that would help with testing, bug fixing and maintenance and reducing the amount of development work required overall.

These requirements ended up broken down into the following tools:

1. bootstrap an OS X system: I created a new tool named [Strap](https://github.com/MikeMcQuaid/strap/) (credit for the name and idea goes to my coworker [John Barnette](https://github.com/jbarnette)) which uses a simple Bash script generated by a Sinatra web application (to provide GitHub credentials) to bootstrap an OS X system with:
    - [Homebrew](http://brew.sh) (for installing command-line software)
    - [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) (for `bundler`-like `Brewfile` support)
    - [Homebrew Services](https://github.com/Homebrew/homebrew-services) (for managing Homebrew-installed services)
    - [Homebrew Cask](https://github.com/Homebrew/homebrew-cask) (for installing graphical software)
    - no actual software installed by the above but all the other requirements for their use (e.g. the Xcode Command Line Tools)
2. bootstrap projects system-level/shared dependencies: I used and improved the  [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) tool to allow each project to have a `Brewfile` with Homebrew packages which are shared at a system level and have background services started automatically. `brew bundle` is generally executed by `script/bootstrap` (following [GitHub's "scripts to rule them all" pattern](https://github.com/github/scripts-to-rule-them-all)). I also [created some helper scripts to setup nginx, build Ruby/NodeJS and report issues from project `script/bootstrap`s](https://github.com/github/homebrew-bootstrap).
3. allow user customisation of their environment and extra packages to be installed: most of this I left unimplemented so users who need this functionality can use a [dotfiles](https://github.com/MikeMcQuaid/dotfiles) repository for sharing configuration but had anything in their `~/.Brewfile` or `https://github.com/username/homebrew-brewfile/Brewfile` automatically installed by Strap using Homebrew Bundle.

After using this system for a while by myself I invited a few other GitHubbers who had stopped using Boxen to try this new system out (now internally known as "Strap" despite most of the actual functionality being in Homebrew). After this was deemed to be successful fellow Homebrew maintainer and coworker [Misty de Meo](https://github.com/mistydemeo) worked to port over all existing projects using Boxen to "Strap" while I worked to migrate all individuals in engineering. This completely successfully in May 2016 and GitHub stopped using Boxen and I stopped maintaining Boxen.

Hopefully this post has given you an interesting overview of how we went about replacing a system that all engineers at GitHub were relying on for their system setup and daily development.
