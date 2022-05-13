# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/oxesoft/oxefmsynth"
EGIT_COMMIT="fe078ea036991081c3a28bb388a3fecd0e8e3a5d"

DESCRIPTION="FM synth"
HOMEPAGE="https://oxesoft.wordpress.com/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"

src_compile() {
	export VSTSDK_PATH=/opt/vst2sdk
	emake -f Makefile.vstlinux
}

src_install() {
	dodir /usr/lib64/vst
	cp ${S}/oxevst64.so ${D}/usr/lib64/vst/
}

