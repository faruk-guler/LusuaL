# Git-Cheatsheet
# https://cheatsheets.zip/git

## Setup

##### Show current configuration:
```bash
$ git config --list
```

##### Show repository configuration:
```bash
$ git config --local --list
```

##### Show global configuration:
```bash
$ git config --global --list
```

##### Show system configuration:
```bash
$ git config --system --list
```

##### Set a name that is identifiable for credit when review version history:
```bash
$ git config --global user.name “[firstname lastname]”
```

##### Set an email address that will be associated with each history marker:
```bash
$ git config --global user.email “[valid-email]”
```

##### Set automatic command line coloring for Git for easy reviewing:
```bash
$ git config --global color.ui auto
```

##### Set global editor for commit
```bash
$ git config --global core.editor vi
```
<hr>

## Configuration Files
##### Repository specific configuration file [--local]:
```bash
<repo>/.git/config
```
##### User-specific configuration file [--global]:
```bash
~/.gitconfig
```
##### System-wide configuration file [--system]:
```bash
/etc/gitconfig
```
<hr>

## Create
##### Clone an existing repository:
There are two ways:
Via SSH
```bash
$ git clone ssh://user@domain.com/repo.git
```
Via HTTP
```bash
$ git clone http://domain.com/user/repo.git
```
##### Create a new local repository in the current directory:
```bash
$ git init
```
##### Create a new local repository in a specific directory:
```bash
$ git init <directory>
```
<hr>

## Local Changes
##### Changes in working directory:
```bash
$ git status
```
##### Changes to tracked files:
```bash
$ git diff
```
##### See changes/difference of a specific file:
```bash
$ git diff <file>
```
##### Add all current changes to the next commit:
```bash
$ git add .
```
##### Add some changes in &lt;file&gt; to the next commit:
```bash
$ git add -p <file>
```
##### Commit all local changes in tracked files:
```bash
$ git commit -a
```
##### Commit previously staged changes:
```bash
$ git commit
```
##### Commit with message:
```bash
$ git commit -m 'message here'
```
##### Commit skipping the staging area and adding message:
```bash
$ git commit -am 'message here'
```
##### Commit to some previous date:
```bash
$ git commit --date="`date --date='n day ago'`" -am "<Commit Message Here>"
```
##### Change last commit:<br>
<em><sub>Don't amend published commits!</sub></em>
```
$ git commit -a --amend
```

##### Amend with last commit but use the previous commit log message
<em><sub>Don't amend published commits!</sub></em>
```shell
$ git commit --amend --no-edit
```
##### Change committer date of last commit:
```
GIT_COMMITTER_DATE="date" git commit --amend
```
##### Change Author date of last commit:
```shell
$ git commit --amend --date="date"
```
##### Move uncommitted changes from current branch to some other branch:<br>
```
$ git stash
$ git checkout branch2
$ git stash pop
```
##### Restore stashed changes back to current branch:
```shell
$ git stash apply
```
#### Restore particular stash back to current branch:
- *{stash_number}* can be obtained from `git stash list`
```shell
$ git stash apply stash@{stash_number}
```
##### Remove the last set of stashed changes:
```
$ git stash drop
```
<hr>

## Search
##### A text search on all files in the directory:
```
$ git grep "Hello"
```
##### In any version of a text search:
```
$ git grep "Hello" v2.5
```
<hr>

## Commit History
##### Show all commits, starting with newest (it'll show the hash, author information, date of commit and title of the commit):
```
$ git log
```
##### Show all the commits(it'll show just the commit hash and the commit message):
```
$ git log --oneline
```
##### Show all commits of a specific user:
```
$ git log --author="username"
```
##### Show changes over time for a specific file:
```
$ git log -p <file>
```
##### Display commits that are present only in remote/branch in right side
```
$ git log --oneline <origin/master>..<remote/master> --left-right
```
##### Who changed, what and when in &lt;file&gt;:
```
$ git blame <file>
```
##### Show Reference log:
```
$ git reflog show
```
##### Delete Reference log:
```
$ git reflog delete
```
<hr>

