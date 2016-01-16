#!/bin/bash
# create multiresolution windows icon
ICON_DST=../../src/qt/res/icons/renminbi.ico

convert ../../src/qt/res/icons/renminbi-16.png ../../src/qt/res/icons/renminbi-32.png ../../src/qt/res/icons/renminbi-48.png ${ICON_DST}
