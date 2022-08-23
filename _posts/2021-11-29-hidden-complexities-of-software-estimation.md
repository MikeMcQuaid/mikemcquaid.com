---
redirect_from:
- /2021/11/29/hidden-complexities-of-software-estimation/
---
I'm currently working on an internal GitHub project where, for a change, my estimations have been wildly off. Before this project, I'd had a good multi-year streak of never overshooting my estimates and consistently hitting deadlines. This overshoot, combined with some recent reading, has made me think about hidden complexities of software estimation and what I didn't consider when making my estimates. These are in a rough order from "most obvious" to "least obvious".

When estimating a software project you should not:

- refuse to estimate because of any of the reasons below
- plan things to go as you expect
- ignore testing, code review, deployment and integration takes time, often longer than writing the code
- present exact dates or times without ranges
- be pressured into different estimates for the same scope based on "business needs"
- be unwilling to pad estimates based on them "feeling" too long
- estimate the entire project without splitting it up individually ranged, estimated sub-projects
- be unwilling to adjust estimates after or during a project based on sub-project completion
- have a non-engineer produce the estimate
- have an engineer who will not be doing the work produce the estimate, without discussion with the engineer that will be doing the work
- assume that engineers will do the work in the same amount of time, even if they are the same "level". [Individuals matter](https://danluu.com/people-matter/).
- assume that other individuals/teams/departments will always be as responsive as you need them to be and never block progress
- estimate assuming that you will not reduce technical debt, leaving things better than you found them
- ignore [Hofstadter's law](https://en.wikipedia.org/wiki/Hofstadter%27s_law): "it always takes longer than you expect, even when you take into account Hofstadter's Law."
- ignore the sporadic relevance of [Parkinson's law](https://en.wikipedia.org/wiki/Parkinson%27s_law): "work expands so as to fill the time available for its completion"
- ignore [the project management triangle](https://en.wikipedia.org/wiki/Project_management_triangle) and discussions of which corner to prioritise
- ignore that context-switching has a cost, particularly between different projects
- ignore that re-orgs, team changes and internal or external controversies will distract engineers and cause projects to take longer
- ignore that the more novel the work, the less accurate the estimate
- ignore that cutting scope often results in both a better estimate and the ability to get user feedback earlier
- ignore that how work is grouped on a project can affect the overall estimate
- ignore that engineers work faster on work they are excited about
- ignore that happy teams work faster

You cannot increase all your estimates due to all the above. They won't all be relevant every time. You should ask yourself which of these are most likely to be relevant when you do your estimations. If things change during or after your estimations, e.g. a team change or re-org, you should communicate that the estimates will be affected to whomever you communicated these estimates to.

---

Of course this article bears a huge debt to the many decades of writing on software estimation such as [The Mythical Man Month](https://en.wikipedia.org/wiki/The_Mythical_Man-Month), which I've never actually read, and [Peopleware](https://en.wikipedia.org/wiki/Peopleware:_Productive_Projects_and_Teams), which I read and enjoyed.

---

Thanks to [@bigkevmcd](https://github.com/bigkevmcd) and [@DW-DW-DW](https://github.com/DW-DW-DW) for reviewing this article.