## Move / Rename
##### Rename a file:
Rename Index.txt to Index.html
```
$ git mv Index.txt Index.html
```
<hr>

## Branches & Tags
##### List all local branches:
```
$ git branch
```
#### List local/remote branches
```
$ git branch -a
```
##### List all remote branches:
```
$ git branch -r
```
##### Switch HEAD branch:
```
$ git checkout <branch>
```
##### Checkout single file from different branch
```
$ git checkout <branch> -- <filename>
```
##### Create and switch new branch:
```
$ git checkout -b <branch>
```
##### Create a new branch from an exiting branch and switch to new branch:
```
$ git checkout -b <new_branch> <existing_branch>
```
#### Checkout and create a new branch from existing commit
```
$ git checkout <commit-hash> -b <new_branch_name>
```
##### Create a new branch based on your current HEAD:
```
$ git branch <new-branch>
```
##### Create a new tracking branch based on a remote branch:
```
$ git branch --track <new-branch> <remote-branch>
```
##### Delete a local branch:
```
$ git branch -d <branch>
```
##### Rename current branch to new branch name
```shell
$ git branch -m <new_branch_name>
```
##### Force delete a local branch:
<em><sub>You will lose unmerged changes!</sub></em>
```
$ git branch -D <branch>
```
##### Mark `HEAD` with a tag:
```
$ git tag <tag-name>
```
##### Mark `HEAD` with a tag and open the editor to include a message:
```
$ git tag -a <tag-name>
```
##### Mark `HEAD` with a tag that includes a message:
```
$ git tag <tag-name> -am 'message here'
```
##### List all tags:
```
$ git tag
```
##### List all tags with their messages (tag message or commit message if tag has no message):
```
$ git tag -n
```
<hr>

## Update & Publish
##### List all current configured remotes:
```
$ git remote -v
```
##### Show information about a remote:
```
$ git remote show <remote>
```
##### Add new remote repository, named &lt;remote&gt;:
```
$ git remote add <remote> <url>
```

##### Rename a remote repository, from &lt;remote&gt; to &lt;new_remote&gt;:: 
##### Rename a remote repository, from &lt;remote&gt; to &lt;new_remote&gt;:
```
$ git remote rename <remote> <new_remote>
```
##### Remove a remote:
```
$ git remote rm <remote>
```
<em><sub>Note: git remote rm does not delete the remote repository from the server. It simply removes the remote and its references from your local repository.</sub></em>
##### Download all changes from &lt;remote&gt;, but don't integrate into HEAD:
```
$ git fetch <remote>
```
##### Download changes and directly merge/integrate into HEAD:
```
$ git remote pull <remote> <url>
```
##### Get all changes from HEAD to local repository:
```
$ git pull origin master
```
##### Get all changes from HEAD to local repository without a merge:
```
$ git pull --rebase <remote> <branch>
```
##### Publish local changes on a remote:
```
$ git push remote <remote> <branch>
```
##### Delete a branch on the remote:
```
$ git push <remote> :<branch> (since Git v1.5.0)
```
OR
```
$ git push <remote> --delete <branch> (since Git v1.7.0)
```
##### Publish your tags:
```
$ git push --tags
```
<hr>

#### Configure the merge tool globally to meld (editor)
```bash
$ git config --global merge.tool meld
```
##### Use your configured merge tool to solve conflicts:
```
$ git mergetool
```
## Merge & Rebase
##### Merge branch into your current HEAD:
```
$ git merge <branch>
```
##### Rebase your current HEAD onto &lt;branch&gt;:<br>
<em><sub>Don't rebase published commit!</sub></em>
```
$ git rebase <branch>
```
##### Abort a rebase:
```
$ git rebase --abort
```
##### Continue a rebase after resolving conflicts:
```
$ git rebase --continue
```
##### Use your editor to manually solve conflicts and (after resolving) mark file as resolved:
```
$ git add <resolved-file>
```
```
$ git rm <resolved-file>
```
##### Squashing commits:
```
$ git rebase -i <commit-just-before-first>
```
Now replace this,
```
pick <commit_id>
pick <commit_id2>
pick <commit_id3>
```
to this,
```
pick <commit_id>
squash <commit_id2>
squash <commit_id3>
```
<hr>

