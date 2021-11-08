---
title: Stop requiring specific technology experience for senior-plus engineers
---

A conversation I've had (too) many times in our industry has been the following:
> You: "I'm looking to hire a senior engineer. Know anyone good?"
>
> Me: "Oh great, I know some good people! How about `$A`?"
>
> You: "They won't do. We need someone with at least `$X` years in `$TECHNOLOGY`.
>
> Me: "Why?"
>
> You: "They need to be able to get up to speed quickly."
>
> Me: ☹️

There's many assumptions being made here that may or may not apply in your organisation:

- having written `$TECHNOLOGY` for `$X` years means they will be able to get up to speed with your codebase using `$TECHNOLOGY` because they won't have to learn `$TECHNOLOGY` on the job
- all your existing use of `$TECHNOLOGY` is so perfectly idiomatic that it will be trivial for anyone with `$X` years experience in `$TECHNOLOGY` to understand the code
- the main blocker in getting up to speed quickly will be learning `$TECHNOLOGY` rather than learning your version control system, deployment system, company engineering culture, etc.
- there is a sufficient supply of engineers at least `$X` years in `$TECHNOLOGY` that will want to work at your organisation for the compensation you're willing to pay and loosening these constraints will not get a better hire
- the short-term optimisation for getting up to speed quickly will be a good decision in the medium/long-term

You also may or may not have thought about the following:

- much of the job of a senior-plus engineer involves tasks unrelated to writing `$TECHNOLOGY` e.g. databases, on-call, deployment, mentoring, breaking down issues, collaborating with management/product/design/sales etc.
- engineers who already know more than one programming language can often pick up new ones extremely quickly
- experience with multiple programming languages/paradigms can often make engineer better at writing all languages
- your choice of `$TECHNOLOGY` may not be the best fit for the problem and an engineer with experience in other languages may help you consider future alternatives
- you may not be using `$TECHNOLOGY` in the medium/long-term
- `$TECHNOLOGY` may not be something that many people have `$X` years experience of (but are willing to learn)

In my experience, the combination of those assumptions and missing thoughts mean that I consider it to be an anti-pattern to require this language experience from engineers. By all means factor it into a decision: given two otherwise identical candidates the one with more experience in this language may be more desirable.

If you remove this as a "requirement" and replace it with a "positive trait" (or remove it entirely) you will find yourself able to get more, better candidates into your hiring pipeline (particularly from underrepresented groups in technology that will often not bother to apply when they don't meet "requirements").

This may require changing your interview process. If the majority (or entirety) of your process assumes working familiarity in a given language and you expect the candidate to be able to write that language without any help: the candidate and interviewer are going to have a terrible experience. Ideally, your process allows the candidate to bring a language they are comfortable with and/or is an "open book" pairing process on the technology you use internally. Additionally, the more experienced the candidate or more senior the position: the more of the interview process should be dedicated to communication, engineering best practises, architecture, etc. rather than just programming.

This can be a hard adjustment to make but it's one the best engineering interviewers made years ago and you can too.

---

By "a senior-plus experience" I mean e.g. senior, staff, principal engineers etc. Never heard of staff or principal engineers? Check out [my "What is a Staff (or Staff-Plus or Principal) Engineer?" article]({{ '/2021/10/01/what-is-a-staff-plus-principal-engineer/' | absolute_url }}) .
