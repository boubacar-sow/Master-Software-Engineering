# Git Conflicts, Merges, and Rebases – Step by Step

Let’s walk through conflicts, merges, and rebases in Git step by step—just like in a live coding tutorial. We’ll cover:

1. **Why conflicts happen**  
2. **How to detect and resolve a conflict after a merge**  
3. **What to do if `main` moved on while you were working**  
4. **How rebasing works and how to rebase safely**  
5. **When to choose merge vs. rebase**  

---

## 1. Why Conflicts Happen

A **conflict** arises whenever Git can’t automatically stitch together changes from two branches because they both edited the same part of a file (or closely related parts).

- Branch **A** changes lines 10–12 in `foo.txt`.  
- Branch **B** also changes those same lines in a different way.  
- Git doesn’t know which version you want––so it stops and asks you to choose.

> **Tip:** The smaller and more focused your branches/PRs are, the less likely you are to accidentally overlap with someone else’s work.

---

## 2. Detecting & Resolving a Conflict After a Merge

### a) Simulate a Conflict

```bash
# 1. Start on main and add a line
echo "Hello from main" >> greetings.txt
git add greetings.txt
git commit -m "chore: add greeting on main"

# 2. Create feature branch and change the same file
git checkout -b feature/greet
echo "Hello from feature" >> greetings.txt
git add greetings.txt
git commit -m "feat: add feature greeting"

# 3. Back to main and modify the same place differently
git checkout main
echo "Another hello on main" >> greetings.txt
git add greetings.txt
git commit -m "feat: add another greeting on main"

# 4. Try merging feature into main (will produce a conflict)
git merge feature/greet
```

---

### b) Inspect the Conflict Markers

Open `greetings.txt` in your editor. You’ll see:

```diff
<<<<<<< HEAD
Hello from main
Another hello on main
=======
Hello from feature
>>>>>>> feature/greet
```

- `<<<<<<< HEAD`: your current branch’s version (main)  
- `=======`: separator  
- `>>>>>>> feature/greet`: the incoming branch’s version

---

### c) Choose or Combine Changes

Edit the file to your desired final content. For example:

```text
Hello from main
Another hello on main
Hello from feature
```

Or rewrite completely:

```text
Greetings combined from main and feature!
```

---

### d) Finalize the Merge

```bash
git add greetings.txt
git commit -m "fix: resolve merge conflict between main and feature/greet"
```

Git will complete the merge, creating a merge commit that records both histories.

---

## 3. Keeping Your Feature Branch Up to Date

Let’s say you’ve been working on `feature/greet`, but meanwhile, other commits landed on `main`. Before merging back, incorporate those changes into your branch.

### Option A: Merge `main` into Your Feature

```bash
git checkout feature/greet
git merge main
```

- Resolve any conflicts here (repeat steps 2b–2d if needed)

---

### Option B: Rebase Your Feature onto `main`

```bash
git checkout feature/greet
git rebase main
```

If you hit conflicts:

```bash
# After fixing files:
git add <fixed-files>
git rebase --continue
```

Both options bring in the latest `main` commits:  
- **Merge** preserves a merge commit  
- **Rebase** gives a linear history

---

## 4. Rebasing: Linear History & Safe Practices

Rebasing “replays” your feature commits onto the tip of `main`:

```bash
git checkout feature/greet
git rebase main
```

On conflict at a commit, Git pauses:

```bash
# Fix the conflict
git add <fixed-files>
git rebase --continue
```

Repeat until done.

To abort mid‑rebase and return to the pre‑rebase state:

```bash
git rebase --abort
```

Once the rebase finishes, you can do a fast-forward merge:

```bash
git checkout main
git merge feature/greet --ff-only
```

> **Safety Tip:** Only rebase private branches you haven’t shared. Never rebase public history without coordination.

---

## 5. Merge vs. Rebase: When to Use Which

| Criterion            | Merge                         | Rebase                              |
|----------------------|-------------------------------|--------------------------------------|
| History clarity      | Preserves full history        | Produces a straight‑line history     |
| Merge commits        | Creates a merge commit        | No merge commits                     |
| Conflict handling    | One time at merge             | May have multiple during rebase      |
| Collaboration safety | Safe on any branch            | Only safe on private branches        |

- Use **merge** for shared branches and to preserve context.  
- Use **rebase** for a clean, linear history on private feature branches.

---

## ✅ Key Takeaways

- Conflicts occur on overlapping edits; Git flags them with `<<<<<<<`, `=======`, `>>>>>>>`.
- Resolve by editing the markers, then run `git add` + `git commit` (or `git rebase --continue`).
- Keep your feature branch up to date by merging or rebasing from `main`.
- Rebase for cleaner history; merge to preserve context.
- **Always test after resolving conflicts** to ensure nothing broke.

---

**Happy coding!**