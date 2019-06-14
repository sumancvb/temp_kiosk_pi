#!/bin/sh

echo "****************************************************"
echo "Uninstalling Raspberry pi kiosk"
echo "****************************************************"

cat > /etc/xdg/lxsession/LXDE-pi/autostart <<'EOF'
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
point-rpi
EOF

sudo rm -r /home/pi/kiosk*
sudo rm -r /home/pi/setup*

sudo reboot
