if ! fuser -s "/tmp/emacs$(id -u)/server" &>/dev/null; then
        echo "Starting Emacs daemon for $USER"
        emacs --daemon &>/dev/null
fi
