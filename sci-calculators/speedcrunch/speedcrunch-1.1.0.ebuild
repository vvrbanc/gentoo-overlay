# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Fast and usable calculator for power users"
HOMEPAGE="https://github.com/heldercorreia/speedcrunch"
SRC_URI="https://github.com/heldercorreia/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-qt/qtbase-6.4:6[gui,network,widgets]
	>=dev-qt/qttools-6.4:6[assistant]
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-qt/qttools-6.4:6[linguist]"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}
