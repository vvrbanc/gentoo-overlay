# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils cmake-utils

DESCRIPTION="Facebook's abstraction abstraction framework."
HOMEPAGE="https://github.com/facebook/wangle"
SRC_URI="https://github.com/facebook/${PN}/archive/v2019.11.04.00.tar.gz -> ${P}.tar.gz"
IUSE="test examples"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	=dev-cpp/folly-20191104
	=dev-cpp/fizz-20191104
"

S="${WORKDIR}/wangle-2019.11.04.00"

src_prepare() {
	CMAKE_USE_DIR="${S}/wangle"
	eapply_user
}
src_configure() {
	CMAKE_USE_DIR="${S}/wangle"

	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test YES NO)
		-DBUILD_EXAMPLES=$(usex examples YES NO)
	)

	cmake-utils_src_configure
}

src_compile() {
	CMAKE_USE_DIR="${S}/wangle"
	cmake-utils_src_make
}

src_install() {
	CMAKE_USE_DIR="${S}/wangle"
	cmake-utils_src_install
}
