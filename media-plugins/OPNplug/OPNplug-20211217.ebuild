# Copyright 2022 Gentoo Authors
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
IUSE="-vst +lv2"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"

CMAKE_BUILD_TYPE="Release"

src_configure() {
	LV2=OFF
	VST2=OFF
	use lv2 && LV2=ON
	use vst && VST2=ON
	mycmakeargs=(
		-DADLplug_VST2=${VST2}
		-DADLplug_LV2=${LV2}
		-DADLplug_Standalone=OFF
		-DADLplug_Jack=OFF
		-DWITH_XMI_SUPPORT=ON
		-DADLplug_CHIP=OPN2
	)
	cmake_src_configure
}

