#!/bin/bash

# IntelliJ installer script for TigerOS
# author: Josh Bicking <jhb2345@rit.edu>

#
# idea.sh
#
# Copyright (C) 2018  RIT Linux Users Group  All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

DEPS=java-9-openjdk
PROG="IntelliJ IDEA Community Edition"
PROG_SHORT=idea-ce
VERSION=idea-IC-171.4073.35
TEMP_FILE=/tmp/ideaIC-2018.2.5.tar.gz
FILE_DIR=/usr/local
FILE=$FILE_DIR/$VERSION/bin/idea.sh
FILE_URL=https://download.jetbrains.com/idea/ideaIC-2018.2.5.tar.gz
LINK=$FILE_DIR/bin/$PROG_SHORT
ICON=$FILE_DIR/$VERSION/bin/idea.png

# Check that the current user is root
if [ $EUID != 0 ]
then
    echo "Please run this script as root (sudo $@$0)."
    exit
fi

## Removal
# Check if remove flag was passed
if [ ! -z "$1" ] && [ "$1" = "--remove" ]
then
    rm $LINK
    rm /usr/local/share/applications/jetbrains-idea-ce.desktop
    rm -rf $FILE_DIR/$VERSION

    # Remove local links if they were created
    for i in `ls /home/`
    do 
        rm -f /home/$i/.local/share/applications/jetbrains-idea-ce.desktop
    done
else 

    ## Installation
    # Install dependencies
    dnf install $DEPS -y

    # Get the files
    wget -O $TEMP_FILE $FILE_URL 
    # Extract the files
    tar -xf $TEMP_FILE -C $FILE_DIR

    # Make a link
    ln -s $FILE $LINK

    chmod +x $LINK
    chmod -R 755 $FILE_DIR/$VERSION

    # Make a desktop file
    # IDEA's first time setup allows the user to make this file. Naming it as such means the user won't get a duplicate entry.
    cat > /usr/local/share/applications/jetbrains-idea-ce.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$PROG
Comment=The Drive to Develop
Exec=$LINK %f
Icon=$ICON
Terminal=false
Categories=Development;IDE;Java;
StartupWMClass=jetbrains-idea-ce
EOF
    # Clean up
    rm $TEMP_FILE
fi

exit 0
