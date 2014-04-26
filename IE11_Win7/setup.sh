#!/bin/bash

pushd /tmp
curl -O -L "http://www.modern.ie/vmdownload?platform=mac&virtPlatform=virtualbox&browserOS=IE11-Win7&parts=4&filename=VMBuild_20131127/VirtualBox/IE11_Win7/Mac/IE11.Win7.For.MacVirtualBox.part{1.sfx,2.rar,3.rar,4.rar}"
chmod +x IE11.Win7.For.MacVirtualBox.part1.sfx
./IE11.Win7.For.MacVirtualBox.part1.sfx
VBoxManage import IE11\ -\ Win7.ova
VBoxManage snapshot "IE11 - Win7" take "Clean install"
popd

exit 0
