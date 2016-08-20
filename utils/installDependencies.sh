#!/bin/bash

# Polską wersję językową dodał kinsl4yer 20/08/2016

# Copyright 2013 BrewPi
# This file is part of BrewPi.

# BrewPi is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# BrewPi is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with BrewPi. If not, see <http://www.gnu.org/licenses/>.

########################
### This script will install dependencies required by BrewPi through apt-get
########################

############
### Functions to catch/display errors during setup
############
warn() {
  local fmt="$1"
  command shift 2>/dev/null
  echo -e "$fmt\n" "${@}"
  echo -e "\n*** BŁĄD BŁĄD BŁĄD BŁĄD BŁĄD***\n----------------------------------\nSprawdź powyższe wiersze w celu znalezienia komunikatu błędu\nInstalacja NIE ZOSTAŁA ukończona\n"
}

die () {
  local st="$?"
  warn "$@"
  exit "$st"
}

############
### Install required packages
############
echo -e "\n***** Instalacja/aktualizacja niezbędnych pakietów... *****\n"
lastUpdate=$(stat -c %Y /var/lib/apt/lists)
nowTime=$(date +%s)
if [ $(($nowTime - $lastUpdate)) -gt 604800 ] ; then
    echo "Ostatnie wykonanie aktualizacji 'apt-get update' miało miejsce ponad tydzień temu. Uruchamianie 'apt-get update' przed aktualizacją zależności"
    sudo apt-get update||die
fi

sudo apt-get install -y apache2 libapache2-mod-php5 php5-cli php5-common php5-cgi php5 git-core build-essential python-dev python-pip git-core || die

echo -e "\n***** Instalacja/aktualizacja niezbędnych pakietów python poprzez pip (package manager)... *****\n"

sudo pip install pyserial psutil simplejson configobj gitpython --upgrade

echo -e "\n***** Ukończono przetwarzanie zależności BrewPi *****\n"
