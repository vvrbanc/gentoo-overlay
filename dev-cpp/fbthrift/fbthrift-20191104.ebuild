# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 autotools cmake-utils

DESCRIPTION="Facebook Thrift is a serialization and RPC framework for service communication"
HOMEPAGE="https://github.com/facebook/fbthrift"
EGIT_REPO_URI="https://github.com/facebook/fbthrift"
EGIT_COMMIT="6d6f6b8dd7d3333690e78e27b4c68ff7a55614df"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

DEPEND="
	=dev-cpp/rsocket-20191104
	=dev-cpp/fizz-20191104
	=dev-cpp/folly-20191104
	=dev-cpp/wangle-20191104
	dev-libs/boost[zstd]
"


S="${WORKDIR}/fbthrift-20191104"

src_prepare() {
	pwd
	cmake-utils_src_prepare
}

src_configure() {
	pwd
	cmake-utils_src_configure
}

src_compile() {
	pwd
	cd ../fbthrift-20191104_build
	emake
}

src_install() {
	pwd
	cd ../fbthrift-20191104_build
	emake install DESTDIR="${D}"
}
