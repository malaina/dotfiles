#!/bin/zsh

umask 077

eval $(dircolors -b $HOME/.dircolors)  &>/dev/null

export HISTCONTROL=ignoredups

export PATH=$PATH:$HOME/bin:$HOME/local/bin:/usr/sbin:/usr/local/sbin:
export INFOPATH=$INFOPATH:$HOME/local/share/info:
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/local/lib:
export MANPATH=$MANPATH:$HOME/local/share/man:
export PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig:

typeset -T INFOPATH infopath
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -T PKG_CONFIG_PATH pkg_config_path

typeset -U path infopath ld_library_path manpath pkg_config_path

export LANG=en_AU.utf8
export LC_ALL=en_AU.utf8
export LC_COLLATE=en_AU.utf8
export LC_CTYPE=en_AU.utf8
export LOCALE=en_AU.utf8
export LESSCHARSET=utf-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=AS

editors=(ootput-editor emacsclient mg)
for editor in $editors; do
    if which "$editor" &> /dev/null; then
        export EDITOR="$editor"
        export VISUAL=$EDITOR
        alias e=$EDITOR
        break
    fi
done

pagers=(most less more)
for pager in $pagers; do
    if which "$pager" &> /dev/null; then
        export PAGER="$pager"
        export MANPAGER=$PAGER
        break
    fi
done

CHOST="x86_64-pc-linux-gnu"
CFLAGS="-march=core2 -O2 -pipe -msse4.1"
CXXFLAGS="$CFLAGS"
MAKEOPTS="-j5"
