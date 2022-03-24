# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

EGIT_REPO_URI="https://github.com/jpcima/ADLplug.git"
EGIT_COMMIT="a488abedf1783c61cb4f0caa689f1b01bf9aa17d"

DESCRIPTION="OPL3 synthesizer VST"
HOMEPAGE="https://github.com/jpcima/ADLplug"
LICENSE="Mixed"
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
	dev-util/cmake
"
CMAKE_BUILD_TYPE="Release"

src_configure() {

mycmakeargs=(
	-DADLplug_VST2=ON
	-DADLplug_LV2=OFF
	-DADLplug_Standalone=OFF
	-DADLplug_Jack=OFF
	-DWITH_XMI_SUPPORT=ON
)
	cmake_src_configure
}

src_install() {
	dodir /usr/lib64/vst
	cp -a ${BUILD_DIR}/vst2/ADLplug.so ${D}/usr/lib64/vst/
}
