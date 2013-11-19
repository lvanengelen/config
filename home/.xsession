export PATH="$PATH:$HOME/.local/bin"

if [ -r $HOME/.Xresources ]; then
    xrdb $HOME/.Xresources
fi

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval `dbus-launch --auto-syntax --exit-with-session`
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval `ssh-agent`
fi

setxkbmap -layout "us,ru" \
          -variant base \
          -option grp:shift_caps_toggle \
          -option lv3:ralt_switch_grp \
          -option eurosign:5 \
          -option compose:menu

xsetwacom --set "Wacom BambooPT 2FG 4x5 Finger touch" Touch off

exec spectrwm
