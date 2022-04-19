# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit git-r3 cmake

DESCRIPTION="Pidgin Telegram plugin"
HOMEPAGE="https://github.com/ars3niy/tdlib-purple"
EGIT_REPO_URI="https://github.com/ars3niy/tdlib-purple"
EGIT_COMMIT="912a43005c6749f0bb471df763a84bac3b012b53"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	=dev-libs/tdlib-1.7.9
"

src_configure() {
	mycmakeargs=(
		-DNoVoip=TRUE
	)
	cmake_src_configure
}
