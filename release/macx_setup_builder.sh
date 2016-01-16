#!/bin/sh

# Note: The structure of this package depends on the -rpath,./lib to be set at compile/link time.

version="1.6.3"
arch=`uname -m`

if [ "${arch}" = "x86_64" ]; then
    arch="64bit"
else
    arch="32bit"
fi

if [ -f Renminbi-Qt.app/Contents/MacOS/Renminbi-Qt ] && [ -f renminbi.conf ] && [ -f README ]; then
    echo "Building Renminbi_${version}_${arch}.pkg ...\n"
    cp renminbi.conf Renminbi-Qt.app/Contents/MacOS/
    cp README Renminbi-Qt.app/Contents/MacOS/

    # Remove the old archive
    if [ -f Renminbi_${version}_${arch}.pkg ]; then
        rm -f Renminbi_${version}_${arch}.pkg
    fi

    # Deploy the app, create the plist, then build the package.
    macdeployqt ./Renminbi-Qt.app -always-overwrite
    pkgbuild --analyze --root ./Renminbi-Qt.app share/qt/Renminbi-Qt.plist
    pkgbuild --root ./Renminbi-Qt.app --component-plist share/qt/Renminbi-Qt.plist --identifier org.renminbi.Renminbi-Qt --install-location /Applications/Renminbi-Qt.app Renminbi_${version}_${arch}.pkg
    echo "Package created in: $PWD/Renminbi_${version}_${arch}.pkg\n"
else
    echo "Error: Missing files!\n"
    echo "Run this script from the folder containing Renminbi-Qt.app, renminbi.conf and README.\n"
fi

