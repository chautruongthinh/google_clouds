#!/bin/bash
sudo apt-get install xfce4 xfce4-goodies tightvncserver -y
vncserver
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
curl https://raw.githubusercontent.com/chautruongthinh/google_clouds/ubuntu_16.0.4/xstartup --output ~/.vnc/xstartup
sudo chmod +x ~/.vnc/xstartup
curl -O https://raw.githubusercontent.com/chautruongthinh/google_clouds/ubuntu_16.0.4/vncserver@.service
sudo mv vncserver@.service /etc/systemd/system/vncserver@.service
sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service
vncserver -kill :1
sudo systemctl start vncserver@1

#Themes
curl -O https://raw.githubusercontent.com/chautruongthinh/google_clouds/ubuntu_16.0.4/bluebird.tar.gz
curl -O https://raw.githubusercontent.com/chautruongthinh/google_clouds/ubuntu_16.0.4/elementary-xfce.tar.gz
sudo tar xzvf bluebird.tar.gz -C /usr/share/themes/
sudo tar xzvf elementary-xfce.tar.gz -C /usr/share/icons/
rm -rf bluebird.tar.gz
rm -rf elementary-xfce.tar.gz

