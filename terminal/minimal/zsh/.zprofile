emulate sh
. ~/.profile
emulate zsh

# add inaugurate environment
LOCAL_BIN_PATH="$HOME/.local/bin"
if [ -d "$LOCAL_BIN_PATH" ]; then
    PATH="$PATH:$LOCAL_BIN_PATH"
fi

# add appImage path
APP_IMAGE_PATH="$HOME/.local/apps"
if [ -d "$APP_IMAGE_PATH" ]; then
    PATH="$PATH:$APP_IMAGE_PATH:$PATH"
fi
