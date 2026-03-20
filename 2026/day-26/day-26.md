### Day 26 – GitHub CLI: Manage GitHub from Your Terminal
---
#### Task 1: Install and Authenticate
- Install the GitHub CLI on your machine


<img src="assets/1.png" width="600">

- Authenticate with your GitHub account



- Verify you're logged in and check which account is active


<img src="assets/1-2.png" width="600">

-  What authentication methods does gh support?
**Answer**
- OAuth Web Flow – Default, opens browser for login.

- Personal Access Token (PAT) – For scripts, CI/CD, or manual token login.

- SSH – For Git operations (clone, push, pull).

- Git Credential Helper – Uses credentials already stored by Git.

- GitHub App / Enterprise Token – For GitHub Enterprise automation.

-------


#### Task 2: Working with Repositories
- Create a new GitHub repo directly from the terminal — make it public with a README

<img src="assets/1-3.png" width="600">

<img src="assets/1-4.png" width="600">

- Clone a repo using gh instead of git clone


<img src="assets/repo-clone.png" width="600">
- View details of one of your repos from the terminal

<img src="assets/repo-view.png" width="600">

- List all your repositories

<img src="assets/repo-list.png" width="600">

- Open a repo in your browser directly from the terminal
<img src="assets/repo-browser.png" width="600">

- Delete the test repo you created (be careful!)


<img src="assets/repo-delete.png" width="600">


-----

#### Task 3: Issues
- Create an issue on one of your repos from the terminal — give it a title, body, and a label



<img src="assets/issue-create-new.png" width="600">


- List all open issues on that repo


<img src="assets/issue-list.png" width="600">

- View a specific issue by its number


<img src="assets/view-num.png" width="600">
- Close an issue from the terminal


<img src="assets/issue-closed.png" width="600">


<img src="assets/issue-closed-1.png" width="600">


- How could you use gh issue in a script or automation?

**Answer**
1) Create an issue
2) List/view the issue
3) Update the issue
3) Close the issue


-----
#### Task 4: Pull Requests
- Create a branch, make a change, push it, and create a pull request entirely from the terminal

<img src="assets/pr-1.png" width="600">

<img src="assets/pr-2.png" width="600">

- List all open PRs on a repo

- View the details of your PR — check its status, reviewers, and checks

<img src="assets/pr-3.png" width="600">



- Merge your PR from the terminal

<img src="assets/pr-merge.png" width="600">



- What merge methods does gh pr merge support?
**Answer**
gh pr merge supports these merge methods:

1) Merge commit (--merge) – Creates a merge commit, keeps all commits from the branch.

2) Squash (--squash) – Combines all commits into a single commit on the base branch.

3) Rebase (--rebase) – Reapplies commits from the branch onto the base branch


- How would you review someone else's PR using gh?



**Answer**

- `gh pr review <PR-number>`
-----
#### Task 5: GitHub Actions & Workflows (Preview)
- List the workflow runs on any public repo that uses GitHub Actions
- View the status of a specific workflow run

<img src="assets/workflow-run-new.png" width="600">


- How could gh run and gh workflow be useful in a CI/CD pipeline?
**Answer**
`gh run` and `gh workflow` can be used in CI/CD pipelines to monitor, trigger, and manage GitHub Actions programmatically, no need to hadle the tasks manually.