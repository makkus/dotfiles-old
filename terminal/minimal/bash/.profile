LOG="$HOME/profile-invocations"
echo "-----" >>$LOG
echo "Caller: $0" >>$LOG
echo "DESKTOP_SESSION: $DESKTOP_SESSION" >>$LOG
echo "GDMSESSION: $GDMSESSION" >>$LOG

export MANPATH=${HOME}/.local/share/man:$MANPATH
export PATH=/home/markus/local/bin:/home/markus/.local/bin:/home/markus/.local/apps:/usr/local/bin:/opt/idea/bin:/opt/mvn/bin:$PATH:$HOME/.virtualenvs/global_virtualenv/bin:$HOME/.virtualenvs/global-dev/bin
export PYTHONPATH=$HOME/.nix-profile/lib/python2.7/site-packages

GPG_TTY=$(tty)
export GPG_TTY

export GOPATH="/home/markus/local/share/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

#export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"

export XDG_DATA_DIRS=/home/markus/.nix-profile/share:/usr/local/share/:/usr/share

export GTAGSLABEL=pygments

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    LOCALE_ARCHIVE=$(readlink ~/.nix-profile/lib/locale/locale-archive)
    export LOCALE_ARCHIVE
fi # added by Nix installer

# add inaugurate environment
INAUGURATE_PATH="$HOME/.local/bin"
if [ -d "$INAUGURATE_PATH" ]; then
    PATH="$PATH:$INAUGURATE_PATH"
fi

export LOCALE_ARCHIVE="$(readlink ~/.nix-profile/lib/locale)/locale-archive"
