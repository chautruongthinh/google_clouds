#!/bin/bash
sudo apt-get update
sudo apt-get install xfce4 xfce4-goodies tightvncserver
vncserver
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
wget -O ~/.vnc/xstartup https://raw.githubusercontent.com/chautruongthinh/google_clouds/master/xstartup
sudo wget -O /etc/init.d/vncserver https://raw.githubusercontent.com/chautruongthinh/google_clouds/master/vncserver
sudo chmod +x ~/.vnc/xstartup
sudo chmod +x /etc/init.d/vncserver
sudo service vncserver start

