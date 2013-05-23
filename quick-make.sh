#!/bin/sh

if [ -z "${CFG_TARGET}" ] ; then
	CFG_TARGET=`pwd`/target
	echo "${CFG_TARGET}"
fi
if [ -z "${CFG_SOURCE}" ] ; then
	CFG_SOURCE=`pwd`/build
	echo "${CFG_SOURCE}"
fi
if [ -z "${CFG_LINUX_CONFIG}" ] ; then
	CFG_LINUX_CONFIG=i386_defconfig
	echo "${CFG_LINUX_CONFIG}"
fi
if [ -z "${CFG_LINUX_IMAGE}" ] ; then
	CFG_LINUX_IMAGE=bzImage
	echo "${CFG_LINUX_IMAGE}"
fi

mkdir -p $CFG_TARGET
mkdir -p $CFG_SOURCE

cd $CFG_SOURCE
make mrproper || exit 1
make $CFG_LINUX_CONFIG || exit 1
make O=$CFG_TARGET dep || exit 1
make O=$CFG_TARGET clean || exit 1
make O=$CFG_TARGET $CFG_LINUX_IMAGE modules || exit 1
make O=$CFG_TARGET modules_install || exit 1
exit 0
