# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit git-r3 autotools

DESCRIPTION="Binary I/O stream class library"
HOMEPAGE="https://github.com/adplug/libbinio"
EGIT_REPO_URI="https://github.com/adplug/libbinio"
EGIT_COMMIT="020a4c2b7612863600428e0e9f2491b923e54ac2"
LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
"

#S="${WORKDIR}/folly-20191104"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --enable-maintainer-mode
}
