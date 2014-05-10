# Terminal applications already get their environment from .profile, because we
# use login shells in XTerms.  For other applications though, we have to setup
# the environment here.
export PATH="$PATH:$HOME/.local/bin"
export LC_CTYPE=en_US.UTF-8
export PRINTER=rp

if [ -r $HOME/.Xresources ]; then
    xrdb $HOME/.Xresources
fi

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval `dbus-launch --auto-syntax --exit-with-session`
fi

setxkbmap -layout "us,ru" \
          -variant base \
          -option grp:shift_caps_toggle \
          -option lv3:ralt_switch_grp \
          -option eurosign:5 \
          -option compose:menu

synclient TapButton1=1 PalmDetect=1

exec spectrwm
