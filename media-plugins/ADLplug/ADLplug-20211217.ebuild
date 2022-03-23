# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/jpcima/ADLplug.git"
EGIT_COMMIT="a488abedf1783c61cb4f0caa689f1b01bf9aa17d"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://github.com/jpcima/ADLplug"
LICENSE="Mixed"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXinerama
	x11-libs/libXcursor
	media-libs/freetype
	media-libs/alsa-lib
	media-sound/jack2
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake
"

src_configure() {
	cd ${S}
	mkdir build
	cd build
	cmake -DCMAKE_BUILD_TYPE=Release -DADLplug_VST2=ON -DADLplug_LV2=OFF -DADLplug_Standalone=OFF -DADLplug_Jack=OFF -DWITH_XMI_SUPPORT=ON ..
}

src_compile() {
	cd ${S}/build
	cmake --build . --parallel 8
}

src_install() {
	dodir /lib64/vst2
	cp -a ${S}/build/vst2/ADLplug.so ${D}/lib64/vst2/
}
