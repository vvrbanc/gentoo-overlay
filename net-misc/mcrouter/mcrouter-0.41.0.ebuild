# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 autotools

DESCRIPTION="Facebook Memcache Router"
HOMEPAGE="https://github.com/facebook/mcrouter"
EGIT_REPO_URI="https://github.com/facebook/mcrouter"
EGIT_BRANCH="release-41-0"
EGIT_COMMIT="9ffd13e9ab6c2c02bd1f95a7169c9a69b1b6bc54"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-util/ragel
	=dev-cpp/wangle-20191104
	=dev-cpp/folly-20191104
	=dev-cpp/fbthrift-20191104
	=dev-cpp/fizz-20191104
	app-arch/snappy
	app-arch/lz4
	sys-libs/libunwind
"

src_prepare() {
	cd mcrouter
	eautoreconf
	eapply_user
	cd ..
}

src_configure() {
	export FBTHRIFT_BIN=/usr/bin
	cd mcrouter
	econf
	cd ..
}

src_compile() {
	cd mcrouter
	emake
	cd ..
}

src_install() {
	cd mcrouter
	emake DESTDIR="${D}" install
	cd ..
}
