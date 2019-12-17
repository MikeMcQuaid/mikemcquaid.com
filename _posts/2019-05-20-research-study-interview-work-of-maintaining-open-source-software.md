---
title: "Research Study Interview: The Work of Maintaining Open Source Software"
---

I was recently interviewed as part of a research study into the work of maintaining open-source software. I asked if I could make the (lightly edited) transcript public and they agreed. This will be an interesting read for anyone interested in some of the deeper questions about maintaining a project like Homebrew for 10 years.

---

> What are the open source projects that you regularly contribute to?

The main one would be a project called Homebrew: it's a Mac package manager. And then, there's some projects of my own, such as one called [Strap](https://github.com/MikeMcQuaid/strap), that's probably the most like widely used one created by me. And other kind of random bits and pieces periodically.

> How often do you work on those?

Homebrew - I work on basically every day. And then, the Strap probably once a week, or a couple times a month. And then the rest... again, when it comes down to it, it just varies a lot.

> Every day?

Yeah, for Homebrew, every day, pretty much.

> How long would you say per day that you work on Homebrew?

Probably zero to two hours.

> Wow. Have you ever been paid to contribute?

Not to the Homebrew project. I have been paid for open source work in the past. And not specifically, it wasn't framed like that, where someone was like, “Hey would you like to contribute this thing for money?” But it's been, during the course of my employment, I needed to contribute.

Indirectly, I guess I have contributed to Homebrew in that way, and so yeah, indirectly, through my employer, I've needed to make changes in Homebrew while being paid.

> Right. If you had to say what tasks you were paid to do for Homebrew, or for an open source project?

I guess feature development and bug fixing.

> Moving on from that. In your best estimate, how many people would you say actively contribute to Homebrew? So yeah, how many people would you say actively contribute to Homebrew in some way?

We've had over seven thousand people, like at all, ever. On a given month, you're probably talking hundreds of people.

> How many people contribute at the same level that you contribute?

That's a tricky one. So I'm the project lead now, and in that respect, probably no one. In terms of the amount of time they spend on it, and I spend on it, over a longer a period, on a day-to-day basis it's kind of hard to know in terms of time people spend because you just see the artefacts.

Again, there's probably tens of people who are spending more than an hour a week, I would say. Less than a hundred, more than 10.

> What kind of work do you generally do?

I do a bit of everything, from feature development, bug fixing, triaging, user issues, helping, helping users figure out solutions to their problems, as well as kind of system administration tasks, and then like some documentation. Also what's almost like people management - directing what people could or should be working on. A certain amount of mentorship probably, as well.

> Is there work that you do that you think you're one of the only ones that does that particular task?

Yes, yes. There's quite a few, unfortunately, where I'm the only person.

> What do you mean by that?

For example, today, to be very specific, we have an automated testing system that we run ourselves. Because none of the stuff available for free or at the market works for our needs, yet. I'm mostly the main person who's kind of set that up, and knows how it works. So when it breaks, it's generally me that is involved with fixing that. And so, if I was hit by a bus, people would maybe eventually learn how to fix that, but it would probably be a little bit difficult for people to get there.

But yeah, on a day-to-day basis, when stuff like that breaks, it's generally me who fixes it.

> Okay. I'm curious - what do you think that means - to be able to do a task that no one else in the project is working on?

Sure. I guess it simultaneously feels good, and feels bad in that it's nice to feel valued, and important, and whatever. But then, at the same time, it doesn't particularly bode well for the future, which is why, with tasks like that, we're trying to sort of either eliminate the task, or figure out how to get more people involved in stuff like that.

Because, obviously, it doesn't work very well if something happens to me. I also have one, and soon to be two small children. So they occupy significantly more of my time than I'm able to spend doing stuff like this.

Historically, I have the Homebrew chat application on my phone, and if someone sent me a message saying something was broken, I'd pretty much drop what I was doing, and go, and fix it. And I don't do that anymore, because it interferes with family life. So yeah, it's tricky.

> Alright. It sounds like you're doing a lot of really good work for this project.

Thank you.

> That is very heavily relied on by many people.

Yes. Again, which is simultaneously a nice, and not-nice thing.

> One of the ways some are starting to frame open source projects is as, infrastructure. How would you respond to that term?

Yeah. If you've been at all inspired by [Nadia Eghbal](https://nadiaeghbal.com), her and I used to work in the same team together. I would very much agree with that description of open source infrastructure. Particularly certain things feel more "infrastructurey" than others. And some open source stuff is very like a product, and it just so happens to be open source. And then some stuff - Homebrew would be an example - where it's being used primarily, if not exclusively, by developers in order to build other software. So that description feels apt, because it's not being used for it's own sake, but in order to help for something else.

> Like a stepping stone?

Yeah.

> I wanted to ask a question that I should have asked earlier, which was if you have a formalised role in the project?

Yep. So I'm the "project leader"; that's my official project title. And on that we've added a bit more governance and structure. So as of this year that was an elected position, which I was elected to. And I'm also on the project leadership committee and the technical steering committee. The reason why is I guess having formal roles is part of being a maintainer for the project.

> How did you get those roles?

All of those roles are now, as of February, elected positions. So I was elected to each of those roles.

> How do they have elections?

So we've only done one so far. So basically we had and are going to have in the future a annual general meeting. I can send you, if you're interested in some of it, we have all written up basically how the governance process all works.

> That'd be great, yeah.

See: [Homebrew Governance](https://docs.brew.sh/Homebrew-Governance).

> Okay. So I wanted to talk more specifically about some of the work that you do. First, how do you decide what you spend your time contributing to?

It's a combination of what I find interesting or fun and what I find important and things that I think only I can do. So things may lean more in one direction or another. Ideally it is something which is in all three of those categories, but then if it's something where I know a bunch of other people can do it, but I quite want to and I'll find it entertaining to do that, then I may well do it. And in a similar way, there's a bunch of stuff that, I mentioned earlier, which only I can really do at the moment and I would rather I didn't have to do that stuff. My day job is pretty far from that and no one else can do it right now, so I kinda have to.

> How would you say the immediacy of needing to fix things plays into that?

Yeah, good question. I think that certainly defines what I choose to work on. This particular issue we had today, for example, I have kind of a longer-term project to try and replace this stuff. But then a bunch of higher priority things keep getting inserted above there in my to-do list. So it becomes harder to get around to that. So I'm probably going to, in the next month or so, take like a week's vacation and just try and focus just on doing this and nothing else, so I can get it off my plate before my child is born.

> So let's see. What has been a difficulty of contributing?

The stuff that's probably hardest is just dealing with people. The software side of things generally, is relatively easy. I mean even the stuff I don't really want to do, I can just do it and it's fine. But then you know, sometimes people are conflict adverse or conflict happy or rude or entitled or whatever it may be, and that kind of ends up being problematic. I guess in the past few years, like a lot of human relationships, the most troubling ones are when there's actually a closeness there.

So although if get kind of abusive comments and it's someone you've never talked to before, then that's fine. Whereas we've kind of had conflicts between some maintainers and various allegations that get made and things like that. And like the lines start to blur a bit between. I guess it's almost like in a workplace, where you have people who you work alongside, but then they're asking you to kind of help out and intervene in their personal life and stuff like that, and you do that, but that ends up causing issues and this sort of thing.

> You said you have governance policies, do those extend to this kind of thing.

Yeah so we have a code of conduct document as well which sort of defines the high level behaviour that is expected of people. That basically is what makes it - particularly with, random individuals you have no contact with - if their opening comment on the project is one that is racist or sexist or whatever it may be - then that makes it very easy to be like well we said this, you were pointed to this to get involved in the project, therefore you get blocked from the project or whatever it may be.

We do have guidelines for how maintainers shouldn't talk to each other, but obviously those lines are a bit more blurry. Even culturally, when you work with people from the U.K. and the U.S. and Russia and China and places, what is considered respectful or rude or polite or helpful - typically when most of your communication is textual is quite broad and open to interpretation - it's kind of tricky.

> So it sounds like people have worked on easing the difficulty of when things come up in the social side of the project, and try to make it a good environment?

Yeah I think so. Yeah that's fair.

> What tools do you use to work on, or to contribute to Homebrew? And I'm using tools in a really broad sense.

Yeah, cool. So [GitHub](https://github.com) and the products that it's hosted by. I use that pretty heavily. I use [Git](https://git-scm.com) the version control system and I use [Visual Studio Code](https://code.visualstudio.com). Currently it's my text editor of choice and then I use a plethora of other open source tools to do bits and pieces here and there. Those initial three would be the main three things that I use.

> You mentioned using open source tools. What is your relationship with open source, itself? Some treat it as political, some might treat it pragmatically in terms of development, etc. There are different perspectives on what it means. I'm just curious how you relate to open source?

Yeah, so for me it's partly a pragmatic thing. Working as a professional software developer, it makes life easier working with open source software than with closed source software in general. Because when I have problems I can peak underneath the hood and make modifications and such. I guess the ideological part, I used to maybe be more into.

I still think that ultimately if I could choose between most software being open source or not... if I'm picking between a tool that I'm going to use, for example, my text editor, I prioritise using an open source, maybe slightly inferior text editor where a closed source may be a slightly better one. But it would not be completely overruled if there was one that was vastly better, than closed source or vastly inferior, whatever it may be. And yeah, I generally see - in terms of my personal contributions - I generally see open source as being a kind of very, minimal sort of charitable work. I don't think it's the same as volunteering at a homeless shelter or whatever. I feel like that's a lot more worthy. But I feel like it's not net negative and it's probably very slightly above net-neutral for the world.

Particularly the project I work on. For it to be useful - well I guess we've opened up a little more - but historically, for it to be useful you need to be using a Mac, and that's a subset of the world and a relatively privileged subset at that. I see it as being positive, but not overwhelmingly so in that respect. Open source in general, I feel, is a valuable, positive contribution that has levelled the playing field. Organisations, individuals and companies with different levels of money now don't have vastly different tools, as a lot of them are now sharing the same playing field, in terms of their open source tooling.

> How did you decide on which license to put on Homebrew?

So I'm not the original creator of the project. The original creator, - well, I'm not 100% sure why, but I could speak to other projects in which I've ended up using the same or a very similar license. Broadly I see there being a couple of main camps. You've got the copyleft camp of free software people, who generally want everything to be open source and they want to try and use their software as a means to accomplish that end, so they ensure their software is not used in closed source software. It forces closed source software to become free or open source software, in theory at least.

And then the permissive license camp, which I'm probably more at, which is the if you build something you don't really care where it's used. It's more about it just being useful and you would like it to be able to be adopted by as many people and as may organisations as possible. So, I'm probably more in the latter camp for most things I build. But I choose on a project by project basis. Like, if a large company took this code and did something with it and made money off it, would I care or would I see that as being a good thing or a bad thing or whatever. And if I would see that as being a bad thing, I would maybe go for a copyleft license, and if I see that as being a good thing I would go for a more permissive license.

> Okay. I want to go back to the pace of contribution. Have you ever been a regular contributor to a project, a open source project, but then stopped contributing? Could be Homebrew, could be something else.

Yeah I guess there have be a few other projects I worked on and stopped. And I guess there's parts of Homebrew that I mostly don't contribute to anymore.

> Can you tell me about that? Why you might have stopped doing something and started doing something else? Or dropped an aspect of participation?

I guess it's generally a factor of where I'm not really using the tool anymore. And what generally, pretty much all the open source projects that I ever contributed to, I'm using them at work or for some hobby project or whatever it may be. And I'll generally contribute so long as that remains the case and I may get involved with the project for a while, while I do that. But then generally, when it comes to an end, for example might move jobs and I'm no longer using a particular technology anymore. Then my work on that will generally dry up as I don't have the either desire, or some cases, the ability to contribute to that in an effective way.

> Do you talk about aspects of retention in the project? I've heard that word thrown around in different spaces.

Yeah, we've talked about that a bit. So, my little concept that I've written and talked about is: I think that it's like a kind of funnel. A bit likes a sales funnel, a kind of [contributor funnel](https://mikemcquaid.com/2018/08/14/the-open-source-contributor-funnel-why-people-dont-contribute-to-your-open-source-project/). With the idea being; every user is a potential contributor. Or every contributor is a potential maintainer. But then, for each level you go down the funnel, you get a fairly major kind of drop off.

So using that for retention and onboarding is sort of similar in that you're trying to sort a bunch of people in the right directions and give them stuff to do. I guess in a retention case, for maintainers and contributors, if someone comes and just tries to solve some problems themselves, then it's seeing if you can find other things that they could usefully get involved with and solve. I mean, ideally stuff which is going to be beneficial to them as well. But even if it's not directly beneficial to them maybe you can find something that they find fun or interesting or whatever it may be, and that's generally quite helpful in getting them to stick around.

> That's an interesting idea that any user is a potential maintainer. Where do you get that from?

I guess it was my own observation. And it's just that I've been involved with Homebrew for about ten years now, and seeing more and more people get involved, you realise that people often need to be slightly nudged to get more involved. And again, when people become maintainers on a certain project, they're generally always asked. It's very, I mean I literally don't think we've ever had someone who has explicitly said, "I would like to be a maintainer, how do I do that?"

It's generally always people who - you have to ask them and often they will say, "no", because they feel that they are not competent enough, experienced enough, whatever it may be, and you have to try and talk them around and be like, "no, you're doing enough valuable work". So that's the side of it we've seen. And also, the user side, in terms of getting people to contribute, it's often just a matter of making it as easy as possible for people to do what they want.

If stuff is well documented, if you have good tools, good processes in place, and if it's easy enough for them to do that, then they can do. I guess our project is slightly different, compared to, say, Firefox, as not ever user is a potential contributor, because you have enough people who can't write code, or people who just have less interest in that way using the project. Whereas the vast majority of Homebrew users are developers in some form.

> Right.

Particularly when our bug tracker is on GitHub then it's easier - if someone is signed up already for a GitHub account - to create an issue, then they have, already got most of the steps out of the way required for them to make a change and send that back to us.

> You said when you might ask someone to be a maintainer if they were already doing a lot of work for the project. What does it mean to be a maintainer?

Yeah, so again it's one of these things that we've written up a bunch of stuff around [on our documentation site](https://docs.brew.sh). Like we try and write out all the kind of guides to, like what is a maintainer, what are expectations, what are the expectations of contributors, etc. But for us, I guess the definition of a maintainer would be someone who is spending more time shepherding other people's contributions than contributing themselves. Then, from a logistical perspective, a maintainer is someone who has access to the repository.

So when someone is submitting a change to the repository they need a maintainer to accept and merge the change for it to be included in the repository in the software. So, logistically, a big part of that job should be facilitating those changes. Because, if all you're doing is making changes and getting someone else to merge your change, or whatever it may be, then arguably you're not really adding much as a maintainer in that way.

> Okay. That's helpful. I wanted to ask how your work changes around release cycles. Is there different kind of tone to your work at that time? Is there a different community that happens there?

Yeah So we have fairly loose release cycles in that we do quite a lot of regular releases without any particular kind of timing or anything like that. And it's generally just whatever is ready at the time - let's just release it. So things don't really change particularly from that perspective. When we do a more major release, if we have big changes that are kind of disruptive, we'll try and clump them together at that time. I guess that's probably all it is for us really.

> Okay. So I guess I just wanted to ask a little bit more your experience in the project. I asked before have you ever stopped contributing to a space and to a project and you mentioned shifting your focus. Has there been any other projects that you started or stopped?

So there's been none, I guess, started that have been still active that I've walked away from. There's been some that I sort of started and a few people used them, but then they stopped being used by other people so then I walked away. A main example of one I guess I have been involved with in the past but then kind of walked away from is the [KDE project](https://kde.org), a desktop Linux environment. So I worked on that for a few years but then in their case [I stopped using Linux](https://mikemcquaid.com/2010/09/21/why-i-left-linux/). So that was the main thing was I just wasn't really using it anymore. And I had been involved with it partly through some work stuff as well. But again even then, when I changed jobs then the work stuff I was doing completely stopped on top of that. So basically like no interaction between me and the project anymore.

> Okay. I wanted to ask, do you feel like you get recognised for the work that you do on Homebrew?

Yeah, no, I mean I guess so. I mean in my local tech scene in Scotland, if I am speaking at a conference people may know in advance that I am the Homebrew person that's in Edinburgh if they use Homebrew already. And from doing talks and all that people may have seen me speak about Homebrew and things. But that would be the main stuff. And then, when I've applied for jobs before, then if Homebrew is part of my resume then that has kind of helped me get jobs probably in the past.

> So you said you get recognised from speaking as well. Is that something you've done much of?

Yeah, I do a [reasonable amount of public speaking](https://mikemcquaid.com/talks/). Partly through work and then partly just through my involvement in the tech scene.

> What do you think is the role of conferences in the community?

So I think they're kind of a good way for people to get to meet other people who are working on similar things. So, for example, our Homebrew meeting we had where we did all those votes, we did that at a conference. Like the day afterwards so everyone could attend the conference and stuff like that, that was the [FOSDEM conference](https://archive.fosdem.org/2019/) in Belgium. So I think they are good ways of getting people together and I've worked from home for ten years as well, so it feels kind of similar to, in my job as well, when I feel like when people have met face to face and actually had social interaction they generally work better. They cut each other more slack and they've got more of a relationship in general and that's a positive thing.

> Do you have relationships with people in the project that extend past your collaboration on a more technical side of things?

Yeah. I guess not really. There's people who I would consider borderline acquaintances, friends, whatever. We have a private slack and stuff like that, so when my kid's born I'll tell people and people will say congratulations and stuff like that. But there's not anyone in the project who I would say I'm having difficulties with my marriage or a stressful time at work: what should I do? There's no one who I have friendships with in that way.

> Okay. I asked you if you feel you get recognised for the work you do. When you do good work on a project, who sees it or who knows?

I guess the main people who notice and know things are the other maintainers in the project. If I fix an issue for a particular user then they may well notice that and recognise that and say thanks or whatever it may be. But if it's, say some new feature that's added, a lot of people find makes things easier, then generally people don't track the individual feature back to the individual who created it, to the same extent. Whereas the maintainers who are paying a bit more attention to the project may well be the ones who do notice that. If they're reviewing pull requests and stuff like that. I guess they see changes attached to people's names and therefore that may mean if they use the feature then they say, "Thank you - This will save me time." Or whatever it may be.

> How do you think that Git or GitHub affects what gets noticed or what work gets noticed?

I guess it's that people don't have a reason to interact with the GitHub project, generally, for positive reasons unless they're submitting code. So generally people will create issues for problems they are having. Whereas generally people do not go, and - I'm the same with the projects I use, if someone adds some new feature and I think is amazing I generally don't have the inclination to go and investigate who did that? Why did they do it? How do I say thank you? whatever. Occasionally I will do that if it's something super dramatic where notice and it gets tweeted about and they say, "This person built this thing." And it pops up and I see that then I'll say, "Thanks," then personally. But generally you don't go digging to the same extent.

And when you use probably 40, 50 different pieces of software every single day, it's kind of hard to keep track of what's been done by whom and when and why and all that type of thing.

> It's interesting an interesting feature of interactions that people tend to thank less but when something goes wrong they notice that. What kinds of issues do you have to deal with in the project that others might not see?

I guess interpersonal issues between maintainers would be probably the main thing. So when you deal with stuff like that people maybe don't see and don't think about it. The continuous integration stuff I mentioned earlier, the testing machines, I think when you fix things that don't have a GitHub audit trail, even if you were to go looking. So people are unaware that that work gets done.

And most of the stuff around softer skills, like making talks for the project, whatever it may be. Stuff that doesn't end up packaged in software itself and doesn't really get noticed to the same extent.

> Okay. I was going to ask - what kinds of interactions happen on other platforms of communication like a mailing list? It sounds like you have a Slack?

Yeah. We do have some mailing lists, but they aren't used very widely. They're basically only used for things that have to be on email for whatever reason. So our communication between the team is either on GitHub, we try and do as much as possible as we can in public, and then stuff that either has to be private or is a bit more chatty or not relevant to people outside of the maintainers, so then that might be a message in Slack. So we might say the CI server seems to be broken or whatever, that might be a message in Slack. Or equally someone saying, "I've got a new job." Or whatever it may be, little bits of chit chat as well.

> And does anyone moderate those conversations or, what would you say is the sort of tone? Sounds like sort of a mix, there's just really technical stuff and chit chat.

Yeah, so I would probably be the main person who's doing the moderation. Moderation hasn't felt like it's been a problem for quite a while. We had people in the past who would speak to each other, both on Slack and on GitHub, including maintainers, who'd speak with unkind, sort of aggressive or passive aggressive language. But, that required a bit of nudging to convince people to stop doing that, which wasn't always successful.

I mean now it seems to be pretty normal to just have pleasant, normal conversations. My goal is generally to try and have our interactions be like the workplace where things that you would consider appropriate to talk to a coworker about, you would consider appropriate to tell us or not and vice versa. Equally because we're not all best friends. There's stuff that you probably want to save for your conversations with your best friends and leave outside of Slack. And that goes to the code of conduct sort of stuff as well. If you have strong political opinions or whatever it may be, even if most of us maybe agree on certain things, it's better to just keep that stuff separate, because you don't know who's going to be privately offended by things.

> Right. It sounds like the culture has changed? Like the tone of the conversation has changed over time?

Yeah, I think so.

> With the kinds of governance structures that have been in place?.

Yeah I think so. It's sort of interesting because we, in our case, what predated me being an elected project lead was me appointing myself as the lead maintainer more or less because there was stuff that wasn't getting done that I was doing pretty much all the kind of leadership of the project stuff myself. And I asked if they thought it would be reasonable for me to just appoint myself. And a few people said yes and some people said no. But then I just kind of decided to do it anyway.

And that ended up being, I think, the right thing to do, but it ended up obviously causing conflict. Because some people felt that there was a dictatorship or whatever, you could say. But I think that the tricky thing with open source is that it's always a kind of balance because it's not a company environment. You can tell people what they can't do, but you can't ever tell anyone what they should be doing, or must be doing or whatever it may be. Because you don't dictate how people spend their time and you don't have any way of "firing" people beyond just saying, "Well you can't be a maintainer anymore."

> Do you think the word volunteer accurately gets what people do when they contribute to an open source?

Yeah I think so. I think, if they are volunteering and they aren't doing that as a somewhat integral part of their employment, I feel like that's a fair description. I guess there are people, even in Homebrew, for example, for whom their interactions with a project may be, at some times for, not in Homebrew's case never all the time, but in a purely professional capacity.

So in those cases I wouldn't class them as volunteers to the same extent when they're doing that. But yeah I think in general that's what people are doing. And in general you have the same, it feels like a similar obligation to like in person volunteering, in that no one can make you do things or not make you do things. But if you sign up for some volunteering thing at a soup kitchen or whatever, and then you just don't turn up, then that's seen as being a rude thing to do, regardless of the fact that no one can compel you to do it. But at the same time there's some degree of social contract when you've agreed to do things.

I feel it's somewhat similar with open source in that there's an implicit agreement that you will clean up your own mess if you make a change and it caused a lot of issues for people then it's probably mostly on you to try and sort that out. Or at least back out of your change or whatever it may be.

> Framing it as a sort of social contract, it's interesting. I asked what has been a difficulty this project. What do you think have been some of the rewards or the more nourishing aspects?

I guess the rewarding stuff is both intrinsic and extrinsic in that, I don't think I would have probably got the job I have now had I not done any contribution to open source ever. And I like my job I have right now and I'm well compensated and it's enjoyable. So that's one aspect of it.

And more intrinsic stuff is - it's a nice, fun hobby that is beneficial to other people at the same time as it's enjoyable to me. And that's a kind of nice double combination. The other thing is just that it's a place where I've learned a lot of things and continue to learn. And I can experiment and there's a degree of just satisfaction in the way that you can do development with open source. It's, I would imagine, in some degree similar to the freedom that people describe as entrepreneurs, or whatever it may be. Where "no one can tell me what to do." And "if I don't like a particular way of doing something I can change it or I can justify why I think things should be changed," and whatever it may be. So yeah that would be the main summation of what I have found valuable.

> Where do you think that you'll be with this project in say five or ten years?

Yeah, good question. I'm not sure. I would hope that in two years, I would hope that I'm still involved in a diminished capacity. So not even necessarily time diminishment maybe. And I would hope that in five or ten years that I'm not project lead anymore and there is someone else who is doing that job better than I could be doing it at the time. So I'm not sure. I'm not sure whether the project will continue to meaningfully exist in that period of time, stuff like that as well. It's all quite hard to predict.

> Where do you think the project will be as an infrastructure in terms of its use and how it looks and works?

Yeah in five or ten years... so because we're primarily an Apple operating system tool, so much of what we do depends on the direction that Apple ends up going in. So Apple could release software that effectively ends up replacing us. And then I would probably abandon what I'm working on. Like Homebrew and trying work on the Apple thing or use that instead or whatever it may be.

But I think, I don't know, I feel like the project will probably, in five years at least, assuming MacBooks remain similarly used for development as they do today, I think like Homebrew will continue to exist in some form and will still be used by people. I would imagine we will have figured out how to get rid of more of the bits of the project, like the testing stuff I mentioned earlier. Like figure out how to outsource that to other organisations who do it better than we can. And we are able to do more of the fun bits and less of the boring bits.

> Has Apple ever directly reached out to Homebrew?

Yeah so we have some contacts with folks at Apple. It's mainly on an individual basis and we don't have like a big, official corporate relationship manager, anything like that. That would be very nice and useful. Because we often get slightly blindsided by a change they make, sometimes when the apps change we have to scramble around, and stuff like that. So we have a somewhat open communication channel, but not a widely used one.

> This is probably my last question, which is a hypothetical question. What do you think would happen if tomorrow Homebrew was gone?

There are alternatives to Homebrew like [MacPorts](https://www.macports.org). So I reckon there would be a lot of grumbling and crying on the internet. But then, people would probably just migrate to a bunch would migrate to a tool like MacPorts, like another project that does solve similar problems in similar ways. And then a bunch of people would probably build their own equivalents or their own versions of something similar. And perhaps one of them would become popular enough to be widely used and perhaps not. I don't know. Remains to be seen.

> Okay. Well this was really helpful and interesting. I've used Homebrew myself and it's really interesting to hear more behind the scenes aspect of it. Also its ubiquity and having a specific place in people's workflows and that kind of thing... before contacting you I hadn't thought a lot about who's behind this.

Yeah, thanks!