## Undo
##### Discard all local changes in your working directory:
```
$ git reset --hard HEAD
```
##### Get all the files out of the staging area(i.e. undo the last `git add`):
```
$ git reset HEAD
```
##### Discard local changes in a specific file:
```
$ git checkout HEAD <file>
```
##### Revert a commit (by producing a new commit with contrary changes):
```
$ git revert <commit>
```
##### Reset your HEAD pointer to a previous commit and discard all changes since then:
```
$ git reset --hard <commit>
```
##### Reset your HEAD pointer to a remote branch current state.
```
$ git reset --hard <remote/branch> e.g., upstream/master, origin/my-feature
```
##### Reset your HEAD pointer to a previous commit and preserve all changes as unstaged changes:
```
$ git reset <commit>
```
##### Reset your HEAD pointer to a previous commit and preserve uncommitted local changes:
```
$ git reset --keep <commit>
```
##### Remove files that were accidentally committed before they were added to .gitignore
```
$ git rm -r --cached .
$ git add .
$ git commit -m "remove xyz file"
```
```bash
#Install git on windows via https://git-scm.com

#To Initialize a git repository within directory
git init

#To view the status of the repo
git status

#To stage/add a file for commiting
git add <filename>

#To commit a file, adding a message
git commit -m "message for committing"

#To download repo from github
git clone <github url>

#Push changes from branch master to origin master
git push origin master

#Save credentials while on Linux
git config --global credential.helper store

#Commands to get locally created git repo to connect to github
#Create repo on github with same name but do not initialize
git remote add origin <github url>
git remote -v
git push origin master
#To set upstream master so you can just run git push
git push --set-upstream orgin master

#To view history of commits
git log

-----------------------------------------------------------------
#To get a list of all branches of a repository, working branch is *'ed
git branch

#To create a new branch
git branch <new branch name>

#To switch to another branch
git checkout <new branch name>
 
#To create and checkout to brank in one command
git checkout -b <new branch name>

#To set new upstream branch to push to, -u or --set-upstream
git push -u origin <new branch name>

#To delete a branch locally on workstation
git branch -d <branch name>
git branch -D <branch name> #forcefully deletes

#To delete a branch on github, click branches link, then select delete icon

#To merge newer branch into the working branch, checkout to working branch and run
git merge <newer branch name>

#Pull request on Github = pull someone elses changes into your repo, called merge request on Gitlab
#When working with others, good practice is to not commit on master branch, but rather use pull requests from other branches to master
#After you push changes to branch, from your branch repo click Compare & pull request button on github

#After changes to github repo, pull down changes (fetch+merge)
git pull origin master

-----------------------------------------------------------------
#To view tags
git tag -l

#Tag your latest commit with a version number
git tag v1.0

#To push your tag information to github
git push --tags

#You can also create tagged versions on github.com as well as delete them there

-----------------------------------------------------------------
#Adding github collaborators
  - On github, go to settings->collaborators and add github users
  - Protect master branch by going to settings->branches
    - select Protect->Require pull reviews & Include administrators

#Github workflow
  - clone->branch->work->add->commit->push->pullrequest->merge->pull

#To get any changes from github
git fetch

#To merge changes fetched from github
git merge origin/master

-----------------------------------------------------------------
#A fork is a github or gitlab thing, way to copy someone's repo at a point in time for yourself
 - Click the Fork button on github to put in your repos

#If you want to grab new changes from where you forked
git remote add <original repo github address>

#To view remote master branch name
git remote -v

#To pull changes from remote master branch
git pull <remote branch name>

#Pull you new changes back to github
git push

-----------------------------------------------------------------

#Create a hidden .gitignore file that will describe what to not put on github. Put in main directory
touch .gitignore 

#Add to .gitignore a single file to ignore such as passwords.txt
nano .gitignore
  passwords.txt

#Add an entire directory to be ignored such as directory secrets/
nano .gitignore
  secrets/*

#Ignore any file with the extension .exe 
nano .gitignore
  *.exe

```
<hr>


**[⬆ Back to Top](#Git-Cheatsheet)**
