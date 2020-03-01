#!/bin/bash

set -e

if [[ $EUID -eq 0 ]]; then
   echo "This script must not be run as root"! 
   exit 1
fi


if [ ! -f "build-config" ]
then
    echo "Build configuration file is missing!"
    echo "Create your own by copying the provided example:"
    echo
    echo "  cp build-config.dist build-config"
    echo
    echo "Then, edit the configuration appropriately!"
    exit 1
fi

. build-config
. scripts/functions.sh

start_timer

check_build_conf

check_prerequisities devscripts build-essential libpcap0.8-dev libsdl2-dev \
    libpng-dev libvdeplug-dev libreadline-dev

if [ ! -d "blinkenbone-repo" ]
then
    echo "Cloning the blinkenbone repository to ./blinkenbone-repo"
    git clone https://github.com/j-hoppe/BlinkenBone/ blinkenbone-repo
fi

if [ ! -d "simh-repo" ]
then
    echo "Cloning the (unofficial) simh repository to ./simh-repo"
    git clone https://github.com/desaster/simh-realcons-pdp11/ -b realcons simh-repo
fi

# if skipping version increment, assume we also don't want to switch
# branch/tag/commit
if [ "$SKIP_VERSION" != "1" ]
then
    echo "Switching to specified commit in the simh repository"
    git_switch_branch simh-repo "$SIMH_COMMIT"

    echo -n "Generating version number for simh package: "
    SIMH_VERSION=$(gen_git_version simh-repo "$DEB_VERSION_TAG")
    echo "$SIMH_VERSION"
    append_version build-simh "$SIMH_VERSION"

    echo "Switching to specified commit in the blinkenbone repository"
    git_switch_branch blinkenbone-repo "$BLINKENBONE_COMMIT"

    echo -n "Generating version number for blinkenbone package: "
    BB_VERSION=$(gen_git_version blinkenbone-repo "$DEB_VERSION_TAG")
    echo "$BB_VERSION"
    append_version build-blinkenlightd "$BB_VERSION"
fi

echo "Building simh package"
build_deb build-simh

echo "Building blinkenlightd package"
build_deb build-blinkenlightd

stop_timer

echo "Done."
