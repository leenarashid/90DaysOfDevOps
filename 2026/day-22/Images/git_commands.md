### Git Commands Reference
----
1️⃣ Setup & Config

- `git config`: First step of the Git setup.Sets configuration values like username and email for Git.

`git config --global user.name "<name>"`
`git config --global user.email "<complete email address>"`

- `git init`:Initializes a new Git repository in the current directory.

 `  git init`
- `git clone`: Copies an existing remote repository to your local machine.Only used when we need an existing repository to work with.This step can be skipped otherwise.

`git clone https://github.com/username/repository.git`


2️⃣ Basic Workflow

- `git status`: Shows the current state of the working directory and staging area.

  `git status` 

- `git add` : Adds changes from the working directory to the staging area.

  `git add file.txt`
  `git add .`


- `git commit`: Saves staged changes to the repository with a message.

  `git commit -m "A meaningful message to describe the push action precisely.`


- `git push`:Uploads local commits to a remote repository.

  `git push origin main`


- `git pull`:Fetches and merges changes from a remote repository.
  `git pull origin main`


3️⃣ Viewing Changes

- `git log`:Displays commit history, along with respective commit id's.
  `git log`: For sequenced ellaborated output.
  `git log --oneline` : For compact output.

- `git diff`:Shows differences between working directory and last commit.
  `git diff` <commit id 1> <commit id 2>

- `git show`:Displays detailed information about a specific commit.
  `git show <commit-hash>`
