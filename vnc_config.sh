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
wget https://raw.githubusercontent.com/chautruongthinh/google_clouds/master/bluebird.tar.gz
wget https://raw.githubusercontent.com/chautruongthinh/google_clouds/master/elementary-xfce.tar.gz
sudo tar xzvf bluebird.tar.gz -C /usr/share/themes/
sudo tar xzvf elementary-xfce.tar.gz -C /usr/share/icons/
rm -rf bluebird.tar.gz
rm -rf elementary-xfce.tar.gz

#Chrome web browser
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update && sudo apt-get install google-chrome-stable


