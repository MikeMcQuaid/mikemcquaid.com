---
layout: post
slug: konqueror-with-latest-adobe-flash-howto
title: Konqueror with latest Adobe Flash HOWTO (Outdated)
---
**This page is outdated. In KDE4 Konqueror will work with the latest Adobe Flash plugin and there is now [a 64-bit version of Flash available for Linux](http://get.adobe.com/flashplayer/). I highly recommend you use one of these instead of the guide below but I'm leaving it here in case you need to use it for another reason.**

I agree with Lubos. [Flash sucks.](http://blogs.kde.org/node/3162) However, most of us _have_ or _want_ to use it for things like YouTube or [watching badgers](http://www.weebls-stuff.com/songs/badgers/).

As you may be aware the latest versions of Flash depend on **XEmbed** support which Konqueror lacks without various patches to KDELibs and KDEBase which haven't been applied by my distribution and **I couldn't get working** even when I manually patched the necessary parts of KDE myself. I was using the older versions but it appears they have [outstanding](http://www.adobe.com/support/security/bulletins/apsb07-20.html) and actively exploited security holes that they have only fixed in the XEmbed-supporting versions.

Mike needs his **YouTube** fix without haxors running rife on his box. Who can save him?

**[KMPlayer](http://www.kde.org/applications/multimedia/kmplayer/) to the rescue!**

KMPlayer is my media player of choice as it allows you to trivially switch between **XINE**, **MPlayer** and **GStreamer** backends and, as of version 0.10.0, has a nifty backend that allows you to use XEmbed-supporting plugins, including Adobe's Flash plugin, which can then be embedded in Konqueror to allow Flash to work trivially.

**HOWTO:**

1. **Install KMPlayer** (version 0.10.0c or higher). It is included in all the major distributions I've ever used. Ensure it is installed/compiled with the _"NPP"_ backend enabled which allows the playback of Netscape XEmbed plugins (this depends on your distribution).
2. **Run KMPlayer** so it creates its config file. Close it. _(This step probably isn't necessary but it won't do any harm)_
3. **Run** the following commands:
{% highlight bash %}
		kwriteconfig --file kmplayerrc \
			--group "application/x-shockwave-flash" \
			--key player npp
{% endhighlight %}
{% highlight bash %}
		kwriteconfig --file kmplayerrc \
			--group "application/x-shockwave-flash" \
			--key plugin /usr/lib/flashplugin-nonfree/libflashplayer.so
{% endhighlight %}
4. **Change** the _"libflashplayer.so"_ section depending on where the Adobe Flash plugin was installed on your distribution. The above example is where it is installed on Gentoo. _(People have replied below with where it is stored on various systems. If you can't find yours, you probably have a **locate** program installed so trying running "locate libflashplayer.so" for an idea)_.
5. **Open Konqueror** and click _"Settings > Configure Konqueror..."_. In the new window navigate to _"File Associations"_ in the left-hand panel and select **_"application/x-shockwave-flash"_**. Click the _"Embedding"_ tab and click _"Add..."_. Select _"Embedded MPlayer for KDE"_ from the new window. If it is not there then you may need to restart KDE or run _"kbuildsycoca"_ from a terminal. Close all the opened windows.
6. **Enjoy** a working Flash in Konqueror!

What is wrong? You're running a **x86_64 machine** _(like me)_ so the above doesn't work? Never fear! If you manage to get a 32-bit version of **_"knpplayer"_** _(the small program that runs the plugins)_ and install that in your **$PATH** before the 64-bit version then it will all just work like magic! Note that you'll need 32-bit versions of the various dependent libraries also _(it seems just to be GTK, Cairo, X11 and DBus stuff)_.
