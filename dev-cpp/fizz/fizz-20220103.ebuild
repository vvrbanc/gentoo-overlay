# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 autotools cmake-utils

DESCRIPTION="Facebook TLS 1.3 implementation"
HOMEPAGE="https://github.com/facebookincubator/fizz"
EGIT_REPO_URI="https://github.com/facebookincubator/fizz"
EGIT_COMMIT="v2022.01.03.00"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="test examples"

DEPEND="
	dev-cpp/gtest
	dev-cpp/folly
"

S="${S}/fizz"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test YES NO)
		-DBUILD_EXAMPLES=$(usex examples YES NO)
	)
	cmake-utils_src_configure
}
