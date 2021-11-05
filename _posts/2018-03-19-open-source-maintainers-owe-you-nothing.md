This post is heavily inspired by my experience over the [last ten years participating in the open source community]({{ '/projects/' | absolute_url }}) and eight years as a maintainer of [Homebrew](https://github.com/Homebrew/brew) (which I've maintained longer than anyone else at this point).

---

[Burnout](https://en.wikipedia.org/wiki/Occupational_burnout) is a big problem for open source software maintainers. This is avoidable; maintainers can have fun, keep healthy and be productive working long-term on open source projects. How? By realising they have zero obligations to any other maintainers, contributors or users of their software even if they have personally benefited from the project (e.g. through self-promotion or donations).

Is there any basis to state that maintainers have no obligations? In fact, yes: in open source licenses themselves. Let's start by looking at [the most popular open source license used on GitHub](https://blog.github.com/2015-03-09-open-source-license-usage-on-github-com/): [the MIT license](https://choosealicense.com/licenses/mit/).

> The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

Let's turn this legalese into plainer English (note that [I Am Not A Lawyer](https://en.wikipedia.org/wiki/IANAL)):

- The way the software is today is all that the maintainers ever agree to provide you (bugs and all)
- The maintainers provide no assurances that the software will ever work for any user or use case (even documented ones)
- The maintainers are never liable for any problems caused by any use of the software (including damages that require you to pay for repairs)
- You must agree with the above to have any right to use the software

This isn't just an MIT license thing, either. The [BSD 2-Clause](https://choosealicense.com/licenses/bsd-2-clause/), [GPLv3](https://choosealicense.com/licenses/gpl-3.0/), [MPL v2.0](https://choosealicense.com/licenses/mpl-2.0/), [Apache v2.0](https://choosealicense.com/licenses/apache-2.0/), [Unlicense](https://choosealicense.com/licenses/unlicense/) and [almost every other open source license](https://choosealicense.com/appendix/) all limit liability and explicitly do not provide any warranty. In short, any open source software you use can delete all your production data and you can't sue anyone because in using the software you agreed to accept personal responsibility for any negative consequences.

In practise, however, when there are issues, maintainers often work quickly to resolve them and apologise in the same way as a company does. This is one of the biggest causes of burnout; most open source software is developed by volunteers in their free time but both maintainers and users of open source software have adopted an unsustainable business/customer-like relationship.

Most maintainers start working on open source software because it's fun and solves a problem they have. Many continue out of a sense of obligation instead of fun and over time this unpaid, increasingly non-fun work grinds them down. When they make a controversial decision and receive abuse for it, their friends and family start to ask them if open source is worth the grief.

How can we fix this? By having everyone in the open source ecosystem embrace the legal realities of open source. In practice this means:

- For maintainers: if you're not enjoying most of your work on a project, don't do it anymore. If users are unwilling to interact on your project without being rude, block them and don't do what they've asked. Don't feel bad about bugs you introduced as all software has flaws. Congratulate yourself on giving something to the world and asking for nothing in return.
- For contributors: defer to maintainers and ensure that you've read all relevant contribution documentation. They are the ones running the project and ultimately their word goes. Understand that it's not the job of the maintainers to teach you how the project works (or actually anything).
- For users: remember when filing an issue, opening a pull request or making a comment on a project to be grateful that people spend their free time to build software you get to use for free. Keep your frustrations and non-actionable negativity to yourself (or at least offline and out of earshot). Don't expect anyone to fix your issues or help you if you're unwilling to dedicate more time to helping yourself than you ask of others. This means reading all the documentation and trying to resolve your own issues before ever asking for any help.

If we can all do more of this then we'll see fewer projects dying because the maintainers cannot cope with the crushing obligations that they have forgotten that they do not actually have. Instead, we can have happier maintainers, helpful contributors and grateful users who all understand where they fit into the open source ecosystem.
