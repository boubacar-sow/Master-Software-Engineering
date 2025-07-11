# Exercises

## A. Repo initialization and Basic workflow
Let's introduce you to Git's core concepts creating a local repository, making your first commit, and visualizing commit history. Hmm, sometimes, starting with Git can be very messy but don't worry!

1. Create a new repository locally
Open your editor (VS Code or another one) and enter a given folder, then let's create a new directory inside
```
mkdir git-practice && cd git-practice
git init
```
- ```mkdir git-practice```: creates a new directory named git-practice.
- ```cd git-practice```: moves into the new directory.
- ```git init```: initializes an empty Git repository, creating a ```.git/```folder that tracks your project history.
Often this ```.git/``` folder is not directly visible.

2. Let's have our first file and commit
Through the command line, there are many ways to create a file, we can do for example:
- ```touch README.md```: that will create an empty README.md file
- ```echo "# Hello, that's my first README file" > README.md```: the echo command writes a string into file. If the file doesn't exist, it will creates it and put into it the string.
- ```cat "Hello GIT" > README.md```: This command is the same as the previous, if the file already exists, it will simply append the text on its content, otherwise it will creates a new file.

Then we do:
```
git add README.md
git commit -m "initial commit"
````
- 📘 A ```README.md``` file is important in every GitHub project—it introduces and documents your project, including usage, installation, and purpose. This is the first thing people see when they visit your repository.

- 🛠️ Why is ```git add``` useful? It allows you to choose exactly which changes to include in the next commit. You don’t have to commit everything at once—you can work in small, focused steps.

- 🧱 Why commit? Commits are like save points in a game. Each one stores a complete snapshot of your project's state and includes a message explaining what changed. They help you track progress, revert changes, and collaborate smoothly.


3. Inspect history
```git log --online --graph```
- ```git log```: shows the commit history
- ```--online```: compresses each commit to one line (showing the hash and the message)
- ```--graph```: draws an ASCII art graph of branches and merges, helping visualize your commit tree.
The ```git log``` command is very important for ...