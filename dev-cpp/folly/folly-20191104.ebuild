# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 autotools cmake-utils

DESCRIPTION="Facebook Open Source Library"
HOMEPAGE="https://github.com/facebook/folly"
EGIT_REPO_URI="https://github.com/facebook/folly"
EGIT_COMMIT="b35bea8f0784806e687e32f6914f4a504785ea06"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-cpp/glog
	dev-cpp/gflags
	dev-libs/double-conversion
	dev-libs/libevent
	dev-libs/boost[context]
"

S="${WORKDIR}/folly-20191104"

PATCHES=(
	"${FILESDIR}"/${P}.patch
	)

src_configure() {
	cd folly
	cmake-utils_src_configure
	cd ..
}

src_compile() {
	pwd
	cd ../folly-20191104_build
	emake
	cd ..
}

src_install() {
	pwd
	cd ../folly-20191104_build
	emake install DESTDIR="${D}"
	cd ..
}
