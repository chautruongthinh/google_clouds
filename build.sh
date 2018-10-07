#!/bin/bash

## device
read -p "Please enter your device code name: " device

## source
read -p "Please enter your folder source do want compile: " sourcerom

## make clean
read -p "Do you want to make clean befone compile? (y/N) " makeclean

## sync source
read -p "Do you want to sync? (y/N) " syncsource

## upload
read -p "Do you want to upload to sourceforge? (y/N) " upload

function jack_env() {
    RAM=$(free | awk '/^Mem:/{ printf("%0.f", $2/(1024^2))}') #calculating how much RAM (wow, such ram)
    if [[ "$RAM" -lt 16 ]];then #if we're poor guys with less than 16gb
	export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx"$((RAM -1))"G"
    fi
}

function sync_repo() {
    repo sync -j16 --force-sync
}

function upload() {
    DATE="$(date +%Y%m%d)"
    scp ~/$sourcerom/out/target/product/$device/*$DATE*.zip chautruongthinh@frs.sourceforge.net:/home/frs/project/chautruongthinh/$sourcerom/
}

function makeclean() {
    make clean
}

        cd ~/$sourcerom

if [[ $syncsource == *"y"* ]];then
sync_repo
fi
        # Export
	export LC_ALL=C
        export WITH_SU=TRUE
        export USE_CCACHE=1
	export CCACHE_COMPRESS=1

        ./prebuilts/sdk/tools/jack-admin kill-server
        ./prebuilts/sdk/tools/jack-admin start-server

        # Compile rom
        . build/envsetup.sh 
if [[ $makeclean == *"y"* ]];then
makeclean
fi
	brunch $device

if [[ $upload == *"y"* ]];then
upload
fi

cd ~
