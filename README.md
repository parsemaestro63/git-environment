# Git Environment Setup
The program is a utility to provision your Git environment, setting up necessary (and useful) global parameters.
Specifically, the utility sets up your global name, email, auto-rebase to true, and branch matching settings.
In addition, it can optionally create aliases for short-cut Git commands. 

## Assumptions
There is criteria to meet in order to execute the script successfully. 

1. Git is available on your system.
2. Your OS is one of MacOs or Ubuntu

\* This is only tested on Mac and Ubuntu distributions.

## Installation & Running
1. Firstly, clone the repo.

```
git clone git@github.com:parsemaestro63/git-environment.git

```

2. Once the repository is cloned, simply run
   
```
cd Git
./gitSetup.sh [--create-alias]
```

## Aliases
Optionally, you can create short-cuts to ease common operations, e.g., `git status` to `gstat`. Simply pass a
`--create-alias` option.

See `aliases.sh` for a list of aliases that will be created. 
