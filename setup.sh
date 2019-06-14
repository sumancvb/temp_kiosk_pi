#!/bin/sh

echo "****************************************************"
echo "Updating the package database"
echo "****************************************************"

sudo apt-get -q update

sudo apt-get -yq install curl
sudo adduser --system --group test1
sudo gpasswd -a "$USER" test1

echo "****************************************************"
echo "Creating test1.service"
echo "****************************************************"

cat > /etc/systemd/system/test1.service <<'EOF'
[Unit]

Description=A simple pi application
After=network-online.target

[Service]
Type=simple
User=test1
Group=test1
UMask=007

ExecStart=/usr/bin/deluged -d

Restart=on-failure

# Configures the time to wait before service is stopped forcefully.
TimeoutStopSec=300

[Install]
WantedBy=multi-user.target
EOF

echo "****************************************************"
echo "Starting test1.service "
echo "****************************************************"
systemctl daemon-reload
systemctl start test1
systemctl enable test1
