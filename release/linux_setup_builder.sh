#!/bin/sh

# This script depends on the GNU script makeself.sh found at: http://megastep.org/makeself/
# Note: The structure of this package depends on the -rpath,./lib to be set at compile/link time.

version="1.6.3"
arch=`uname -i`

if [ "${arch}" = "x86_64" ]; then
    arch="64bit"
    QtLIBPATH="${HOME}/Qt/5.4/gcc_64"
else
    arch="32bit"
    QtLIBPATH="${HOME}/Qt/5.4/gcc"
fi

if [ -f renminbi-qt ] && [ -f renminbi.conf ] && [ -f README ]; then
    echo "Building Renminbi_${version}_${arch}.run ...\n"
    if [ -d Renminbi_${version}_${arch} ]; then
        rm -fr Renminbi_${version}_${arch}/
    fi
    mkdir Renminbi_${version}_${arch}
    mkdir Renminbi_${version}_${arch}/libs
    mkdir Renminbi_${version}_${arch}/platforms
    mkdir Renminbi_${version}_${arch}/imageformats
    cp renminbi-qt Renminbi_${version}_${arch}/
    cp renminbi.conf Renminbi_${version}_${arch}/
    cp README Renminbi_${version}_${arch}/
    ldd renminbi-qt | grep libssl | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Renminbi_${version}_${arch}/libs/
    ldd renminbi-qt | grep libdb_cxx | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Renminbi_${version}_${arch}/libs/
    ldd renminbi-qt | grep libboost_system | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Renminbi_${version}_${arch}/libs/
    ldd renminbi-qt | grep libboost_filesystem | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Renminbi_${version}_${arch}/libs/
    ldd renminbi-qt | grep libboost_program_options | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Renminbi_${version}_${arch}/libs/
    ldd renminbi-qt | grep libboost_thread | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Renminbi_${version}_${arch}/libs/
    ldd renminbi-qt | grep libminiupnpc | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Renminbi_${version}_${arch}/libs/
    ldd renminbi-qt | grep libqrencode | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Renminbi_${version}_${arch}/libs/
    cp ${QtLIBPATH}/lib/libQt*.so.5 Renminbi_${version}_${arch}/libs/
    cp ${QtLIBPATH}/lib/libicu*.so.53 Renminbi_${version}_${arch}/libs/
    cp ${QtLIBPATH}/plugins/platforms/lib*.so Renminbi_${version}_${arch}/platforms/
    cp ${QtLIBPATH}/plugins/imageformats/lib*.so Renminbi_${version}_${arch}/imageformats/
    strip Renminbi_${version}_${arch}/renminbi-qt
    echo "Enter your sudo password to change the ownership of the archive: "
    sudo chown -R nobody:nogroup Renminbi_${version}_${arch}

    # now build the archive
    if [ -f Renminbi_${version}_${arch}.run ]; then
        rm -f Renminbi_${version}_${arch}.run
    fi
    makeself.sh --notemp Renminbi_${version}_${arch} Renminbi_${version}_${arch}.run "\nCopyright (c) 2014-2015 The Renminbi Developers\nRenminbi will start when the installation is complete...\n" ./renminbi-qt \&
    sudo rm -fr Renminbi_${version}_${arch}/
    echo "Package created in: $PWD/Renminbi_${version}_${arch}.run\n"
else
    echo "Error: Missing files!\n"
    echo "Copy this file to a setup folder along with renminbi-qt, renminbi.conf and README.\n"
fi

