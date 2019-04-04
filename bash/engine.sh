# This is the actual engine for bash profile customizations
#
# Each module should go into a single script file in the
# $DOTFILES_HOME/bash/lib/ folder.

DOTFILES_HOME=${DOTFILES_HOME:-$HOME/dotfiles}


# Load a module and give status information
dotfiles_load_module () {
    local module=$1
    local module_file=$DOTFILES_HOME/bash/lib/$module
    echo -e -n "Loading module \033[0;36m$module\033[m ... "
    if [[ -r $module_file ]]
    then
        if source $module_file
        then
            echo -e "\033[0;32mOK\033[m"
            return 0
        else
            echo -e "\033[0;31mFAIL\033[m"
            return 1
        fi
    else
        echo -e "\033[0;33mMISSING\033[m"
        return 2
    fi
}


dotfiles_load_manifest () {
    local symlink
    local module
    local f
    # load manifest file
    [[ -r $DOTFILES_HOME/bash/.manifest ]] && source $DOTFILES_HOME/bash/.manifest 

    # load manifest directory
    if [[ -d $DOTFILES_HOME/bash/.manifest.d ]]
    then
        for f in $DOTFILES_HOME/bash/.manifest.d/*
        do
            if [[ ! -L $f ]]
            then
                echo -e "\033[0;33mWARNING\033[m not a symbolic link: $f"
                continue
            fi
            symlink=$(readlink $f)
            module=${symlink##*/}
            if [[ ! $DOTFILES_HOME/bash/lib/$module -ef $f ]]
            then
                echo -e "\033[0;33mWARNING\033[m link does not point to a module: $f"
                continue
            fi
            dotfiles_load_module $module
        done
    fi
}


# silently try to load sensitive data
# that is why it's sourcing directly as opposed to using the functions
[[ -r $DOTFILES_HOME/bash/.private ]] && source $DOTFILES_HOME/bash/.private

# now load and process this computer's / user's manifest
dotfiles_load_manifest
