# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

EGIT_REPO_URI="https://github.com/rncbc/samplv1"
EGIT_COMMIT="0235bc883b08969fc957b71311135f03d5aae360"

DESCRIPTION="an old-school polyphonic sampler"
HOMEPAGE="https://samplv1.sourceforge.io/"
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

