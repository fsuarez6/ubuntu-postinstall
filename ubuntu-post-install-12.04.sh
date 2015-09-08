#!/bin/bash
# TODO: Phantom omni
#
# Authors:
#   Francisco Suarez-Ruiz <www.romin.upm.es/fsuarez>
#
# Description:
#   A post-installation bash script for Ubuntu (12.04)

echo ''
echo '#-------------------------------------------#'
echo '#     Ubuntu 12.04 Post-Install Script      #'
echo '#-------------------------------------------#'

#----- FUNCTIONS -----#

# SYSTEM UPGRADE
function sysupgrade {
# Perform system upgrade
echo ''
read -p 'Proceed with system upgrade? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* )
    # Update repository information
    echo 'Updating repository information...'
    echo 'Requires root privileges:'
    sudo apt-get update
    # Dist-Upgrade
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* )
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.'
    sysupgrade
    ;;
esac
}

# INSTALL APPLICATIONS
function favourites {
# Install Favourite Applications
echo ''
echo 'Installing selected favourite applications...'
echo ''
echo 'Current package list:
couchdb
curl
filezilla
geany
geany-plugin-addons
geany-plugins
gimp
gimp-plugin-registry
git
guake
icontool
imagemagick
inkscape
mercurial
openjdk-7-jdk
openssh-server
python-pip
python3-distutils-extra
scons
synaptic
terminator
vlc
wxmaxima'
echo ''
read -p 'Proceed? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* ) 
    echo 'Requires root privileges:'
    # Add repositories
    # Update
    sudo apt-get update
    # Install.
    sudo apt-get install -y --no-install-recommends couchdb curl filezilla geany geany-plugins geany-plugin-addons gimp gimp-plugin-registry git guake icontool imagemagick inkscape mercurial openjdk-7-jdk openssh-server python-pip python3-distutils-extra scons synaptic terminator vlc wxmaxima
    echo 'Setting terminator as default terminal'
    gsettings set org.gnome.desktop.default-applications.terminal exec 'terminator'
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* )
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.'
    favourites
    ;;
esac
}

# CUSTOMIZATION
function customize {
echo ''
echo '1. Configure system?'
echo '2. Install Third-Party themes?'
echo 'r. Return'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
    1) clear && config;; # System Configuration
    2) clear && themes;; # Install Third-Party Themes
    [Rr]*) clear && main;; # Return
    * ) clear && echo 'Not an option, try again.' && customize;; # Invalid choice
esac
}

# THIRD PARTY APPLICATIONS
function thirdparty {
echo 'What would you like to install? '
echo ''
echo '1. Google Chrome?'
echo '2. Smartgithg'
echo '3. Texmaker'
echo '4. Dropbox'
echo '5. Phantom Omni'
echo '6. VirtualBox'
echo 'r. Return'
echo ''
read -p 'Enter your choice: ' REPLY
case $REPLY in
# Google Chrome
1) 
    echo 'Downloading Google Chrome...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    fi
    # Install package(s)
    echo 'Installing Google Chrome...'
    echo 'Requires root privileges:'
    sudo dpkg -i google-chrome*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm google-chrome*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
# Smartgithg
2) 
    echo 'Downloading Smartgithg 6...'
    wget http://www.syntevo.com/downloads/smartgit/smartgit-6_5_7.deb
    # Install package(s)
    echo 'Installing Smartgithg 6...'
    echo 'Requires root privileges:'
    sudo dpkg -i smartgit*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm smartgit*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
# Texmaker
3) 
    echo 'Downloading Texmaker...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget http://www.xm1math.net/texmaker/texmaker_ubuntu_12.04_4.2_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget http://www.xm1math.net/texmaker/texmaker_ubuntu_12.04_4.2_amd64.deb
    fi
    # Install package(s)
    echo 'Installing Texmaker...'
    echo 'Requires root privileges:'
    sudo dpkg -i texmaker*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm texmaker*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
# Dropbox
4) 
    echo 'Downloading Dropbox...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://linux.dropbox.com/packages/ubuntu/dropbox_1.6.0_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://linux.dropbox.com/packages/ubuntu/dropbox_1.6.0_amd64.deb
    fi
    # Install package(s)
    echo 'Installing Dropbox...'
    echo 'Requires root privileges:'
    sudo dpkg -i dropbox_1.6.0_*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm dropbox_1.6.0_*.deb
    cd
    nautilus -q
    echo 'Done.'
    thirdparty
    ;;
# Phantom Omni
5) 
    echo 'Installing requirements:
