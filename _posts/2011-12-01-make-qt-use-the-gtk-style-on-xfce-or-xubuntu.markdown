---
layout: article
title: Make Qt use the GTK Style on XFCE or Xubuntu
redirect_from:
  - /2011/12/make-qt-use-the-gtk-style-on-xfce-or-xubuntu/
---
I'm a Qt developer and use Xubuntu in my Linux VMs as it is lighter than KDE and doesn't get in my way (unlike Unity).

By default there is a problem with QGtkStyle which stops it correctly picking up the GTK theme as XFCE does not save it in the usual place.

To fix this we can use a simple script:

{% highlight bash %}
#!/bin/sh
DEFAULT_XFCE_THEME=greybird
XFCE_THEME=$(xfconf-query -c xsettings \
	-p /Net/ThemeName 2>/dev/null)
GTK2_RC_FILES=$HOME/.config/xfce4/gtkrc
[ -z "$XFCE_THEME" ] && XFCE_THEME=$DEFAULT_XFCE_THEME
echo gtk-theme-name = $XFCE_THEME > $GTK2_RC_FILES
unset DEFAULT_XFCE_THEME
unset XFCE_THEME
export GTK2_RC_FILES
. /etc/xdg/xfce4/xinitrc
{% endhighlight %}

Put this script into `$HOME/.config/xfce4/xinitrc` and ensure it is executable by running `chmod +x $HOME/.config/xfce4/xinitrc`.
