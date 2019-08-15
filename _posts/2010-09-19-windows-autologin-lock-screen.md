---
redirect_from:
  - /2010/09/windows-autologin-lock-screen/
---
Something I miss when I used Windows is the nice autologin feature from KDE's login manager (KDM). Autologin always struck me as a bit insecure; why have a password if you are going to bypass it completely? KDM's solution was pretty nice, it allowed you to be logged in automatically (so that everything that runs on startup started loading) and lock the desktop before it appeared so that when you turned on your computer you would still get a password prompt but would unlock it to find that all your applications had already loaded.

I've managed to emulate this functionality in Windows by using the login scripts. This script should work in Windows 2000 or any later version but the setup instructions may vary.

* Create a file named LockWorkStation.vbs with the contents:
{% highlight vbnet %}
WScript.CreateObject("WScript.Shell").Run(_
  "rundll32 user32.dll,LockWorkStation")
{% endhighlight %}

* Access the hidden Advanced Users Control Panel by running "`control.exe userpasswords2`" from a Run dialog or command prompt.

* In the "Users" tab, uncheck "Users must enter a user name and password to use this computer".

* **UPDATE:** Windows 7 Home Premium, Windows Vista Home Premium and Windows XP Home Edition don't come with the necessary group policy editor so you can either Google for ways of using gpedit.msc (either downloading the needed files or editing the registry manually) or just put the above script in your Startup folder. The latter option will be less secure as someone could get access to your machine after the desktop loads but before the script does but it will still work.

* In the "Advanced" tab under "Advanced user management" click "Advanced".

* Click "Users" in the left-hand pane of the "Local Users and Groups" window, right-click on the user you want to autologin from the right-hand pane and select "Properties".

* In the "Profile" tab, enter "LockWorkstation.vbs" in the "Logon script:" box.

* Create a folder somewhere on disk (I recommend My Documents/Scripts) that you want to store the script in.

* Right-click on the folder and select "Properties". From the "Sharing" tab, click "Advanced Sharing...".

* Check "Share this folder" and enter "NetLogon" in the "Share name" box. Set the number of simultaneous users to 1.

* Click "Permissions" and ensure you are the only user listed and you have only "Read" access enabled.

You're now done. When you next log in, you shouldn't see the desktop at all (or incredibly briefly) and the screen should lock immediately and require your password to unlock while all your stuff happily loads in the background.

**UPDATE:** This was [posted on Lifehacker](https://lifehacker.com/make-windows-load-your-desktop-before-you-log-in-5645098) and they made a video walkthrough for this post:
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/8sVzE-zInfM" frameborder="0" allowfullscreen></iframe>
