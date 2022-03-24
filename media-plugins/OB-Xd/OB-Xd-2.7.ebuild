# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/reales/OB-Xd"
EGIT_COMMIT="3f98f49d6cb371ba21cac2008077ce4e4a0f4c97"
SRC_URI="https://github.com/juce-framework/JUCE/releases/download/6.0.5/juce-6.0.5-linux.zip"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://www.discodsp.com/obxd/"
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
BDEPEND="
"

src_prepare() {
	default_src_prepare
	unzip ${DISTDIR}/juce-6.0.5-linux.zip
	cp -a JUCE/modules/* Modules/
	JUCE/Projucer --resave OB-Xd.jucer
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
