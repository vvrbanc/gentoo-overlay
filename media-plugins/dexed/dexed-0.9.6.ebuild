# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/asb2m10/dexed"
EGIT_COMMIT="11ae4d7ef597b2d52f45e59ab56b342252d0bd88"
SRC_URI="https://github.com/juce-framework/JUCE/releases/download/6.0.7/juce-6.0.7-linux.zip"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://asb2m10.github.io/dexed/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

#RESTRICT=network-sandbox

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
BDEPEND="
"

src_prepare() {
	default_src_prepare
	mkdir -p ${S}/assets
	cd ${S}/assets
	unzip ${DISTDIR}/juce-6.0.7-linux.zip
	cd ${S}
	scripts/projuce.sh
}

src_compile() {
	export CONFIG=Release
	cd ${S}/Builds/Linux
	emake
}

src_install() {
	dodir /usr/lib64/vst3
	cp -a ${S}/Builds/Linux/build/Dexed.vst3 ${D}/usr/lib64/vst3/
}
