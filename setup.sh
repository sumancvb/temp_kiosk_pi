#!/bin/sh

echo "****************************************************"
echo "Updating the package database"
echo "****************************************************"
sudo apt-get clean
sudo apt-get autoremove -y
sudo apt-get -q update
sudo apt-get -yq install xdotool unclutter sed

cat > /home/pi/kiosk.sh <<'EOF'
#!/bin/bash
xset s noblank
xset s off
xset -dpms

unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

/usr/bin/chromium-browser --noerrdialogs --disable-infobars --kiosk https://fast.com &
#/usr/bin/chromium-browser --noerrdialogs --disable-infobars --kiosk https://192.168.1.17 &

while true; do
   xdotool keydown ctrl+r; xdotool keyup ctrl+r;
   sleep 10
done
sudo chmod +x /home/pi/kiosk.sh
EOF
cat > /etc/xdg/lxsession/LXDE-pi/autostart <<'EOF'
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
#@xscreensaver -no-splash
point-rpi
@bash /home/pi/kiosk.sh

EOF
sudo reboot
