# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SRC_URI="https://vrbanc.com/files/gentoo/vst2sdk-2.4.tar.xz"

DESCRIPTION="Steinberg VST2 SDK"
HOMEPAGE="https://www.steinberg.com"
LICENSE="Proprietary"
SLOT="0"
KEYWORDS="amd64"


src_install() {
	dodir /opt/vst2sdk
	mkdir -p ${D}/usr/include
	cp -a ${S}/* ${D}/opt/vst2sdk/
	ln -s /opt/vst2sdk/pluginterfaces ${D}/usr/include/pluginterfaces
}
