  GNU nano 2.5.3                                                        File: build.sh                                                                                                            Modified  

#!/bin/bash
if [ -z "$1"  ]; then
        echo "USAGE: $0 <device> <rom_name> <sync> <upload>"
        echo "Example: $0 ef63 lineage-15.1 sync upload"
else

        # Get correct RAM size (divided by 0)
        get_round_number() {
        echo $((($1 + $2/2) / $2)) 
}

        cd ~/$2

        # Syncing source
        if [ "$3" == "sync" ]; then
                repo sync -j8 --force-sync
        fi

        # Export
        export WITH_SU=TRUE
        export USE_CCACHE=1

        raw_size=$(free -h | grep -e "^Mem:" | sed -e 's/^Mem: *//' -e 's/G//' -e 's/  *.*//')
        ram_size=$(($(get_round_number $raw_size 1) + 1))
        export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx${ram_size}g"
        ./prebuilts/sdk/tools/jack-admin kill-server
        ./prebuilts/sdk/tools/jack-admin start-server

        # Compile rom
        . build/envsetup.sh 
        make clean && brunch $1
        cd ~

        # Upload rom Sourceforge
        if [ "$4" == "upload" ]; then
        scp ~/$2/out/target/product/$1/$2*.zip chautruongthinh@frs.sourceforge.net:/home/frs/project/chautruongthinh/$2/
        fi

fi

sudo poweroff
