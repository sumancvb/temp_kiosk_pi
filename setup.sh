#!/bin/sh

echo "****************************************************"
echo "Updating the package database"
echo "****************************************************"

sudo apt-get -q update

sudo apt-get -yq install curl chromium-browser unclutter lxde

cat > /home/pi/.config/lxsession/LXDE/autostart <<'EOF'
@xset s off
@xset -dpms
@xset s noblank
@sed -i 's/"exited_cleanly": false/"exited_cleanly": true/' ~/.config/chromium-$
@chromium-browser --noerrdialogs --kiosk https://fast.com --disable-translate

EOF
