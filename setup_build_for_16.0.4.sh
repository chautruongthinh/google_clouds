#!/bin/bash
sudo apt-get update
sudo apt-get install openjdk-8-jdk phablet-tools git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip schedtool meld lzop maven -y
mkdir lineage-15.1 && cd lineage-15.1 
git config --global user.name "Chau Truong Thinh"
git config --global user.email "chautruongthinh@gmail.com"
repo init -u git://github.com/LineageOS/android.git -b lineage-15.1
git clone https://github.com/chautruongthinh/local_manifests.git -b lineageos .repo/local_manifests
repo sync -j32
cd ~

# use ccache
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
~/cm-14.1/prebuilts/misc/linux-x86/ccache/ccache -M 50G
echo -e "export USE_CCACHE=1 \nexport CCACHE_DIR=~/.ccache" >> .bashrc

curl -O https://raw.githubusercontent.com/chautruongthinh/google_clouds/ubuntu_16.0.4/build.sh


