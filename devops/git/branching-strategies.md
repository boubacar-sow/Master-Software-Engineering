# B. Branching and Merging
Often in software engineering, especially when working in a collaborative or enterprise environment, branching is a fundamental part of the workflow. It allows developers to work on different features, fixes, or experiments independently without interfering with the stable version of the code (usually on the ```main``` branch).

### 1. Create a feature branch
```git chechout -b feature/login```
- ```git chechout -b feature/login```: creates and switches to a new branch named ```feature/login```in one step. The ```-b``` option stands for "branch".
- Behind the scenes, this tells Git: “Create a new pointer (```feature/login```) starting from my current commit (usually on main) and move me to that branch.”
- Branching is helpful because it allows parallel development. For instance, one developer can work on a login feature while another works on a dashboard, without interfering with each other's changes.

### 2. Make changes, commit, and switch back
```
echo "function login() {} > auth.js
git add auth.js
git commit -m "feat: add stub login function"
git checkout main
```
- Create a file named ``auth.js``` using the ``echo``` command, containing a stubbed function
- ```git add auth.js```: Stages the new file. Git tracks changes only after they've been added (staged).
- ```git commit -m "feat: add stub login function"```: Commits the staged change. We use ```feat```: to follow conventional commit formats, indicating this is a new feature.
- ```git checkout main```: Switches back to the main branch. The ```checkout``` command moves your HEAD (your current position in Git history) to another branch or commit.

### How to merge changes made on a branch to the main
```git merge --no-ff feature/login -m "merge feature/login"```
- ```git merge feature/login```: brings changes from ```feature/login``` into ```main```. Git will try to apply all the commits made on the feature branch onto the target branch.
- ```--no-ff```: Stands for "no fast-forward".

Without this flag, if main hasn't moved since the branch was created, Git will just move main's pointer forward to the same commit as ```feature/login```—this is a fast-forward merge.

Using ```--no-ff``` tells Git to always create a merge commit, even if a fast-forward is possible. This keeps the fact that a separate branch existed visible in history, which can make it easier to review and understand development workflows.

### Bonus Tip: Checking branch history visually
Use the following command to see a tree-like view of your branches and commits
```git log --oneline --graph --all --decorate```
This show a visual represetnation of how branches diverged and merged which is very useful for understanding what's happening in your repository.
