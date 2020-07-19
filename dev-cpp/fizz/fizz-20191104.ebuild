# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 autotools cmake-utils

DESCRIPTION="Facebook TLS 1.3 implementation"
HOMEPAGE="https://github.com/facebookincubator/fizz"
EGIT_REPO_URI="https://github.com/facebookincubator/fizz"
EGIT_COMMIT="979b09dbcd0344890692582d4fb5cb97bc7ab21e"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test examples"

DEPEND="
	dev-cpp/folly
	dev-libs/libfmt
	dev-libs/libsodium
"


S="${WORKDIR}/fizz-20191104"

src_prepare() {
	pwd
	CMAKE_USE_DIR="${S}/fizz"
	cmake-utils_src_prepare
}

src_configure() {
	pwd
	cd fizz
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test YES NO)
		-DBUILD_EXAMPLES=$(usex examples YES NO)
	)
	cmake-utils_src_configure
}

src_compile() {
	pwd
	cd ../fizz-20191104_build
	emake
}

src_install() {
	pwd
	cd ../fizz-20191104_build
	emake install DESTDIR="${D}"
}
