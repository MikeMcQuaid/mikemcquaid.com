---
title: RubyGems Contribution Data with Homebrew's Tooling
---

There's ongoing discussion about recent changes to access in the RubyGems GitHub organisation.
If you need context, first read
[Open Source Turmoil: RubyGems Maintainers Kicked Off GitHub](https://thenewstack.io/open-source-turmoil-rubygems-maintainers-kicked-off-github/).
My goal is to share contribution data to help inform the conversation.

## 🍺 Homebrew Contributions

Hi, I'm Mike McQuaid 👋.
I've spent most of the last 13 years working on Ruby on Rails applications you may have used such as
[GitHub](https://github.com),
[AllTrails](https://www.alltrails.com),
[Workbrew](https://workbrew.com),
and [Strap](https://github.com/mikemcquaid/strap).
I've maintained
[Homebrew](https://brew.sh) (mostly written in Ruby)
for 16 years and have been the Project Leader since the position was created in 2019.
Some of
[my responsibilities](https://docs.brew.sh/Homebrew-Leadership-Responsibilities#project-leader-sole-responsibilities)
include assessing whether
[Homebrew maintainers'](https://github.com/homebrew/brew#who-we-are)
contributions make them eligible for:

- retaining commit access and membership in the [Homebrew GitHub organisation](https://github.com/homebrew/)
- receiving the
  [$300/month maintainer stipend](https://opencollective.com/homebrew/expenses?sort%5Bfield%5D=CREATED_AT&sort%5Bdirection%5D=DESC&searchTerm=maintainer-stipend&direction=RECEIVED)
  (paid quarterly)
- receiving other payments, e.g.
  [hardware grant](https://opencollective.com/homebrew/expenses?sort%5Bfield%5D=CREATED_AT&sort%5Bdirection%5D=DESC&searchTerm=hardware&direction=RECEIVED),
  [travel expenses to the AGM](https://opencollective.com/homebrew/expenses?sort%5Bfield%5D=CREATED_AT&sort%5Bdirection%5D=DESC&searchTerm=travel&direction=RECEIVED),
  [lunch with other maintainers](https://opencollective.com/homebrew/expenses?sort%5Bfield%5D=CREATED_AT&sort%5Bdirection%5D=DESC&searchTerm=lunch&direction=RECEIVED)

This is partly a matter of security
([principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege)),
partly a matter of responsible use of
[our funds](https://opencollective.com/homebrew?hostname=opencollective.com#category-BUDGET)
and partly a matter of fair recognition, making "Homebrew maintainer" reflect those doing the actual work.

We built a command for this in Homebrew:
[`brew contributions`](https://github.com/Homebrew/brew/blob/main/Library/Homebrew/dev-cmd/contributions.rb).
If you're trying it yourself to replicate these results, it uses the GitHub token from `HOMEBREW_GITHUB_API_TOKEN` or your keychain.

If I run it on myself for the last year, I get this output:

```console
$ brew contributions --user=mikemcquaid --from=2024-09-24 --organisation=Homebrew --csv
mikemcquaid contributed >=100 times (merged PR author), >=100 times (approved PR reviewer), 1787 times (commit author or committer), 35 times (commit coauthor) and >=2022 times (total) after 2024-09-24.

user,repository,merged_pr_author,approved_pr_review,committer,coauthor,total
mikemcquaid,all,100,100,1787,35,2022
```

This means that in the last year I:

- authored >=100 merged PRs
- ✅ reviewed >=100 merged PRs
- authored (I created it) or committed (I modified/rebased/committed it) 1,787 commits
- co-authored (someone accepted my GitHub suggestion) 35 commits

_Note: the >=100 or >=1000 in the output is to make things quicker and avoid hitting GitHub API rate limits._

This excludes actions like commenting on issues, which don't require write access.
Remember: [principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege).

These are the core metrics that I use to evaluate whether someone is maintaining Homebrew.
The tools and data are open.
Also, because we use OpenCollective,
[the money coming into and out of Homebrew is open](https://opencollective.com/homebrew?hostname=opencollective.com#category-BUDGET).

## 💎 RubyGems Contributions

Ok Mike, that's a lot about Homebrew: what about RubyGems?
Sorry, I'm getting to that.

Homebrew has open tooling to analyse GitHub contributions.
RubyGems has a GitHub organisation.
Let's combine the two.

First, who are the owners, maintainers, contributors and members of the RubyGems organisation?
It's not an easy question to answer, so I've built a list based on the people who either participated or were CCd by `indirect` on the
[Proposal for RubyGems Organizational Governance](https://github.com/rubygems/rfcs/pull/61).
I've also included the [current members of the RubyGems organisation](https://github.com/orgs/rubygems/people)

---

Let's look at contributions for the year preceding the removals:

```console
$ brew contributions --csv --from 2024-08-18 --org=rubygems --user=aellispierce,amatsuda,andremedeiros,arthurnn,arunagw,bai,bronzdoc,colby-swandale,deivid-rodriguez,djberg96,drbrain,duckinator,dwradcliffe,ecnelises,evanphx,farukaydin,hsbt,indirect,jenshenny,ktheory,landongrindheim,lauragift21,luislavena,martinemde,mensfeld,mghaught,olleolleolle,qrush,segiddins,sferik,simi,skottler,sonalkr132
...
```

| User             | Merged PRs | Approved PRs | Commits | Total |
|------------------|---------------------|---------------------|---------|-------|
| deivid-rodriguez | 100                 | 13                  | 1303    | 1416  |
| hsbt             | 57                  | 3                   | 379     | 439   |
| simi             | 36                  | 100                 | 254     | 390   |
| segiddins        | 93                  | 77                  | 194     | 364   |
| colby-swandale   | 45                  | 55                  | 77      | 177   |
| martinemde       | 49                  | 59                  | 64      | 172   |
| landongrindheim  | 48                  | 55                  | 54      | 157   |
| lauragift21      | 14                  | 4                   | 32      | 50    |
| duckinator       | 12                  | 0                   | 36      | 48    |
| olleolleolle     | 2                   | 18                  | 7       | 27    |
| mghaught         | 7                   | 8                   | 12      | 27    |
| indirect         | 1                   | 7                   | 3       | 11    |
| qrush            | 0                   | 1                   | 1       | 2     |
| mensfeld         | 0                   | 1                   | 0       | 1     |
| ktheory          | 0                   | 0                   | 0       | 0     |
| luislavena       | 0                   | 0                   | 0       | 0     |
| sferik           | 0                   | 0                   | 0       | 0     |
| skottler         | 0                   | 0                   | 0       | 0     |
| sonalkr132       | 0                   | 0                   | 0       | 0     |
| jenshenny        | 0                   | 0                   | 0       | 0     |
| farukaydin       | 0                   | 0                   | 0       | 0     |
| evanphx          | 0                   | 0                   | 0       | 0     |
| ecnelises        | 0                   | 0                   | 0       | 0     |
| dwradcliffe      | 0                   | 0                   | 0       | 0     |
| drbrain          | 0                   | 0                   | 0       | 0     |
| djberg96         | 0                   | 0                   | 0       | 0     |
| bronzdoc         | 0                   | 0                   | 0       | 0     |
| bai              | 0                   | 0                   | 0       | 0     |
| arunagw          | 0                   | 0                   | 0       | 0     |
| arthurnn         | 0                   | 0                   | 0       | 0     |
| andremedeiros    | 0                   | 0                   | 0       | 0     |
| amatsuda         | 0                   | 0                   | 0       | 0     |
| aellispierce     | 0                   | 0                   | 0       | 0     |

<details>
<summary>Full <code>brew contributions</code> Output</summary>
<pre>
$ brew contributions --csv --from 2024-08-18 --org=rubygems --user=aellispierce,amatsuda,andremedeiros,arthurnn,arunagw,bai,bronzdoc,colby-swandale,deivid-rodriguez,djberg96,drbrain,duckinator,dwradcliffe,ecnelises,evanphx,farukaydin,hsbt,indirect,jenshenny,ktheory,landongrindheim,lauragift21,luislavena,martinemde,mensfeld,mghaught,olleolleolle,qrush,segiddins,sferik,simi,skottler,sonalkr132
aellispierce contributed 0 times (total) after 2024-08-18.
amatsuda contributed 0 times (total) after 2024-08-18.
andremedeiros contributed 0 times (total) after 2024-08-18.
arthurnn contributed 0 times (total) after 2024-08-18.
arunagw contributed 0 times (total) after 2024-08-18.
bai contributed 0 times (total) after 2024-08-18.
bronzdoc contributed 0 times (total) after 2024-08-18.
colby-swandale contributed 45 times (merged PR author), 55 times (approved PR reviewer), 77 times (commit author or committer) and 177 times (total) after 2024-08-18.
deivid-rodriguez contributed >=100 times (merged PR author), 13 times (approved PR reviewer), 1303 times (commit author or committer) and >=1416 times (total) after 2024-08-18.
djberg96 contributed 0 times (total) after 2024-08-18.
drbrain contributed 0 times (total) after 2024-08-18.
duckinator contributed 12 times (merged PR author), 36 times (commit author or committer) and 48 times (total) after 2024-08-18.
dwradcliffe contributed 0 times (total) after 2024-08-18.
ecnelises contributed 0 times (total) after 2024-08-18.
evanphx contributed 0 times (total) after 2024-08-18.
farukaydin contributed 0 times (total) after 2024-08-18.
hsbt contributed 57 times (merged PR author), 3 times (approved PR reviewer), 379 times (commit author or committer) and 439 times (total) after 2024-08-18.
indirect contributed 1 time (merged PR author), 7 times (approved PR reviewer), 3 times (commit author or committer) and 11 times (total) after 2024-08-18.
jenshenny contributed 0 times (total) after 2024-08-18.
ktheory contributed 0 times (total) after 2024-08-18.
landongrindheim contributed 48 times (merged PR author), 55 times (approved PR reviewer), 54 times (commit author or committer) and 157 times (total) after 2024-08-18.
lauragift21 contributed 14 times (merged PR author), 4 times (approved PR reviewer), 32 times (commit author or committer) and 50 times (total) after 2024-08-18.
luislavena contributed 0 times (total) after 2024-08-18.
martinemde contributed 49 times (merged PR author), 59 times (approved PR reviewer), 64 times (commit author or committer) and 172 times (total) after 2024-08-18.
mensfeld contributed 1 time (approved PR reviewer) and 1 time (total) after 2024-08-18.
mghaught contributed 7 times (merged PR author), 8 times (approved PR reviewer), 12 times (commit author or committer) and 27 times (total) after 2024-08-18.
olleolleolle contributed 2 times (merged PR author), 18 times (approved PR reviewer), 7 times (commit author or committer) and 27 times (total) after 2024-08-18.
qrush contributed 1 time (approved PR reviewer), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
segiddins contributed 93 times (merged PR author), 77 times (approved PR reviewer), 194 times (commit author or committer) and 364 times (total) after 2024-08-18.
sferik contributed 0 times (total) after 2024-08-18.
simi contributed 36 times (merged PR author), >=100 times (approved PR reviewer), 254 times (commit author or committer) and >=390 times (total) after 2024-08-18.
skottler contributed 0 times (total) after 2024-08-18.
sonalkr132 contributed 0 times (total) after 2024-08-18.

user,repository,merged_pr_author,approved_pr_review,committer,coauthor,total
deivid-rodriguez,all,100,13,1303,0,1416
hsbt,all,57,3,379,0,439
simi,all,36,100,254,0,390
segiddins,all,93,77,194,0,364
colby-swandale,all,45,55,77,0,177
martinemde,all,49,59,64,0,172
landongrindheim,all,48,55,54,0,157
lauragift21,all,14,4,32,0,50
duckinator,all,12,0,36,0,48
olleolleolle,all,2,18,7,0,27
mghaught,all,7,8,12,0,27
indirect,all,1,7,3,0,11
qrush,all,0,1,1,0,2
mensfeld,all,0,1,0,0,1
ktheory,all,0,0,0,0,0
luislavena,all,0,0,0,0,0
sferik,all,0,0,0,0,0
skottler,all,0,0,0,0,0
sonalkr132,all,0,0,0,0,0
jenshenny,all,0,0,0,0,0
farukaydin,all,0,0,0,0,0
evanphx,all,0,0,0,0,0
ecnelises,all,0,0,0,0,0
dwradcliffe,all,0,0,0,0,0
drbrain,all,0,0,0,0,0
djberg96,all,0,0,0,0,0
bronzdoc,all,0,0,0,0,0
bai,all,0,0,0,0,0
arunagw,all,0,0,0,0,0
arthurnn,all,0,0,0,0,0
andremedeiros,all,0,0,0,0,0
amatsuda,all,0,0,0,0,0
aellispierce,all,0,0,0,0,0
</pre>
</details>

---

The month preceding the removals:

```console
$ brew contributions --csv --from 2025-08-18 --org=rubygems --user=aellispierce,amatsuda,andremedeiros,arthurnn,arunagw,bai,bronzdoc,colby-swandale,deivid-rodriguez,djberg96,drbrain,duckinator,
...
```

| User             | Merged PRs | Approved PRs | Commits | Total |
|------------------|---------------------|---------------------|---------|-------|
| deivid-rodriguez | 22                  | 0                   | 99      | 121   |
| landongrindheim  | 7                   | 27                  | 10      | 44    |
| hsbt             | 5                   | 0                   | 31      | 36    |
| simi             | 2                   | 8                   | 17      | 27    |
| colby-swandale   | 4                   | 5                   | 6       | 15    |
| martinemde       | 1                   | 2                   | 6       | 9     |
| segiddins        | 0                   | 4                   | 2       | 6     |
| lauragift21      | 1                   | 0                   | 2       | 3     |
| duckinator       | 1                   | 0                   | 1       | 2     |
| olleolleolle     | 0                   | 0                   | 1       | 1     |
| mghaught         | 0                   | 0                   | 1       | 1     |
| jenshenny        | 0                   | 0                   | 0       | 0     |
| ktheory          | 0                   | 0                   | 0       | 0     |
| luislavena       | 0                   | 0                   | 0       | 0     |
| mensfeld         | 0                   | 0                   | 0       | 0     |
| qrush            | 0                   | 0                   | 0       | 0     |
| sferik           | 0                   | 0                   | 0       | 0     |
| skottler         | 0                   | 0                   | 0       | 0     |
| sonalkr132       | 0                   | 0                   | 0       | 0     |
| indirect         | 0                   | 0                   | 0       | 0     |
| farukaydin       | 0                   | 0                   | 0       | 0     |
| evanphx          | 0                   | 0                   | 0       | 0     |
| ecnelises        | 0                   | 0                   | 0       | 0     |
| dwradcliffe      | 0                   | 0                   | 0       | 0     |
| drbrain          | 0                   | 0                   | 0       | 0     |
| djberg96         | 0                   | 0                   | 0       | 0     |
| bronzdoc         | 0                   | 0                   | 0       | 0     |
| bai              | 0                   | 0                   | 0       | 0     |
| arunagw          | 0                   | 0                   | 0       | 0     |
| arthurnn         | 0                   | 0                   | 0       | 0     |
| andremedeiros    | 0                   | 0                   | 0       | 0     |
| amatsuda         | 0                   | 0                   | 0       | 0     |
| aellispierce     | 0                   | 0                   | 0       | 0     |

<details>
<summary>Full <code>brew contributions</code> Output</summary>
<pre>
$ brew contributions --csv --from 2025-08-18 --org=rubygems --user=aellispierce,amatsuda,andremedeiros,arthurnn,arunagw,bai,bronzdoc,colby-swandale,deivid-rodriguez,djberg96,drbrain,duckinator,dwradcliffe,ecnelises,evanphx,farukaydin,hsbt,indirect,jenshenny,ktheory,landongrindheim,lauragift21,luislavena,martinemde,mensfeld,mghaught,olleolleolle,qrush,segiddins,sferik,simi,skottler,sonalkr132

aellispierce contributed 0 times (total) after 2025-08-18.
amatsuda contributed 0 times (total) after 2025-08-18.
andremedeiros contributed 0 times (total) after 2025-08-18.
arthurnn contributed 0 times (total) after 2025-08-18.
arunagw contributed 0 times (total) after 2025-08-18.
bai contributed 0 times (total) after 2025-08-18.
bronzdoc contributed 0 times (total) after 2025-08-18.
colby-swandale contributed 4 times (merged PR author), 5 times (approved PR reviewer), 6 times (commit author or committer) and 15 times (total) after 2025-08-18.
deivid-rodriguez contributed 22 times (merged PR author), 99 times (commit author or committer) and 121 times (total) after 2025-08-18.
djberg96 contributed 0 times (total) after 2025-08-18.
drbrain contributed 0 times (total) after 2025-08-18.
duckinator contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2025-08-18.
dwradcliffe contributed 0 times (total) after 2025-08-18.
ecnelises contributed 0 times (total) after 2025-08-18.
evanphx contributed 0 times (total) after 2025-08-18.
farukaydin contributed 0 times (total) after 2025-08-18.
hsbt contributed 5 times (merged PR author), 31 times (commit author or committer) and 36 times (total) after 2025-08-18.
indirect contributed 0 times (total) after 2025-08-18.
jenshenny contributed 0 times (total) after 2025-08-18.
ktheory contributed 0 times (total) after 2025-08-18.
landongrindheim contributed 7 times (merged PR author), 27 times (approved PR reviewer), 10 times (commit author or committer) and 44 times (total) after 2025-08-18.
lauragift21 contributed 1 time (merged PR author), 2 times (commit author or committer) and 3 times (total) after 2025-08-18.
luislavena contributed 0 times (total) after 2025-08-18.
martinemde contributed 1 time (merged PR author), 2 times (approved PR reviewer), 6 times (commit author or committer) and 9 times (total) after 2025-08-18.
mensfeld contributed 0 times (total) after 2025-08-18.
mghaught contributed 1 time (commit author or committer) and 1 time (total) after 2025-08-18.
olleolleolle contributed 1 time (commit author or committer) and 1 time (total) after 2025-08-18.
qrush contributed 0 times (total) after 2025-08-18.
segiddins contributed 4 times (approved PR reviewer), 2 times (commit author or committer) and 6 times (total) after 2025-08-18.
sferik contributed 0 times (total) after 2025-08-18.
simi contributed 2 times (merged PR author), 8 times (approved PR reviewer), 17 times (commit author or committer) and 27 times (total) after 2025-08-18.
skottler contributed 0 times (total) after 2025-08-18.
sonalkr132 contributed 0 times (total) after 2025-08-18.

user,repository,merged_pr_author,approved_pr_review,committer,coauthor,total
deivid-rodriguez,all,22,0,99,0,121
landongrindheim,all,7,27,10,0,44
hsbt,all,5,0,31,0,36
simi,all,2,8,17,0,27
colby-swandale,all,4,5,6,0,15
martinemde,all,1,2,6,0,9
segiddins,all,0,4,2,0,6
lauragift21,all,1,0,2,0,3
duckinator,all,1,0,1,0,2
olleolleolle,all,0,0,1,0,1
mghaught,all,0,0,1,0,1
jenshenny,all,0,0,0,0,0
ktheory,all,0,0,0,0,0
luislavena,all,0,0,0,0,0
mensfeld,all,0,0,0,0,0
qrush,all,0,0,0,0,0
sferik,all,0,0,0,0,0
skottler,all,0,0,0,0,0
sonalkr132,all,0,0,0,0,0
indirect,all,0,0,0,0,0
farukaydin,all,0,0,0,0,0
evanphx,all,0,0,0,0,0
ecnelises,all,0,0,0,0,0
dwradcliffe,all,0,0,0,0,0
drbrain,all,0,0,0,0,0
djberg96,all,0,0,0,0,0
bronzdoc,all,0,0,0,0,0
bai,all,0,0,0,0,0
arunagw,all,0,0,0,0,0
arthurnn,all,0,0,0,0,0
andremedeiros,all,0,0,0,0,0
amatsuda,all,0,0,0,0,0
aellispierce,all,0,0,0,0,0
</pre>
</details>

---

Added on request of [Nate Berkopec](https://www.nateberkopec.com):
all the
[contributors to rubygems/rubygems](https://github.com/rubygems/rubygems/graphs/contributors)
in the last ~1.5 years for the same timescales as above:

```console
$ brew contributions --csv --from 2024-08-18 --org=rubygems --user=deivid-rodriguez,hsbt,segiddins,martinemde,simi,duckinator,nobu,tangrufus,Edouard-chin,voxik,soda92,technicalpickles,jenshenny,jeromedalbert,ccutrer,nevinera,indirect,tenderlove,Maumagnaguagno,MSP-Greg,ntkme,mame,byroot,composerinteralia,flavorjones,johnnyshields,olleolleolle,jeremyevans,amatsuda,ko1,junaruga,kddnewton,koic,rhenium,larskanis,ntl,matsadler
...
```

| User             | Merged PRs | Approved PRs | Commits | Total |
|-------------------|------------------|--------------------|-----------|-------|
| deivid-rodriguez  | 100              | 13                 | 1303      | 1416  |
| hsbt              | 58               | 4                  | 392       | 454   |
| simi              | 37               | 100                | 255       | 392   |
| segiddins         | 93               | 77                 | 194       | 364   |
| martinemde        | 49               | 59                 | 64        | 172   |
| duckinator        | 12               | 0                  | 36        | 48    |
| olleolleolle      | 2                | 18                 | 7         | 27    |
| Edouard-chin      | 7                | 0                  | 20        | 27    |
| soda92            | 10               | 0                  | 16        | 26    |
| tangrufus         | 2                | 0                  | 21        | 23    |
| jeromedalbert     | 6                | 0                  | 7         | 13    |
| tenderlove        | 6                | 0                  | 6         | 12    |
| nobu              | 2                | 0                  | 9         | 11    |
| indirect          | 1                | 7                  | 3         | 11    |
| technicalpickles  | 2                | 0                  | 6         | 8     |
| composerinteralia | 2                | 0                  | 2         | 4     |
| MSP-Greg          | 2                | 0                  | 2         | 4     |
| jeremyevans       | 1                | 0                  | 1         | 2     |
| johnnyshields     | 1                | 0                  | 1         | 2     |
| rhenium           | 1                | 0                  | 1         | 2     |
| mame              | 1                | 0                  | 1         | 2     |
| ntkme             | 1                | 0                  | 1         | 2     |
| larskanis         | 1                | 0                  | 1         | 2     |
| ntl               | 1                | 0                  | 1         | 2     |
| ccutrer           | 1                | 0                  | 1         | 2     |
| voxik             | 1                | 0                  | 1         | 2     |
| koic              | 0                | 0                  | 0         | 0     |
| matsadler         | 0                | 0                  | 0         | 0     |
| kddnewton         | 0                | 0                  | 0         | 0     |
| junaruga          | 0                | 0                  | 0         | 0     |
| ko1               | 0                | 0                  | 0         | 0     |
| amatsuda          | 0                | 0                  | 0         | 0     |
| flavorjones       | 0                | 0                  | 0         | 0     |
| byroot            | 0                | 0                  | 0         | 0     |
| Maumagnaguagno    | 0                | 0                  | 0         | 0     |
| nevinera          | 0                | 0                  | 0         | 0     |
| jenshenny         | 0                | 0                  | 0         | 0     |

<details>
<summary>Full <code>brew contributions</code> Output</summary>
<pre>
$ brew contributions --csv --from 2024-08-18 --org=rubygems --user=deivid-rodriguez,hsbt,segiddins,martinemde,simi,duckinator,nobu,tangrufus,Edouard-chin,voxik,soda92,technicalpickles,jenshenny,jeromedalbert,ccutrer,nevinera,indirect,tenderlove,Maumagnaguagno,MSP-Greg,ntkme,mame,byroot,composerinteralia,flavorjones,johnnyshields,olleolleolle,jeremyevans,amatsuda,ko1,junaruga,kddnewton,koic,rhenium,larskanis,ntl,matsadler
deivid-rodriguez contributed >=100 times (merged PR author), 13 times (approved PR reviewer), 1303 times (commit author or committer) and >=1416 times (total) after 2024-08-18.
hsbt contributed 58 times (merged PR author), 4 times (approved PR reviewer), 392 times (commit author or committer) and 454 times (total) after 2024-08-18.
segiddins contributed 93 times (merged PR author), 77 times (approved PR reviewer), 194 times (commit author or committer) and 364 times (total) after 2024-08-18.
martinemde contributed 49 times (merged PR author), 59 times (approved PR reviewer), 64 times (commit author or committer) and 172 times (total) after 2024-08-18.
simi contributed 37 times (merged PR author), >=100 times (approved PR reviewer), 255 times (commit author or committer) and >=392 times (total) after 2024-08-18.
duckinator contributed 12 times (merged PR author), 36 times (commit author or committer) and 48 times (total) after 2024-08-18.
nobu contributed 2 times (merged PR author), 9 times (commit author or committer) and 11 times (total) after 2024-08-18.
tangrufus contributed 2 times (merged PR author), 21 times (commit author or committer) and 23 times (total) after 2024-08-18.
Edouard-chin contributed 7 times (merged PR author), 20 times (commit author or committer) and 27 times (total) after 2024-08-18.
voxik contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
soda92 contributed 10 times (merged PR author), 16 times (commit author or committer) and 26 times (total) after 2024-08-18.
technicalpickles contributed 2 times (merged PR author), 6 times (commit author or committer) and 8 times (total) after 2024-08-18.
jenshenny contributed 0 times (total) after 2024-08-18.
jeromedalbert contributed 6 times (merged PR author), 7 times (commit author or committer) and 13 times (total) after 2024-08-18.
ccutrer contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
nevinera contributed 0 times (total) after 2024-08-18.
indirect contributed 1 time (merged PR author), 7 times (approved PR reviewer), 3 times (commit author or committer) and 11 times (total) after 2024-08-18.
tenderlove contributed 6 times (merged PR author), 6 times (commit author or committer) and 12 times (total) after 2024-08-18.
Maumagnaguagno contributed 0 times (total) after 2024-08-18.
MSP-Greg contributed 2 times (merged PR author), 2 times (commit author or committer) and 4 times (total) after 2024-08-18.
ntkme contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
mame contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
byroot contributed 0 times (total) after 2024-08-18.
composerinteralia contributed 2 times (merged PR author), 2 times (commit author or committer) and 4 times (total) after 2024-08-18.
flavorjones contributed 0 times (total) after 2024-08-18.
johnnyshields contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
olleolleolle contributed 2 times (merged PR author), 18 times (approved PR reviewer), 7 times (commit author or committer) and 27 times (total) after 2024-08-18.
jeremyevans contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
amatsuda contributed 0 times (total) after 2024-08-18.
ko1 contributed 0 times (total) after 2024-08-18.
junaruga contributed 0 times (total) after 2024-08-18.
kddnewton contributed 0 times (total) after 2024-08-18.
koic contributed 0 times (total) after 2024-08-18.
rhenium contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
larskanis contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
ntl contributed 1 time (merged PR author), 1 time (commit author or committer) and 2 times (total) after 2024-08-18.
matsadler contributed 0 times (total) after 2024-08-18.

user,repository,merged_pr_author,approved_pr_review,committer,coauthor,total
deivid-rodriguez,all,100,13,1303,0,1416
hsbt,all,58,4,392,0,454
simi,all,37,100,255,0,392
segiddins,all,93,77,194,0,364
martinemde,all,49,59,64,0,172
duckinator,all,12,0,36,0,48
olleolleolle,all,2,18,7,0,27
Edouard-chin,all,7,0,20,0,27
soda92,all,10,0,16,0,26
tangrufus,all,2,0,21,0,23
jeromedalbert,all,6,0,7,0,13
tenderlove,all,6,0,6,0,12
nobu,all,2,0,9,0,11
indirect,all,1,7,3,0,11
technicalpickles,all,2,0,6,0,8
composerinteralia,all,2,0,2,0,4
MSP-Greg,all,2,0,2,0,4
jeremyevans,all,1,0,1,0,2
johnnyshields,all,1,0,1,0,2
rhenium,all,1,0,1,0,2
mame,all,1,0,1,0,2
ntkme,all,1,0,1,0,2
larskanis,all,1,0,1,0,2
ntl,all,1,0,1,0,2
ccutrer,all,1,0,1,0,2
voxik,all,1,0,1,0,2
koic,all,0,0,0,0,0
matsadler,all,0,0,0,0,0
kddnewton,all,0,0,0,0,0
junaruga,all,0,0,0,0,0
ko1,all,0,0,0,0,0
amatsuda,all,0,0,0,0,0
flavorjones,all,0,0,0,0,0
byroot,all,0,0,0,0,0
Maumagnaguagno,all,0,0,0,0,0
nevinera,all,0,0,0,0,0
jenshenny,all,0,0,0,0,0
</pre>
</details>

---

I'm not going to make any value judgements about these data.
Remember that
[open source maintainers owe you nothing](https://mikemcquaid.com/open-source-maintainers-owe-you-nothing/).

My only observation is that, if I were deciding based on the
[principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege)
for access control in the Homebrew organisation, based only on this data and our process, there would be people in all the groups of:

- appear they should have been removed, were removed
- appear they should have been removed, were not removed
- appear they should not have been removed, were removed
- appear they should not have been removed, were not removed

As
[Homebrew's Governance](https://docs.brew.sh/Homebrew-Governance)
has been cited as a good basis, I "stress tested" it here.
I wanted to contribute data to a conversation that currently lacks it.
That’s not to say who should or shouldn’t be in the RubyGems or any other GitHub organisation.

I wish we had data like
[Homebrew's OpenCollective budget](https://opencollective.com/homebrew?hostname=opencollective.com#category-BUDGET)
to similarly analyse finances, but it doesn't seem to be public.

This situation also highlights how funding and transparency can shape open source dynamics.
[I've long believed that money is not the solution to every problem in open source](https://mikemcquaid.com/open-source-economics/).
In some cases, it can create problems that wouldn't exist otherwise.
