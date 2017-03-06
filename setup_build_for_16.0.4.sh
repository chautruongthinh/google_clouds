#!/bin/bash
sudo apt-get update
sudo apt-get install openjdk-8-jdk
sudo apt-get install phablet-tools git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip schedtool meld lzop maven -y
mkdir cm-14.1 && cd cm-14.1
git config --global user.name "Chau Truong Thinh"
git config --global user.email "chautruongthinh@gmail.com"
repo init -u git://github.com/LineageOS/android.git -b cm-14.1
git clone https://github.com/chautruongthinh/local_manifests.git -b cm-14.1 .repo/local_manifests
repo sync -j32
cd ~

# use ccache
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
~/cm-14.0/prebuilts/misc/linux-x86/ccache/ccache -M 50G
echo -e "export USE_CCACHE=1 \nexport CCACHE_DIR=~/.ccache" >> .bashrc

# Google Drive
wget https://docs.google.com/uc?id=0B3X9GlR6EmbnWksyTEtCM0VfaFE&export=download
mv uc\?id\=0B3X9GlR6EmbnWksyTEtCM0VfaFE gdrive
chmod +x gdrive
sudo install gdrive /usr/local/bin/gdrive
rm -rf gdrive

