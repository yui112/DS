---
typora-copy-images-to: ../github_peter

---

# Configuring and Initializing a Repository

## Initializing a Repository

- initializing turns a folder on your local machine into a git repository
- The git init command creates a .git folder within the current directory
- The .git folder contains everything you need to track changes to files



~~~shell
mkdir my_git_project #making directory
cd my_git_project #moving to the folder
git init #initializing a repository at the folder
ls -a #checking folder
~~~

![image-20181210124052854](/Users/yunsungsong/Documents/github_peter/learning_github/image-20181210124052854.png)





# Tracking Files

## What Is Tracking?

- In order for Git to start looking for changes to files, we have to add them to the Git repository
- This allows Git to then track the changes made to those files over time.



![image-20181210124546786](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210124546786.png)







## Tracking and Staging Files

- Files are untracked when first crated so that we don't track unnecessary files
- To start tracking, we use the git add command
- 'git add' is short for "stage all files and changes in the current folder"
- To add a file's changes to the staging area, we also use 'git add'

![image-20181210125542113](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210125542113.png)

I saved 'learning_git_in_3hours' doc at 'my_git_project' folder and modified texts. Then, commanding 'git stauts' shows the doc has been modified and 'Changes not staged for commit'.

![image-20181210130048335](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210130048335.png)

'git add . ' adds all changes. You can also add a specific file using the file name instead of '.' . As can be seen, 'Changes to be committed'.



# Viewing Changes

- ''-git status" shows the names of changed files
- Also, 'git diff' commnad shows the exact changes we made since the last commit



![image-20181210133203332](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210133203332.png)



# Committing Your Changes

Once changes have been made in the repository, we will want to save those changes. To do this, we use the Git commit command.

- Make and view your changes using Git diff
- Save those changes to the repository using Git commit
- Provide a useful message to the commit 



## Commiting Changes

- git commit begins the commit process
- This opens the text editor specified by your git confit or the EDITOR environment variable
- Dafault commit messsage template contains the output of the git stauts
- Pass -v to git commit to show the current diff in the message template
- Pass -a to git commit to add all changes and commit simulaneously
- Use git commit -m "My commit message" if you don't want to use an editor



# Setup Git Ignore Files

There will be files in our Git repositories that we will not want to track the changes to, such as build artefacts. We can use Git ignore lists to specify these files.

- Decide what files are to be ignored
- Create a .Gitignore file in the repository
- Write an expression to match the filenames of ignored files 



## Git Ignore Lists

- Ignore files allow you to tell git what files never to track
- Ignore files are made up of patterns that match the names of files to ignore
- Useful for ignoring build and runtime artifacts, for examples, binary files or log files
- Git ignore are text files called .gitignore contained in the repository



![image-20181210135541161](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210135541161.png)

![image-20181210140333386](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210140333386.png)

![image-20181210135826587](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210135826587.png)



## Pattern Symbol Guide

- Asterisk matches zero or more characters: *
- Patterns staring with a forward slash are only matched in the same directory as the git ignore file
- Patterns ending with a forward slash will only matech forder names
- An exclamation mark (!) negates a patter:
  - For example, you can ensure that TODO.log isn't ignored by using !TODO.log
- Double asterisk tells git to ignore anything in subdirectories:
  - For example, documentation ![image-20181210142041021](/Users/yunsungsong/Library/Application Support/typora-user-images/image-20181210142041021.png) will ignore all HTML files in subdirectories of the documentation folder



# Browsing Project History

The main focus of Git is to track changes to files over time. To view all changes committed to a repository over a certain time period, we can use the Git log command.

- Open a repository that has been committed to
- Use Git log to view all changes
- Pass arguments to filter the log to your liking 

## Git Log

- The git log command shows a list of commits in reverse chronological order
- This will show the hash of the commit, author, commit message, and date on which it was made
- Can be used to understand what has changed in the repository at a glance

 ~~~shell
git log # show all logs
git log -2 # <n> limit log output to last n commits
git log -p #show the patch introduced within each commit, that is, the change
git log --pretty=oneline #pretty=format each commit in a certain way
git log --pretty=full
git log --pretty=fuller # more information than 'full'
git log --since "2 months" #shows logs for only two months
git log --graph #show log in a graph-style output
 ~~~

![image-20181210142930464](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210142930464.png)

<oneline>

![image-20181210143041553](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210143041553.png)



<full>

![image-20181210143140931](/Users/yunsungsong/Documents/github_peter/Learning_Github/image-20181210143140931.png)

<since "2 months">



# Undoing Mistakes

Sometimes when programming, we introduce bugs that break the software we work on. Git can be used to easily revert the change that broke the program.

- Identify the commit to be reverted
- Use Git revert to undo the mistake
- Commit the revert

~~~shell
git log
git revert <token>
~~~



# Cloning Repositories

We won’t always start the projects we work on from our own machines. To begin working on an existing repository, we can clone the repository using Git clone.

- Get the URL of the repository you want to clone
- Clone it to your local machine
- Start working on your clone of the repo 

Cloning a repository

- Cloning copies an exising git repository, usually from the internet
- Copy repository in its entirety to your local machine
- Keeps track of the repository's remotes
- Creates a directory and copies the repository's contents into it



![image-20181210154433138](/Users/yunsungsong/Documents/github_peter/image-20181210154433138.png)

~~~shell
git clone <copied SSH key>
~~~



# Using Remote Repositories

In order to share work with other programmers, we need to send to and pull changes from remote repositories. We can manage our repositories’ remotes using the Git remote command.

- Use Git remote to show our configured remote repositories
- Add or remove remotes
- Fetch and merge changes into your local repository 
- Remote repositories are copies of a repository hosted somewhere on the internet or your network
- Allow you to collaborate with other developers
- Remote can be added or removed when needed

~~~shell
git remote
git remote add new-remote <url>
git fetch origin #it only downloads
git merge origin/master master #it merges both
~~~

