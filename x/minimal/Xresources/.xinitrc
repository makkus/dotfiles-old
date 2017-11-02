#!/bin/bash

if [ -f ~/.profile ]; then
	. ~/.profile
fi

# Test if $1 is available
isavailable() {
    type "$1" &>/dev/null
}

xrdb -merge ~/.Xresources
xkbcomp -I$HOME/dotfiles/x/minimal/xkb $HOME/dotfiles/x/minimal/xkb/keymap/filco $DISPLAY

xmodmap ~/dotfiles/misc/Xmodmap_arrows

isavailable autocutsel && {
    autocutsel -fork &
    autocutsel -selection PRIMARY -fork &
}

isavailable redshift && redshift &

#isavailable udiskie && udiskie --tray --use-udisks2 &

echo $PATH > /tmp/path

#~/.screenlayout/desk.sh

#pkill -9 gpg-agent eval $(gpg-agent --daemon --enable-ssh-support --sh)

xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200

SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;

#killall gpg-agent
#eval $(gpg-agent --daemon --sh --write-env-file=/home/markus/.gnupg/gpg-agent-info)
#export GPG_AGENT_INFO
#export SSH_AUTH_SOCK
#export SSH_AGENT_PID

#GPG_AGENT_PID=$SSH_AGENT_PID
#export GPG_AGENT_PID

#systemctl --user import-environment XDG_CONFIG_HOME PATH DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS SSH_AUTH_SOCK GPG_TTY

#systemctl --user restart emacs
exec i3
