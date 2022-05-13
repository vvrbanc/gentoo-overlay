# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/steinbergmedia/vst3sdk"
EGIT_COMMIT="v3.7.4_build_25"

DESCRIPTION="Steinberg VST SDK"
HOMEPAGE="https://www.steinberg.net/developers/"
LICENSE="Proprietary"
SLOT="0"
KEYWORDS="amd64"

src_configure() {
	echo skipping configure
}

src_compile() {
	echo skipping compile
}

src_install() {
	dodir /opt/vst3sdk
	cp -a ${S}/* ${D}/opt/vst3sdk/
}

