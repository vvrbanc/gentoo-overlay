# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit git-r3 autotools

DESCRIPTION="A free AdLib sound player library"
HOMEPAGE="https://adplug.github.io/"
EGIT_REPO_URI="https://github.com/adplug/adplug"
EGIT_COMMIT="37f287dc9d81cd6aaab61f48da5cacc0ab39130e"
LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-cpp/libbinio
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf
}
