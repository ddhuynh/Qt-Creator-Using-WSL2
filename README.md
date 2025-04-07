# Setting up Qt Creator Using WSL2 on Windows 11

Last Updated: 4/7/2025

Recently I've been messing around with Qt Creator trying to develop applications for personal usage, but I've struggled a bit with setting up the framework itself.

If you're reading this, you're probably encountering some issues as well, so hopefully this guide helps out a bit (even if it might not be perfect).

Here's a table of contents that I'll be going through:

- [Downloading and setting up Qt Creator](#downloading-and-setting-up-qt-creator)
- [Getting the terminal to work with WSL2](#getting-the-terminal-to-work-with-wsl2)
- [Creating/cloning a project](#creatingcloning-a-project)
- [Compiling, running, and releasing a program](#compiling-running-and-releasing-a-program)

Ok, lets get started...

## Downloading and Setting up Qt Creator
When you first visit the Qt Creator website, you might wonder where to go to download the IDE itself.
Luckily for you, I've provided a direct link to the installer downloads for each platform: [https://www.qt.io/download-qt-installer-oss](https://www.qt.io/download-qt-installer-oss).
There's a lot of info about licensing with (L)GPLv3 which is worth reading, but it mostly revolves around open source usage (I think).

Once you've downloaded the installer for Windows, run it, and follow through the steps to install Qt Creator.

On the screen that asks for installation options, click on ```Qt [version] for desktop development``` and continue the insallation as normal.

Once Qt Creator has finished installing, we can move on to the next step!

## Getting the Terminal to Work with WSL2
When you first open up Qt Creator, there are a few things to set up.

First, if GUI size is too large or too small, you can change that by going to ``` Edit > Preferences > Environment > DPI Rounding Policy ```.

Next is the terminal settings. You can change the default terminal by going to ``` Edit > Preferences > Terminal > Default Shell > Shell Path ```.

Since I'm a big fan of using WSL2 and Ubuntu, I set my shell path to ``` C:\Windows\System32\wsl.exe ```.
I also added the shell argument ``` --cd ~ ``` to start on the linux file system.

However, I'm storing my Qt Project Files on my Windows file system, so I created a shortcut to that folder:

```
ln -s /mnt/c/Users/YOURUSERNAMEHERE/Desktop/QtFiles qtfiles
```

(Yes, this is can potentially affect performance speed according to [this](https://learn.microsoft.com/en-us/windows/wsl/filesystems#file-storage-and-performance-across-file-systems),
but Qt Creator for Windows doesn't like it when you store project files on the WSL file system, so this will have to work if you want to use the WSL/Ubuntu terminal.)

That's it...? Yep.

You can technically use any terminal that you're familiar with, just make sure to find and set the correct shell path.

Now you can perform all your git operations for a Qt Project through the terminal!

## Creating/Cloning a Project
Almost finished, just a few more sections to go!

If I ever forget how I configured my Qt stuff, at least I can look at this and remember!!!


## Compiling, Running, and Releasing a Program
