---
layout: post
title: IBM Cell SDK/SDK for Multicore Acceleration on Debian/Ubuntu HOWTO
---
Today I battled with trying to get **IBM's Cell SDK 3.0** _(now known as the **SDK for Multicore Acceleration**)_ installed on my Debian AMD64 machine. This would cause slight grief even with a regular Debian machine as IBM only formally supports Fedora and RHEL so only provides RPMs. This is worsened by the fact that **a bunch of the packages aren't even available from IBM** but require perusal of some provided yum configuration files to find.

Firstly I recommend you download the **CellSDK-Devel-Fedora\_3.0.0.1.0.iso** and **CellSDK-Extras-Fedora\_3.0.0.1.0.iso** (*current at time of writing*) from [here](http://www.ibm.com/developerworks/power/cell/pkgdownloads.html?S_TACT=105AGX16).

Then when you have downloaded them mount them somewhere on your filesystem.
{% highlight bash %}
mount -o loop $HOME/CellSDK-Devel-Fedora_3.0.0.1.0.iso \
	/tmp/CellSDK-Devel-Fedora/
mount -o loop $HOME/CellSDK-Extras-Fedora_3.0.0.1.0.iso \
	/tmp/CellSDK-Extras-Fedora/
{% endhighlight %}
We've downloaded the two RPMs by IBM. If you install these on Fedora they will provide you with some **yum repositories for the Barcelona Supercomputing Centre**. These will need to be downloaded manually as we aren't on a RPM-based system.

If you are running **Ubuntu Gutsy on x86_64 or x86** run:
{% highlight bash %}
apt-get install ppu-gcc ppu-gdb spu-g++ \
	spu-gdb cell-programming-primer
{% endhighlight %}
If you are running **Ubuntu Gutsy on the Cell** run:
{% highlight bash %}
apt-get install cell-sdk
{% endhighlight %}
**Otherwise run the following:**
{% highlight bash %}
apt-get install wget #Install wget if it is not already
mkdir openrpm
cd openrpm
wget -l 1 -c -np -nd -r http://www.bsc.es/projects/deepcomputing/linuxoncell/cellsimulator/ -A .rpm
{% endhighlight %}
The above assumes you are on an x86\_64 machine. If you are using the Cell, a regular x86 or a PPC 64-bit machine change the **'x86_64'** to **'cbea'**, **'x86'** or **'ppc64'** accordingly.

**The following instructions apply regardless of your Debian/Ubuntu variant or architecture.**

Next, if we are on **x86_64**, we want to create a nice little script to handily convert the i386 architecture files to amd64 so they will install nicely when we convert them to debs. This is safe as all the stuff these packages install gets chucked into /opt/.

I recommend we name it _"fixcelldebsarch.sh"_ and stick it in your $HOME. This is only necessary if you are on **x86\_64 not x86** and _(probably)_ won't work on the Cell or another PPC64.
{% highlight bash %}
#!/bin/bash
#~/fixcelldebsarch.sh
OWD=`pwd`
for i in `ls -d */`
do
	cd $i
	sed -ie 's/Architecture: i386/Architecture: amd64/' \
		debian/control
	dpkg-buildpackage
	cd "$OWD"
	rm -r */ *.gz *.changes *.dsc
done
{% endhighlight %}
_(Thanks to Jon for the fix to avoid mess when using symbolic links.)_

Next we want to convert the various RPMs into DEBs for our Debian system so the dependencies are nicely handled and they can be uninstalled. Install the **'alien'** package if you have not already.

On the following lines replace the occurrences of '/**x86_64**/' with '/**cbea**/', '/**x86**/' or '/**ppc64**/' using the same criteria as above.
 {% highlight bash %}
cd open
for i in ../openrpm/*.rpm
	do alien --scripts $i
done
~/fixcelldebsarch.sh #Only needed on x86_64
dpkg -i *.deb

cd devel
for i in /tmp/CellSDK-Devel-Fedora/x86_64/*.rpm
	do alien --scripts $i
done
~/fixcelldebsarch.sh #Only needed on x86_64
dpkg -i *.deb

cd extras
for i in /tmp/CellSDK-Extras-Fedora/x86_64/*.rpm
	do alien --scripts $i
done
~/fixcelldebsarch.sh #Only needed on x86_64
dpkg -i *.deb
{% endhighlight %}
It should have been fairly obvious what was going on above. **This should have installed all the necessary packages for the Cell SD**K without breaking your system and allowing Debian/Ubuntu packages to override these versions.

I hope this all works; if anyone spots any typos, has any suggestions or needs any help then give me a shout!

**Updated: Added Gutsy information. Thanks Bart!**
