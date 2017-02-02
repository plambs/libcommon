#!/bin/bash

config_file="../../cross_toolchain.config"
defconfig_file="../../cross_toolchain.defconfig"


if [ ! -e ${config_file} ]; then
	printf "${config_file} didn't exist, create it\n"
	cp ${defconfig_file} ${config_file}
fi

toolchain_path=$(grep "ARM_TOOLCHAIN_PATH" ${config_file} | awk -F'\"' '{print $2}')
toolchain_prefix=$(grep "ARM_TOOLCHAIN_PRFIX" ${config_file} | awk -F'\"' '{print $2}')
sysroot=$(grep "SYSROOT" ${config_file} | awk -F'\"' '{print $2}')

#Relocate toolchain folder
toolchain_path="../../${toolchain_path}"
sysroot="../../${sysroot}"

export ARM_TOOLCHAIN_PATH=${toolchain_path}
export ARM_TOOLCHAIN_PRFIX=${toolchain_prefix}

export LD_LIBRARY_PATH=$ARM_TOOLCHAIN_PATH/usr/lib
export PATH=$ARM_TOOLCHAIN_PATH/usr/bin:$PATH

make --no-print-directory  ARCH=arm CROSS_COMPILE=$ARM_TOOLCHAIN_PRFIX SYSROOT=${sysroot} $1
