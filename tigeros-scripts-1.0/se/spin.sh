#!/usr/bin/bash

# Spin install script for TigerOS
# author: Aidan Kahrs <axk4545@rit.edu>

#
# spin.sh
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

# Check that the current user is root
if [ $EUID != 0 ]
then
    echo "Please run this script as root (sudo $@$0)."
    exit
fi
# Check if remove flag was passed
if [ ! -z "$1" ] && [ "$1" = "--remove" ]
then
    rm /usr/local/bin/spin
    rm /usr/local/bin/ispin
else
    wget http://spinroot.com/spin/Src/spin646.tar.gz -O /tmp/spin.tar.gz
    tar -xvf /tmp/spin.tar.gz
    cd /tmp/Spin/Src*
    dnf install -y byacc
    make
    install -p -m 755 spin /usr/local/bin/spin
    sed -i 's#BIN=/usr/bin#BIN=/usr/local/bin#g' /tmp/Spin/iSpin/install.sh
    dnf install -y tcl tk
    bash /tmp/Spin/iSpin/install.sh
    dnf remove -y byacc
fi

exit 0
