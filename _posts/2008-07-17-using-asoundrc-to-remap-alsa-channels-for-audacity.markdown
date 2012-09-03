---
layout: article
title: Using .asoundrc to remap ALSA channels for Audacity
---
My sound card (a [Creative Sound Blaster Audigy 2](http://en.wikipedia.org/wiki/Sound_Blaster_Audigy)) has got **lots of inputs**, especially with the nice drive bay expansion port.

Unfortunately, the default ALSA device seems to have no way to access the _"Line 2/Mic 2"_ channel on the **front drive-bay expansion** which I use for recording due to it seemingly being the lowest-noise channel.

If you point JACK's _"Input Device"_ to _"hw:0,2"_ then it will pick up the **16 channel inputs** and you can connect them nicely to be able to access this port (channels 9 and 10) in JACK-enabled applications.

I'm currently working on some **voice acting** for [**The Nameless Mod**](http://thenamelessmod.com/editors_choice/) (which is looking like it's going to be spectacular, check it out) and the best program I've found to do this recording in is [Audacity](http://audacity.sourceforge.net/). [Audacity](http://audacity.sourceforge.net/) however seems to **stubbornly refuse** to let me use its JACK support (which is apparently buggy beyond use currently anyway).

I found that if I point [Audacity](http://audacity.sourceforge.net/) to record 16 channels from _"hw:0,2"_ then I can access **all the Audigy's input channels** (as JACK does) but unfortunately this means that every time I record I get all 16 channels (a PortAudio limitation from what I can tell from the source). This isn't ideal as it means, to record a bunch of lines in rapid succession, I need to spend **huge amounts of time** deleting the unwanted 15 other channels. As it's not possible to select the channels to record from [Audacity](http://audacity.sourceforge.net/) I needed to get a little more creative and ended up with this:
{% highlight cl %}
pcm.mic2 {
	type plug
	slave.pcm "hw:0,2"
	slave.channels 16
	ttable.0.8 1
	ttable.1.9 1
	ttable.8.0 1
	ttable.9.1 1
}
{% endhighlight %}

If you add the above to your "~/.[asoundrc](http://www.alsa-project.org/main/index.php/Asoundrc)" or _"/etc/asound.conf"_ then you will find that in Audacity's "Recoding" dropdown you will now have the option _"ALSA: mic2"_. This is simply the same as _"hw:0,2"_ but with the 9th channel swapped with the 1st and the 10th swapped with the second, thus allowing you to select _"2: Stereo"_ or _"1: Mono"_ from the _"Channels"_ dropdown and get the Line/Mic 2 input(s) in Audacity **without the need to constantly delete unwanted tracks**.

**Enjoy!**

_Note: You probably also want to ensure that Audacity records at the Audigy 2's native rate of 48000Hz and use a 16-bit sample format._
