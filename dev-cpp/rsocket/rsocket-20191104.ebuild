# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 autotools cmake-utils

DESCRIPTION="C++ implementation of RSocket"
HOMEPAGE="https://github.com/rsocket/rsocket-cpp"
EGIT_REPO_URI="https://github.com/rsocket/rsocket-cpp"
EGIT_COMMIT="4a4a476c855801fb48ed6f4b420a2fc671bc1b2e"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

DEPEND="
	dev-cpp/folly
	dev-libs/libfmt
"


PATCHES=(
    "${FILESDIR}"/${P}-gcc9.patch
)

src_configure() {
	pwd
	local mycmakeargs=(
		-DBUILD_BENCHMARKS=NO
		-DBUILD_EXAMPLES=NO
		-DBUILD_TESTING=NO
		-DBUILD_TESTS=NO
	)
	cmake-utils_src_configure
}

src_compile() {
	pwd
	cd ../rsocket-20191104_build
	emake
}

src_install() {
	pwd
	cd ../rsocket-20191104_build
	emake install DESTDIR="${D}"
}
