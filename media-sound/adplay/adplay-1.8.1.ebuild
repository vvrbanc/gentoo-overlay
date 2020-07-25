# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils git-r3 autotools

DESCRIPTION="A free AdLib sound player library"
HOMEPAGE="https://adplug.github.io/"
EGIT_REPO_URI="https://github.com/adplug/adplay-unix"
EGIT_COMMIT="9b38a56b6bfaceb554e37d33d81f8b33ada3f446"
LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	media-libs/adplug
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf
}
