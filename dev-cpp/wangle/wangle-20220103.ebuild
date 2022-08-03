# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 autotools

DESCRIPTION="Facebook C++ networking library"
HOMEPAGE="https://github.com/facebook/wangle"
EGIT_REPO_URI="https://github.com/facebook/wangle"
EGIT_COMMIT="v2022.01.03.00"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-cpp/folly
	dev-cpp/fizz
"

S="${S}/wangle"