freeglut3-dev 
g++ 
libdrm-dev 
libexpat1-dev 
libglw1-mesa-dev
libmotif-dev 
libncurses5-dev 
libraw1394-dev 
libx11-dev 
libxdamage-dev 
libxext-dev 
libxt-dev 
libxxf86vm-dev 
tcsh 
unzip 
x11proto-dri2-dev 
x11proto-gl-dev 
x11proto-print-dev'
    echo ''
    read -p 'Proceed? (Y)es, (N)o : ' REPLY
    case $REPLY in
    # Positive action
    [Yy]* ) 
        echo 'Requires root privileges:'
        # Install.
        echo 'Requires root privileges:'
        sudo apt-get install -y --no-install-recommends freeglut3-dev g++ libdrm-dev libexpat1-dev libglw1-mesa-devlibmotif-dev libncurses5-dev libraw1394-dev libx11-dev libxdamage-dev libxext-dev libxt-dev libxxf86vm-dev tcsh unzip x11proto-dri2-dev x11proto-gl-dev x11proto-print-dev
        ;;
    # Negative action
    [Nn]* )
        clear && thirdparty
        ;;
    # Error
    * )
        clear && echo 'Sorry, try again.'
        thirdparty
        ;;
    esac
    echo 'Downloading  PDD and OH...'
    # Installing unzip (just in case it's not here)
    # Download Debian file that matches system architecture
    wget https://github.com/fsuarez6/phantom_omni/releases/download/0.2.0/OpenHapticsAE_Linux_v3_0.zip
    unzip OpenHapticsAE_Linux_v3_0.zip
    CURRENT_DIR="$(pwd)"
    cd ./OpenHapticsAE_Linux_v3_0
    # Install package(s)
    echo 'Installing Dropbox...'
    echo 'Requires root privileges:'
    if [ $(uname -i) = 'i386' ]; then
      cd ./OpenHaptics-AE\ 3.0/32-bit/
      sudo dpkg -i openhaptics-ae*.deb
      sudo apt-get install -fy
      cd ../../PHANTOM\ Device\ Drivers/32-bit/
      sudo dpkg -i phantomdevicedrivers*.deb
      sudo apt-get install -fy
    elif [ $(uname -i) = 'x86_64' ]; then
      cd ./OpenHaptics-AE\ 3.0/64-bit/
      sudo dpkg -i openhaptics-ae*.deb
      sudo apt-get install -fy
      cd ../../PHANTOM\ Device\ Drivers/64-bit/
      sudo dpkg -i phantomdevicedrivers*.deb
      sudo apt-get install -fy
    fi
    # Cleanup and finish
    cd $CURRENT_DIR
    rm -rf OpenHapticsAE_Linux_v3_0*
    echo 'Done.'
    thirdparty
    ;;
# VirtualBox
6) 
    echo 'Downloading VirtualBox 4.3.26...'
    wget http://download.virtualbox.org/virtualbox/4.3.26/virtualbox-4.3_4.3.26-98988~Ubuntu~precise_amd64.deb
    # Install package(s)
    echo 'Installing VirtualBox...'
    echo 'Requires root privileges:'
    sudo dpkg -i virtualbox*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm virtualbox*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && thirdparty;;
esac
}

# CLEANUP SYSTEM
function cleanup {
echo ''
echo '1. Remove unused pre-installed packages?'
echo '2. Remove old kernel(s)?'
echo '3. Remove orphaned packages?'
echo '4. Remove leftover configuration files?'
echo '5. Clean package cache?'
echo 'r. Return?'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
# Remove Unused Pre-installed Packages
1)
    echo 'Removing selected pre-installed applications...'
    echo 'Requires root privileges:'
    sudo apt-get purge landscape-client-ui-install ubuntuone-control-panel* overlay*
    echo 'Done.'
    cleanup
    ;;
# Remove Old Kernel
2)
    echo 'Removing old Kernel(s)...'
    echo 'Requires root privileges:'
    sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | grep -v linux-libc-dev | xargs sudo apt-get -y purge
    echo 'Done.'
    cleanup
    ;;
# Remove Orphaned Packages
3)
    echo 'Removing orphaned packages...'
    echo 'Requires root privileges:'
    sudo apt-get autoremove -y
    echo 'Done.'
    cleanup
    ;;
# Remove residual config files?
4)
    echo 'Removing leftover configuration files...'
    echo 'Requires root privileges:'
    sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep '^rc' | tr -s ' ' | cut -d ' ' -f 2)
    echo 'Done.'
    cleanup
    ;;
# Clean Package Cache
5)
    echo 'Cleaning package cache...'
    echo 'Requires root privileges:'
    sudo apt-get clean
    echo 'Done.'
    cleanup
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && cleanup;;
esac
}

# Quit
function quit {
read -p "Are you sure you want to quit? (Y)es, (N)o " REPLY
case $REPLY in
    [Yy]* ) exit 99;;
    [Nn]* ) clear && main;;
    * ) clear && echo 'Sorry, try again.' && quit;;
esac
}

#----- MAIN FUNCTION -----#
function main {
echo ''
echo '1. Perform system update & upgrade?'
echo '2. Install favourite applications?'
echo '3. Install third-party applications?'
echo '4. Cleanup the system?'
echo 'q. Quit?'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
    1) sysupgrade;; # System Upgrade
    2) clear && favourites;; # Install Favourite Applications
    3) clear && thirdparty;; # Install Third-Party Applications
    4) clear && cleanup;; # Cleanup System
    [Qq]* ) echo '' && quit;; # Quit
    * ) clear && echo 'Not an option, try again.' && main;;
esac
}

#----- RUN MAIN FUNCTION -----#
main

#END OF SCRIPT
