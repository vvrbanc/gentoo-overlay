# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

EGIT_REPO_URI="https://github.com/rncbc/drumkv1"
EGIT_COMMIT="4dfec0913bbec75ae84efb8d85acc6e893036155"

DESCRIPTION="an old-school drum-kit sampler"
HOMEPAGE="https://drumkv1.sourceforge.io/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
#IUSE="-vst +lv2"

DEPEND="
	media-libs/alsa-lib
	media-libs/freetype
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"

#CMAKE_BUILD_TYPE="Release"

