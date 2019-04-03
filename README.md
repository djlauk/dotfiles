# dotfiles

This repository holds an approach to modularizing Unix style configuration files, that traditionally are named in the pattern of `.${PROGRAM}rc`, and hence colloquially referred to as *dot files*.

The starting point is my personal need to make more sense of my various customizations of my `bash` environment across multiple computers.

## Sensitive data

If you have any sensitive information (e.g. API keys), put them in `~/dotfiles/bash/.private`. This file has been added to `.gitignore`, so it shouldn't get published by accident.

## Credits

This is inspired by and based on a [blog post by Wyatt Andersen](https://www.wyattandersen.com/development/2015/09/23/a-modular-self-managed-bash-profile.html), and also [his dot_files repo](https://github.com/lostphilosopher/dot_files).
