---
title: MinMaxCal
layout: product
body_class: landing-page
permalink: /minmaxcal/
description: A minimal calendar and reminder interface (Min) which pulls you out of flow and into meetings with a full-screen takeover and one-click join (Max).
repository: https://github.com/MikeMcQuaid/MinMaxCal
icon: /images/a/minmaxcal-icon.png
product_colour: blue
minimum_macos: "26"
image: /images/a/minmaxcal.png
image_alt: MinMaxCal's menu bar agenda and full-screen event notification
image_width: 2218
image_height: 1164
image_caption: The menu bar agenda and the full-screen takeover when an event starts.
install_heading: Install MinMaxCal
install_command: brew install minmaxcal
install_note: Allow Calendar access when you open the app. Reminders are optional.
links:
  - label: Discussions
    url: https://github.com/MikeMcQuaid/MinMaxCal/discussions
  - label: AGPLv3 License
    url: https://github.com/MikeMcQuaid/MinMaxCal/blob/main/LICENSE
---

I used the meeting reminder app In Your Face for a few years and was paying £20 for it.
I decided to build a replacement to address a few annoying edge cases such as combining identical events (Fantastical-style).
Within about two hours it was just as good for my usage.
Within two weeks, it was better in every way.
That's [how MinMaxCal started](/vibe-coding-developer-productivity-tools/).

### Stop coding, join meeting

Most of the time MinMaxCal shows only the next event or reminder and a countdown in the menu bar.
Click for today's and tomorrow's agenda.
When an accepted event or reminder is due, the alert fills every display, including full-screen apps.

Join Zoom, Teams, Meet or Jitsi calls from the alert, or press Return to join a call or complete a reminder.
Dismiss the alert or snooze a reminder if you need more time.

Optionally, record a transcript and keep track of how much time you've spent talking in the meeting (I talk too much).

### Zero required configuration

MinMaxCal uses the calendars and reminder lists you already have in macOS.
Choose which ones to show, with duplicate meetings combined and overdue reminders kept visible until completed.
Your Mac's accounts handle syncing, so there's no extra account to create.

Optionally copy events between calendars, keeping the details or showing only Busy or Travel to replace tools like Reclaim.ai if that's all you use them for.

There's also a minimal iOS and watchOS app providing the same simple view of your calendars and reminders on your phone or watch.
