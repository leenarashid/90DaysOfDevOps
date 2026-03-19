### Day 28 – Revision Day: Everything from Day 1 to Day 27
#### Go through the checklist below. For each item, mark yourself honestly:
### Task1

- [x] Linux

- [x] Navigate the file system, create/move/delete files and directories
- [x] Manage processes — list, kill, background/foreground
 - [x] Work with systemd — start, stop, enable, check status of services
 - [x] Read and edit text files using vi/vim or nano
 - [x] Troubleshoot CPU, memory, and disk issues using top, free, df, du
 - [x] Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
 - [x] Create users and groups, manage passwords
 Set file permissions using chmod (numeric and symbolic)
 - [x] Change file ownership with chown and chgrp
 - [x] Create and manage LVM volumes
 - [x] Check network connectivity — ping, curl, netstat, ss, dig, nslookup
 - [x] Explain DNS resolution, IP addressing, subnets, and common ports
- [x] Shell Scripting
 - [x] Write a script with variables, arguments, and user input

- [x] Write for, while, and until loops
- [x] Define and call functions with arguments and return values
- [x] Use grep, awk, sed, sort, uniq for text processing
- [x] Handle errors with set -e, set -u, set -o pipefail, trap
- [x] Schedule scripts with crontab
- [x] Git & GitHub
- [x] Initialize a repo, stage, commit, and view history
 - [x] Create and switch branches
 - [x] Push to and pull from GitHub
 - [x] Explain clone vs fork
- [x]  Merge branches — understand fast-forward vs merge commit
 - [x] Rebase a branch and explain when to use it vs merge
 - [x] Use git stash and git stash pop
 - [x] Cherry-pick a commit from another branch
 - [x] Explain squash merge vs regular merge
 - [x] Use git reset (soft, mixed, hard) and git revert
 - [x] Explain GitFlow, GitHub Flow, and Trunk-Based Development
 - [x] Use GitHub CLI to create repos, PRs, and issues
 ------

####  Task 2: Revisit Your Weak Spots
- Pick 3 topics from the checklist where you marked "Need to revisit"
- Go back to that day's challenge and redo the hands-on tasks
- Document what you re-learned in day-28-notes.md




----
#### Task 3: Quick-Fire Questions


> What does chmod 755 script.sh do?

**Answer**



> What is the difference between a process and a service?

**Answer**

>The difference is about scope and lifecycle:

**Process**

- A single running program in memory.

- Can start and stop manually.

- Example: running node app.js in a terminal.

**Service**

- A long-running background process managed by a system or orchestrator.

- Automatically starts on boot or restart.

- Example: docker container run -d or systemctl start nginx.



> How do you find which process is using port 8080?

**Answer**
Use lsof -i :8080 (Linux/macOS) or netstat -ano | findstr :8080 (Windows) to see the PID of the process using port 8080.


> What does set -euo pipefail do in a shell script?

**Answer**

set -euo pipefail

means:

-e → exit immediately if any command fails

-u → treat unset variables as an error

-o pipefail → fail the pipeline if any command in it fails


> What is the difference between git reset --hard and git revert?


**Answer**

**git reset --hard <commit>**

- Moves the branch pointer back to a specific commit.

- Discards all changes after that commit, including staged and working directory changes.

- History is rewritten, so it can be dangerous if pushed to a shared branch.

**git revert <commit>**

- Creates a new commit that undoes the changes from a specific commit.

- History stays intact, safe for shared branches.


>What branching strategy would you recommend for a team of 5 developers shipping weekly?

**Answer**
- Use a feature-branch workflow:

- Create feature branches from main for each task.

- Merge via pull requests after review.

- Keep main always production-ready.

- For weekly releases, merge features into main and tag a release.



> What does git stash do and when would you use it?

**Answer**
git stash temporarily saves your uncommitted changes (tracked and optionally untracked) so you can work on something else without committing them.

**Use it when:**

You’re in the middle of a task but need to switch branches.

You want a clean working directory to pull, merge, or test code
> How do you schedule a script to run every day at 3 AM?

**Answer**
0 3 * * * /path/to/your/script.sh

0 3 → 3:00 AM

* → every day, month, and weekday

/path/to/your/script.sh → full path to your script

> What is the difference between git fetch and git pull?

**Answer**

The difference is about what happens locally:

**git fetch**

Downloads changes from the remote without merging them.

Lets you inspect changes before integrating.

**git pull**

Downloads and automatically merges changes from the remote into your current branch.

> What is LVM and why would you use it instead of regular partitions?

**Answer**
LVM (Logical Volume Manager) is a system for managing disk storage more flexibly than standard partitions.


- Resize volumes easily – grow or shrink logical volumes without repartitioning.

- Combine multiple disks – create a single logical volume from several physical disks.

- Snapshots – take point-in-time copies of volumes for backups.

- Better management – move, extend, or reduce storage without downtime.


----

