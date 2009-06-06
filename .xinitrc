#!/bin/sh

errfile="$HOME/.xsession-errors"
if cp /dev/null "$errfile" 2> /dev/null ; then
    chmod 600 "$errfile"
    exec > "$errfile" 2>&1
else
    errfile=$(mktemp -q /tmp/xses-$USER.XXXXXX)
    if [ $? -eq 0 ]; then
        exec > "$errfile" 2>&1
    fi
fi

cat /dev/null > $HOME/.xsel.log
xrdb -merge $HOME/.Xresources
xset -b
xset r rate 250 30 &>/dev/null
xset +fp $HOME/.fonts

setxkbmap -layout us -model evdev -rules xorg -option ctrl:nocaps

urxvtd -q -o -f
numlockx &
unclutter -idle 2 -notclass Iceweasel -notclass Firefox &
mpdscribble --no-daemon &

eval $(cat $HOME/.fehbg)

s-t code shells tor &

firefox &

GIT_DIR=$DOTFILE_LOCAL/.git \
    GIT_WORK_TREE=$DOTFILE_LOCAL \
    git checkout .ion3/default-session--0/saved_layout.lua &>/dev/null

ion3
