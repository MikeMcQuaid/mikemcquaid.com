---
title: Deploying Qt applications With DeployQt4
date: 2012-01-04 00:00:00 Z
excerpt: DeployQt4 will take an executable and any specified Qt plugins and install
  and setup all the linked dependencies.
redirect_from:
- "/2012/01/deploying-qt-applications-with-deployqt4/"
---

[CMake 2.8.7 has been released](http://www.kitware.com/news/home/browse/CMake?2012_01_02&CMake+2.8.7+Now+Available) and includes the DeployQt4 module I created.

DeployQt4 will take an executable and any specified Qt plugins and install and setup all the linked dependencies.

DeployQt4 does this by using e.g. `otool`, `ldd` or `depends.exe` to find the linked libraries, installing a `qt.conf` file (if needed) to ensure the correct Qt is used and install any specified Qt plugins to the default Qt application plugin path. On OS X it will also use `install_name_tool` to make sure your application is linked directly to the libraries inside its bundle.

For example an OS X application bundle before DeployQt4 might look like:
![Before DeployQt4 directory tree](/images/a/deployqt4-before.png)

and afterwards like:
![After DeployQt4 directory tree](/images/a/deployqt4-after.png)

The most commonly used DeployQt4 function is `INSTALL_QT4_EXECUTABLE` function. For example:

`INSTALL_QT4_EXECUTABLE(${EXECUTABLE_PATH} qsqlite)`

If you wanted to do this in a CMake script rather than at install time (i.e. for an already compiled executable) you could instead call:

`FIXUP_QT4_EXECUTABLE(${EXECUTABLE_PATH} qsqlite)`

Other DeployQt4 options include manually specifying libraries or non-Qt plugins to install their linked dependencies, additional directories to check for linked dependencies (the Qt directories are added by default), override the default plugin installation directory, override whether a `qt.conf` file is installed and the use of CMake `INSTALL` components.

You can see an example of using DeployQt4 (combined with CPack to generate installers) in [the CMakeLists.txt file for my Fabula project](https://github.com/MikeMcQuaid/Fabula/blob/master/CMakeLists.txt).

For more information read the [DeployQt4 section of the official CMake documentation](https://cmake.org/cmake/help/v2.8.8/cmake.html#module:DeployQt4), read the [DeployQt4 source code](https://github.com/Kitware/CMake/blob/master/Modules/DeployQt4.cmake) or post a question in the comments.

If you want the same functionality for non-Qt projects I suggest you investigate the [BundleUtilities module in CMake](https://cmake.org/cmake/help/v2.8.8/cmake.html#module:BundleUtilities). Despite the confusing name this installs linked dependencies on Windows, Mac and Linux. DeployQt4 extends this functionality to improve the API and add some Qt-specific deployment help.

If you want the same functionality for Mac-only non-CMake projects I suggest you investigate the [Mac deployment tool (macdeployqt)](http://doc.qt.io/archives/qt-4.8/deployment-mac.html#the-mac-deployment-tool) that is bundled with Qt. It lacks the DeployQt4 added features of automatic installation of any linked dependencies, CMake/CPack integration and support for Windows and Linux but will install the Qt libraries correctly.
