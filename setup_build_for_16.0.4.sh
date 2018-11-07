#!/bin/bash
set -e
sudo timedatectl set-timezone Asia/Ho_Chi_Minh

## Select rom
function menurom() {
 cat <<EOF
Please select rom do you want to setup:
(1) Lineage OS
(2) ResurrectionRemix
(3) DotOS
(4) crDroid Rom
(5) Omnirom

EOF
}
clear
menurom
read -p "Please enter the number of your choice: " rom

## Select branch
if [ "$rom" == "1" ];then
function branchrom() {
 cat <<EOF

Please select branch of rom:
(1) cm-14.1
(2) lineage-15.1
(3) lineage-16.0

EOF
}
branchrom
read -p "Please enter the number of your choice: " branchlos

elif [ "$rom" == "2" ];then
function branchrom() {
 cat <<EOF

Please select branch of rom:
(1) marshmallow
(2) nougat
(3) oreo
(4) pie

EOF
}
branchrom
read -p "Please enter the number of your choice: " branchrr

elif [ "$rom" == "3" ];then
function branchrom() {
 cat <<EOF

Please select branch of rom:
(1) dot-n
(2) dot-o
(3) dot-p

EOF
}
branchrom
read -p "Please enter the number of your choice: " branchdot

elif [ "$rom" == "4" ];then
function branchrom() {
 cat <<EOF

Please select branch of rom:
(1) 7.1
(2) 8.0
(3) 8.1
(4) 9.0

EOF
}
branchrom
read -p "Please enter the number of your choice: " branchcr

elif [ "$rom" == "5" ];then
function branchrom() {
 cat <<EOF

Please select branch of rom:
(1) android-7.1
(2) android-8.0
(3) android-8.1
(4) android-9.1

EOF
}
branchrom
read -p "Please enter the number of your choice: " branchomni

fi

## clone manifest
# function clone() {
# if [ -d .repo/local_manifests ];then
#    rm -rf .repo/local_manifests
#    git clone git://github.com/chautruongthinh/local_manifests.git -b $branch .repo/local_manifests
# fi
# }
# cat <<EOF

# EOF
# read -p "Do you want to clone local_manifest of ef63? (y/N) " clone

#Install packages:
sudo apt-get update
sudo apt-get install openjdk-8-jdk phablet-tools git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip schedtool meld lzop maven bc -y
git config --global user.name "Chau Truong Thinh"
git config --global user.email "chautruongthinh@gmail.com"
git config --global color.ui auto

#LOS
if [ "$branchlos" == "1" ];then
	mkdir -p cm-14.1
	cd cm-14.1
	repo init -u git://github.com/LineageOS/android.git -b cm-14.1
elif [ "$branchlos" == "2" ];then
	mkdir -p lineage-15.1
	cd lineage-15.1
	repo init -u git://github.com/LineageOS/android.git -b lineage-15.1
elif [ "$branchlos" == "3" ];then
	mkdir -p lineage-16.0
	cd lineage-16.0
	repo init -u git://github.com/LineageOS/android.git -b lineage-16.0
fi

#RR
if [ "$branchrr" == "1" ];then
	mkdir -p rr-marshmallow
	cd rr-marshmallow
	repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow
elif [ "$branchrr" == "2" ];then
	mkdir -p rr-nougat
	cd rr-nougat
	repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b nougat
elif [ "$branchrr" == "3" ];then
	mkdir -p rr-oreo
	cd rr-oreo
	repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b oreo
elif [ "$branchrr" == "4" ];then
	mkdir -p rr-pie
	cd rr-pie
	repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b pie
fi

#DOT
if [ "$branchdot" == "1" ];then
	mkdir -p dot-n
	cd dot-n
	repo init -u git://github.com/DotOS/manifest.git -b dot-n
elif [ "$branchdot" == "2" ];then
	mkdir -p dot-o
	cd dot-o
	repo init -u git://github.com/DotOS/manifest.git -b dot-o
elif [ "$branchdot" == "3" ];then
	mkdir -p dot-p
	cd dot-p
	repo init -u git://github.com/DotOS/manifest.git -b dot-p
fi

#crDroid
if [ "$branchcr" == "1" ];then
	mkdir -p crDroid-7.1
	cd crDroid-7.1
	repo init -u git://github.com/crdroidandroid/android.git -b 7.1
elif [ "$branchcr" == "2" ];then
	mkdir -p crDroid-8.0
	cd crDroid-8.0
	repo init -u git://github.com/crdroidandroid/android.git -b 8.0
elif [ "$branchcr" == "3" ];then
	mkdir -p crDroid-8.1
	cd crDroid-8.1
	repo init -u git://github.com/crdroidandroid/android.git -b 8.1
elif [ "$branchcr" == "4" ];then
	mkdir -p crDroid-9.0
	cd crDroid-9.0
	repo init -u git://github.com/crdroidandroid/android.git -b 9.0
fi

#Omnirom
if [ "$branchomni" == "1" ];then
	mkdir -p omnirom-7.1
	cd omnirom-7.1
	repo init -u git://github.com/omnirom/android.git -b android-7.1
elif [ "$branchomni" == "2" ];then
	mkdir -p omnirom-8.0
	cd omnirom-8.0
	repo init -u git://github.com/omnirom/android.git -b android-8.0
elif [ "$branchomni" == "3" ];then
	mkdir -p omnirom-8.1
	cd omnirom-8.1
	repo init -u git://github.com/omnirom/android.git -b android-8.1
elif [ "$branchomni" == "4" ];then
	mkdir -p omnirom-9.0
	cd omnirom-9.0
	repo init -u git://github.com/omnirom/android.git -b android-9.0
fi


# if [[ $clone == *"y"* ]];then
# clone
# fi

repo sync -j32 --force-sync

if [ -d prebuilts/misc/linux-x86/ccache ];then
prebuilts/misc/linux-x86/ccache/ccache -M 50G
fi

cd ~
# use ccache
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
echo -e "export USE_CCACHE=1 \nexport CCACHE_DIR=~/.ccache" >> ~/.bashrc

curl -O https://raw.githubusercontent.com/chautruongthinh/google_clouds/ubuntu_16.0.4/build.sh
curl -O https://raw.githubusercontent.com/chautruongthinh/google_clouds/ubuntu_16.0.4/creat_ota_commit.sh

## compile rom
function build() {
bash ~/build.sh
}

read -p "Do you want to compile rom now? (y/N) " build
if [[ $build == *"y"* ]];then
build
fi



