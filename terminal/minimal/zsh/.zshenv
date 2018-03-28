export PATH=$HOME/local/bin:$PATH:$HOME/.virtualenvs/global_virtualenv/bin:
if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ];
then
	source $HOME/.nix-profile/etc/profile.d/nix.sh
fi

if [ -d $HOME/.pyenv ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
fi

if [ -d $HOME/freckles/bits-and-pieces/scripts ]; then
    export PATH="$HOME/freckles/bits-and-pieces/scripts:$PATH"
fi

#export CDPATH=".:$HOME/projects:$HOME/projects/repos:$HOME/projects/repos/adapters_extra:$HOME/Documents:$HOME/Documents/notes:$HOME/projects/freckles/freckles/external:$HOME/projects/freckles/freckles/external/:$CDPATH"

export XDG_DATA_DIRS=$HOME/.nix-profile/share:/usr/local/share/:/usr/share

GPG_TTY=$(tty)
export GPG_TTY

export GTAGSLABEL=pygments
