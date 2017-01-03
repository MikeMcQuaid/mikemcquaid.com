---
title: KDE - Blog From KOrganizer HOWTO
redirect_from:
  - /2008/09/kde-blog-from-korganizer-howto/
---
**Blog from KOrganizer?** What kind of **madness** is this? Apparently some crazy fool decided to give you the ability to post journals from KOrganizer to your blog. Let's learn how to do it!

Firstly open **KOrganizer**.

When it has opened right-click anywhere in the _"Calendars"_ area in the bottom-left and select _"Add..."_ from the drop-down menu that appears.

Select _"Journal in a blog"_ from the _"Resource Configuration"_ dialog.

Fill in the _"Resource Configuration"_ dialog.

* **Name**: Choose a descriptive name for your resource, this is how KOrganizer will describe it to you in future. KOrganizer won't reference this resource as being a blog again so you may want to choose something suffixed with _"blog_".

* **XML-RPC URL**: This depends on your blog but for Wordpress and Drupal this is the main URL followed by _"/xmlrpc.php_", for LiveJournal it is _"http://www.livejournal.com/interface/blogger"_ and for Blogger it is _"http://www.blogger.com/feeds/$YOUR\_USER\_ID/blogs"_. For other blogs, consult their documentation or ask me for help and I'll do my best to work it out.

* **Username**: This is the username you use to login and make blog posts.

* **Password**: This is the password you use to login with the above username and make blog posts.

* **API**: Use "(Wordpress, Drupal < 5.6 workarounds)" if you use either of those blogs. Otherwise it is MovableType for Drupal, Google Blogger Data for Blogger and Blogger for LiveJournal. The LiveJournal API is unlikely to work with LiveJournal as it isn't yet complete. If you wish to implement the LiveJournal full API rather than using legacy Blogger one then please contact me.

* **Blog**: When you have chosen an API this list will be automatically populated using items from the server. If there is only one entry, it will be greyed out but the entry's text shown and selected. If there are more than one _(e.g. Drupal has one for pages and one for posts)_ they will be selectable. If there is nothing new displayed then one or more of your XML-RPC/username/password/API are probably incorrect.

* **Posts to download**: This chooses how many posts the API will download and sync. If you, like me, have made hundreds of posts then you probably want to keep this number reasonably low.

* **Automatic Reload**: This defines how often KOrganizer will download new blog posts from the server without notification.

* **Automatic Save**: This defines when KOrganizer will upload new blog posts to the server without notification. You probably don't want to have this set to _"On every change"_ unless you want it to be uploaded as soon as you hit _"Save"_ in the next view.

You should now see your new blog resource displayed in the bottom-left corner. Let's try making a new blog post. Activate the journal view by clicking the journal button.

We are now in the journal view and you can see on the left-hand pane that KOrganizer has successfully downloaded some of my blog posts. If we want to create a new one then click on the add journal button.

Fill in the _"Edit Journal Entry"_ dialog.

* **Title**: You probably want to change the title of the blog post from the default.

* **Date/Time**: On most blogs selecting the date/time to somewhere in the future means the blog won't publicly appear until then.

* **Content**: Write something about how I am awesome, like the pictured example.The rich-text should be displayed on your blog correctly _(albeit with slightly nasty HTML)_.

* **Select Categories**: This list should have been populated with the ones from your blog and from the KOrganizer defaults. Sadly, I can't seem to remove the latter and selecting them will do nothing unless they have been created on your blog.

When you click _"OK"_ you may be prompted which resource you wish to save to. Select the resource we just created.

If you chose _"on every change"_ for _"Automatic Save"_ in the _"Resource Configuration"_ dialog then your post has probably whizzed its way off to your blog already. If not, you can manually save it by right-clicking on your resource and selecting _"Save"_ from the drop-down menu that appears.

I hope this was and is useful to some people. If you **find any bugs, have any problems or want any other features** then please let me know either by email, my posting on this blog or by [filing a bug in the KDE bugtracker](https://bugs.kde.org/enter_bug.cgi?format=guided).
