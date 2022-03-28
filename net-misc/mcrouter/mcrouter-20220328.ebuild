# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit git-r3 autotools

DESCRIPTION="Facebook Memcache Router"
HOMEPAGE="https://github.com/facebook/mcrouter"
EGIT_REPO_URI="https://github.com/facebook/mcrouter"
EGIT_COMMIT="v2022.03.28.00"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	app-arch/lz4
	dev-util/ragel
	dev-cpp/fbthrift
"
S=${S}/mcrouter
export FBTHRIFT_BIN=/usr/bin

src_prepare() {
	eautoreconf
	eapply_user
}
