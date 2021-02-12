#!/bin/bash

shopt -s extglob

case $(uname -s) in
	Darwin)
        cd unix
		brew install tcl-tk
		# Install XQuartz for X11 dependency
		# Not good hardcoding URL
		wget 'https://dl.bintray.com/xquartz/downloads/XQuartz-2.7.11.dmg'
		hdiutil attach 'XQuartz-2.7.11.dmg'
		sudo installer -pkg '/Volumes/XQuartz-2.7.11/XQuartz.pkg' -target "/"
		tcltkpath=$(dirname $(brew ls tcl-tk | grep '/tclConfig.sh$'))
		;;
	Linux)
        cd unix
		sudo apt-get install tcl-dev tk-dev
		tcltkpath=/usr/lib
		;;
	@(*CYGWIN*|*Windows*|*MINGW*|*MSYS*))
        cd win
        # so that headers are auto included
        curl -L 'https://bitbucket.org/tombert/tcltk/downloads/tcltk86-8.6.11.1.tcl86.Win10.x86_64.tgz' | tar -xzf -
        tcltkpath=`readlink -f tcltk*/lib`
        export C_INCLUDE_PATH="`dirname $tcltkpath`/include${C_INCLUDE_PATH:+:${C_INCLUDE_PATH}}"
        export LIBRARY_PATH="$tcltkpath${LIBRARY_PATH:+:${LIBRARY_PATH}}"
		;;
esac
havealsa=$(command -v alsa)
./configure \
	--with-tcl=${tcltkpath} \
	--with-tk=${tcltkpath} \
	${havealsa:+"--enable-alsa"} \
# the XINCLUDES is not elegant - there should be some approach to portably find X11 dependency
LANG=UTF-8 make XINCLUDES='-L/usr/X11/lib/'
make DESTDIR=../inst INSTALL_DIR=$(readlink -f ../inst) install
