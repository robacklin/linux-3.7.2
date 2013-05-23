#!/bin/sh

if [ -z "${CFG_TARGET}" ] ; then
	CFG_TARGET=`pwd`/target
	echo "CFG_TARGET=${CFG_TARGET}"
fi
if [ -z "${CFG_SOURCE}" ] ; then
	CFG_SOURCE=`pwd`/source
	echo "CFG_SOURCE=${CFG_SOURCE}"
fi
if [ -z "${CFG_BUILD}" ] ; then
	CFG_BUILD=`pwd`/build
	echo "CFG_BUILD=${CFG_BUILD}"
fi
if [ -z "${CFG_LINUX_CONFIG}" ] ; then
	CFG_LINUX_CONFIG=i386_defconfig
	echo "CFG_LINUX_CONFIG=${CFG_LINUX_CONFIG}"
fi
if [ -z "${CFG_LINUX_IMAGE}" ] ; then
	CFG_LINUX_IMAGE=bzImage
	echo "CFG_LINUX_IMAGE=${CFG_LINUX_IMAGE}"
fi

mkdir -p $CFG_TARGET
mkdir -p $CFG_SOURCE
mkdir -p $CFG_BUILD

cd $CFG_SOURCE
make O=$CFG_BUILD mrproper || exit 1
make O=$CFG_BUILD $CFG_LINUX_CONFIG || exit 1
make O=$CFG_BUILD dep || exit 1
make O=$CFG_BUILD clean || exit 1
make O=$CFG_BUILD $CFG_LINUX_IMAGE modules || exit 1
make O=$CFG_BUILD INSTALL_MOD_PATH=$CFG_TARGET modules_install || exit 1
exit 0
