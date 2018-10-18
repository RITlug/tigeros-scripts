#!/usr/bin/bash

# MIT Alloy installer script for TigerOS
# author: Aidan Kahrs <axk4545@rit.edu>

#
# alloy.sh
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
PROG=Alloy
FILE=/usr/share/java/alloy.jar
FILE_URL=http://alloy.mit.edu/alloy/downloads/alloy4.2.jar
LINK=/usr/local/bin/alloy

# Check that the current user is root
if [ $EUID != 0 ]
then
    echo "Please run this script as root (sudo $@$0)."
    exit
fi
# Check if remove flag was passed
if [ ! -z "$1" ] && [ "$1" = "--remove" ]
then
    rm $LINK
    rm /usr/local/share/applications/$PROG.desktop
    rm $FILE
    rm /usr/local/share/icons/$PROG.jpg
else 

# Install dependencies
dnf install $DEPS -y

# Get the files
curl -o $FILE $FILE_URL

# Make a link
cat > $LINK <<EOF
#!/bin/sh
cd \$HOME
java -jar $FILE
EOF

chmod +x $LINK
chmod +x $FILE

# Make a desktop file
cat > /usr/local/share/applications/$PROG.desktop <<EOF
[Desktop Entry]
Type=Application
Version=7.0
Name=$PROG
Comment=Experiment with formal languages topics
Path=
Exec=$LINK
Icon=/usr/local/share/icons/$PROG.jpg
Terminal=false
Categories=Education;Languages;Java;
EOF

# Get the icons
mkdir -p /usr/local/share/icons
unzip -j "$FILE" "images/logo.gif" -d "alloy.gif"

exit 0
