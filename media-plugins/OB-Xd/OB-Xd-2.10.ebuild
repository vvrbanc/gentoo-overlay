# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/reales/OB-Xd"
EGIT_COMMIT="f1fcdd51eabcb7855cdd90818611cd7e357c359c"
SRC_URI="https://github.com/juce-framework/JUCE/releases/download/7.0.3/juce-7.0.3-linux.zip"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://www.discodsp.com/obxd/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/libglvnd[X]
	media-libs/vst2sdk
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
BDEPEND="
"

src_prepare() {
	default_src_prepare
	unzip ${DISTDIR}/juce-7.0.3-linux.zip
	cp -a JUCE/modules/* Modules/
	sed -i -e 's/JUCE_JACK="1"/JUCE_JACK="0"/g' 'OB-Xd Linux.jucer'
	JUCE/Projucer --resave 'OB-Xd Linux.jucer'
}

src_compile() {
	cd ${S}/Builds/LinuxMakefile
	emake VST3
}

src_install() {
	dodir /usr/lib64/vst3
	dodir /usr/share
	cp -a ${S}/Builds/LinuxMakefile/build/OB-Xd.vst3 ${D}/usr/lib64/vst3/
	cp -a ${S}/Documents/discoDSP/OB-Xd ${D}/usr/share/
}

pkg_postinst() {
	ewarn "OB-Xd assets have been installed to /usr/share/OB-Xd"
	ewarn " "
	ewarn "You must copy this directory to ${HOME}/Documents/discoDSP"
	ewarn "or create a symlink Documents/discoDSP/OB-Xd -> /usr/share/OB-Xd "
	ewarn " "
}
