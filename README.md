# dotfiles

This repository holds an approach to modularizing Unix style configuration files, that traditionally are named in the pattern of `.${PROGRAM}rc`, and hence colloquially referred to as *dot files*.

The starting point is my personal need to make more sense of my various customizations of my `bash` environment across multiple computers.

## Quickstart for bash

- `git clone` the dotfiles repo
- add these lines at the end of your `.bash_profile`:

```bash
export DOTFILES_HOME=$HOME/dotfiles
source $DOTFILES_HOME/bash/engine
```
- create a manifest for this machine / user
  - create file `$DOTFILES_HOME/bash/.manifest` (there is an example file)
  - **OR** create symbolic links in `$DOTFILES_HOME/bash/.manifest.d/` to the modules in `$DOTFILES_HOME/bash/lib/`
- if necessary, create `$DOTFILES_HOME/bash/.private` (there is an example file)
- finally `source $HOME/.bash_profile` to enable your modularized configuration (or start a new login shell)

## Sensitive data

If you have any sensitive information (e.g. API keys), put them in `$DOTFILES_HOME/bash/.private`. This file has been added to `.gitignore`, so it shouldn't get published by accident.

## Machine / user specific data

If you have any machine and/or user specific information, i.e. this includes *which modules you want/need to load*, put them in `$DOTFILES_HOME/bash/.manifest`. This file has been added to `.gitignore`, so it shouldn't get published by accident.

Also a convenient way, is to just create symbolic links in `$DOTFILES_HOME/bash/.manifest.d/` to the modules in `$DOTFILES_HOME/bash/lib/`.

If you want to create symlinks for all the modules, try this:

```bash
cd $DOTFILES_HOME/bash/.manifest.d/
for f in ../lib/*; do ln -s $f; done
```

**Note:** Both, the manifest file *and* the manifest directory will be processed! This allows you to have other machine specific stuff in `.manifest`, which is not just about loading modules.

## Credits

This is inspired by and based on a [blog post by Wyatt Andersen](https://www.wyattandersen.com/development/2015/09/23/a-modular-self-managed-bash-profile.html), and also [his dot_files repo](https://github.com/lostphilosopher/dot_files).
