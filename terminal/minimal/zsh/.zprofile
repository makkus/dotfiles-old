emulate sh
. ~/.profile
emulate zsh

# add inaugurate environment
LOCAL_BIN_PATH="$HOME/.local/bin"
if [ -d "$LOCAL_BIN_PATH" ]; then
    PATH="$PATH:$LOCAL_BIN_PATH"
fi
