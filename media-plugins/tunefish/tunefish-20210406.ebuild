# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/paynebc/tunefish.git"
EGIT_COMMIT="07774d96db0169ff91358db2cc4b3fdfd1841a0d"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://tunefish-synth.com/"
LICENSE="Unknown"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/vst2sdk
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
BDEPEND="
"

src_configure() {
	echo noop
}

src_compile() {
	cd ${S}/src/tunefish4/Builds/LinuxMakefile
	emake
}

src_install() {
	dodir /usr/lib64/vst3
	cp -a ${S}/src/tunefish4/Builds/LinuxMakefile/build/Tunefish4.vst3 ${D}/usr/lib64/vst3/
}
