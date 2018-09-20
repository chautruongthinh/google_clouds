#!/bin/bash
myname="$0"
function help() {
    cat <<EOF
Syntax:
  $myname <device> <folder_of_rom>

for example:
$myname ef63 lineage-15.1

EOF
}


if [ -z "$2" ];then
	>&2 help
else

device=$1
sourcerom=$2
DATE="$(date +%Y%m%d)"
DAY="$(date +%d/%m/%Y)"
zip_path=~/$sourcerom/out/target/product/$device/*$DATE*.zip
set -e

if [ ! -d ~/CMupdater_API ];then
cd ~
git clone git@github.com:chautruongthinh/CMupdater_API.git -b $2
fi

if [ -d ~/CMupdater_API ];then
# datetime
timestamp=`cat ~/$sourcerom/out/target/product/$device/system/build.prop | grep ro.build.date.utc | cut -d'=' -f2`
timestamp_old=`cat ~/CMupdater_API/$device.json | grep "datetime" | cut -d':' -f2 | cut -d',' -f1`
`sed -i "s|$timestamp_old|$timestamp|g" ~/CMupdater_API/$device.json`

# filename
zip_name=`echo $zip_path | cut -d'/' -f9`
zip_name_old=`cat ~/CMupdater_API/$device.json | grep "filename" | cut -d':' -f2 | cut -d'"' -f2`
`sed -i "s|$zip_name_old|$zip_name|g" ~/CMupdater_API/$device.json`

# id
id=`md5sum $zip_path | cut -d' ' -f1`
id_old=`cat ~/CMupdater_API/$device.json | grep "id" | cut -d':' -f2 | cut -d'"' -f2`
`sed -i "s|$id_old|$id|g" ~/CMupdater_API/$device.json`

# Rom type
type=`echo $zip_path | cut -d'-' -f5`
type_old=`cat ~/CMupdater_API/$device.json | grep "romtype" | cut -d':' -f2 | cut -d'"' -f2`
`sed -i "s|$type_old|$type|g" ~/CMupdater_API/$device.json`

# Rom size
size_new=`stat -c "%s" $zip_path`
size_old=`cat ~/CMupdater_API/$device.json | grep "size" | cut -d':' -f2 | cut -d',' -f1`
`sed -i "s|$size_old|$size_new|g" ~/CMupdater_API/$device.json`

# Rom version
version=`echo $zip_path | cut -d'-' -f3`
version_old=`cat ~/CMupdater_API/$device.json | grep "version" | cut -d':' -f2 | cut -d'"' -f2`
`sed -i "s|$version_old|$version|g" ~/CMupdater_API/$device.json`

# url
url="https://master.dl.sourceforge.net/project/chautruongthinh/$sourcerom/$zip_name"
url_old=`cat ~/CMupdater_API/$device.json | grep https | cut -d '"' -f4`
`sed -i "s|$url_old|$url|g" ~/CMupdater_API/$device.json`

# add & push commit to github
cd CMupdater_API
git add --all
git commit -m "$device: update $DAY"
git push -f origin HEAD:$sourcerom
cd ~
fi

fi
