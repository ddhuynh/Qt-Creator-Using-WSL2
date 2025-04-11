# Setting up Qt Creator Using WSL2 on Windows 11

!!! WARNING !!!

Huge wall of text below. Super scary.

Last Updated: 4/10/2025 (I won't be actively updating this anymore unless people are having issues.)

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

### Now we just need to set up a GitHub repo and a Qt Project:
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

5. Now we need to ensure everything is working correctly. Run the following commands in your terminal: (You will be asked to authenticate using PATs or SSH)
    - ``` git fetch ``` -- This fetches content from the remote repository.
    - ``` git pull origin main ``` -- This will fetch+merge the readme from the github repo to your local repo. If there are merge conflicts, you'll need to resolve them before being able to pull.
    - ``` git branch --set-upstream-to=origin/main main ``` -- Tells your local branch "main" to push/pull from the remote repo/branch "origin/main".

6. Now you can just use git like normal.
    - ``` git add . ``` -- Add the untracked default project files that qt creator gives you.
    - ``` git commit -m "Whatevers" ``` -- Commit to your local branch
    - ``` git push ``` -- Pushes your changes to the remote repository.
  
Additional Notes:
Make sure not to push build files to your github repository!
Your github repo for for a Qt Project should contain the source files necessary for building your program.

### Ok, say you want to clone a project. I'd recommend using the terminal to clone to a local directory.
1. Run ``` git clone (YOUR HTTPS / SSH REPO LINK) ```. Authenticate like normal. (If you clone a public repo using HTTPS, you don't need to authenticate.)
2. Open the project up in Qt Creator. Everything should be there and you can continue working like normal.

Man... what a long section...

## Compiling, Running, and Releasing a Program
OK! Last section. Lets make this quick.

If you want to compile a project on Windows 11, you should use windeployqt.

You can find windeployqt here, at C:\Qt:
```
C:\Qt\VERSION_NUMBER_HERE\mingw_64\bin\windeployqt.exe
```

If you're using WSL2, you should run something like this in the terminal:
```
/mnt/c/Qt/6.9.0/mingw_64/bin/windeployqt.exe program.exe
```

If you use git bash, you should run this in the terminal:
```
/c/Qt/6.9.0/mingw_64/bin/windeployqt.exe program.exe
```

Swap the version number with the Qt version you're using. (Or check the qt folder to see your version.)
I'm not really sure what's up with all the other toolchains, so I just use mingw_64.

Great! Now what?

### Here's how to release the program.
1. Swap to the release build by clicking on the PC icon above the Green play button, at the bottom left corner of Qt Creator. (I'd add images here to show you, but I'm getting really lazy.)
2. Build the project on that configuration by clicking the hammer below, or by going to ``` Build > Build Project "PROJECTNAME" ```
3. This will create a folder inside ``` build/ ``` in your project directory. It should say -Release at the end of the folder name.

(If you try to ship that release folder without using windeployqt, you'll likely find that you're missing some dlls and can't run the program.)

4. So we want to run windeploy.exe on the projectname.exe in that release build folder. This will add the appropriate dlls to that folder.
   You have a few options here.
   - Add Qt Creator's bin folder to your system environment variable. This allows you to use windeployqt.exe on any windows-based terminal (not WSL2 cuz it's on linux) without typing the full path to windeploy.exe.
     If you do this, be careful! You might download your release build and see that the program works, but it'll be missing the required dlls if other people download it, since they don't have the Qt bin folder in their system environment variables.
   - The second option is to run windeployqt using the full path I provided above. (You could probably make a shortcut for this.)
     For example, you would change your terminal directory to wherever the release build is created e.g. ``` \build\Desktop_Qt_6_9_0_MinGW_64_bit-Release ```.
     Then, run the windeployqt path I provided above with the .exe file in that folder. That should add the appropriate dll files, so anyone can use your program.

5. Finally, you can ship your program out! Just zip up that release folder and sail away!

P.S.

I'm gonna add the source files for a basic Qt Program to this repository and release the program under packages.

I hope it works!

If you've made it this far, congrats! This whole thing was basically just a huge wall of text, but I hope something helped if you were having issues.
Also this isn't a perfect guide by any means, but just what I've experienced.

Feel free to add an issue to this repo if you discover one!
