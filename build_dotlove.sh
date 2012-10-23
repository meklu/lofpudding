#!/bin/sh
# This builds a .love file in the directory it resides in.
cd "$(dirname "$(readlink -f "$0")")"
# clone the Löve Frames repo
if [ ! -d "libraries/loveframes/.git" ]; then
	mkdir -p libraries
	cd libraries
	rm -rf loveframes/; git clone git://github.com/NikolaiResokav/LoveFrames.git loveframes
	cd loveframes
	for i in ../../patch/loveframes/*.patch; do
		# try to apply patches
		git am --ignore-whitespace "${i}" || git am --abort
	done
	cd ../..
else
	cd libraries/loveframes
	git fetch origin
	git rebase origin
	for i in ../../patch/loveframes/*.patch; do
		# try to apply patches
		git am --ignore-whitespace "${i}" || git am --abort
	done
	cd ../..
fi
[ ! -d "build" ] && mkdir build
[ -f "build/${PWD##*/}.love" ] && rm "build/${PWD##*/}.love"
zip -9 -r "build/${PWD##*/}.love" . -x .git/\* .gitignore libraries/loveframes/.git/\* patch/\* "${0##*/}" build/\*
