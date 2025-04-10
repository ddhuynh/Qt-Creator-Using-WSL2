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
Qt Creator has a bunch of different options for version control, but for simplicity, I'd use git for Windows 11.
Once it's downloaded and installed, Qt Creator should see it automatically in ``` Edit > Preferences > Version Control ```. This allows you to select git for version control when creating a new project.
(You technically could not use git for Windows 11, but I think Qt Creator wants you to.)

Now we just need to set up a GitHub repo to store the project files:
1. Create a new project in Qt Creator. Add it to whatever directory you want to store your projects in. Use git for version control on the final screen.
    - This initializes an empty git repository and adds a .gitignore. We're going to add a remote to this.
2. Set up an empty repository on github. It can be private or public. You can add a readme, but otherwise keep it empty for simplicity.
3. Using the terminal in Qt Creator, navigate to the directory your project is located in. (The directory with the .git hidden folder!)
4. Run the command: ``` git remote add origin (YOUR HTTPS / SSH REPOSITORY LINK) ```.
    - This adds a connection to your github repository. You will eventually need to authenticate to make changes to that repository.
    - Depending on if you're using a PAT or SSH key, you need to do things differently here.
    - If you're using an SSH key, make sure you can authenticate with your repository and run git operations through the terminal you're using.
      If you've generateed the keys, they should be located in either ``` C:\Users\YOURUSERNAME\.ssh ``` for windows, or ``` \home\YOURUSERNAME\.ssh ``` for linux.
    - If you're using HTTPS/PAT, I believe you just need to input the PAT for a repo when the prompted for a password. (I don't use PATs, so I'm not familiar with this.)
6. Now we need to ensure everything is working correctly. Run the following commands in your terminal: (You will be asked to authenticate using PATs or SSH)
    - ``` git fetch ``` -- This fetches content from the remote repository.
    - ``` git pull origin main ``` -- This will fetch+merge the readme from the github repo to your local repo. If there are merge conflicts, you'll need to resolve them before being able to pull.
    - ``` git branch --set-upstream-to=origin/main main ``` -- Tells your local branch "main" to push/pull from the remote repo/branch "origin/main".
7. Now you can just use git like normal.
    - ``` git add . ``` -- Add the untracked default project files that qt creator gives you.
    - ``` git commit -m "Whatevers" ``` -- Commit to your local branch
    - ``` git push ``` -- Pushes your changes to the remote repository.
  
Additional Notes:
Make sure not to push build files to your github repository!
Your github repo for for a Qt Project should contain the source files necessary for building your program.


Ok, now lets say you want to clone a project. I'd recommend just using the terminal to clone to your local project directory.
1. Run ``` git clone (YOUR HTTPS / SSH REPO LINK) ```. Authenticate like normal. (Unless you clone a public repo using https.)
2. Open the project up in Qt Creator. Everything should be there and you can continue working like normal.

## Compiling, Running, and Releasing a Program
