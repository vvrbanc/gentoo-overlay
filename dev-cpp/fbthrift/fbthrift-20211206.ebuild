# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit git-r3 autotools

DESCRIPTION="Facebook Thrift is a serialization and RPC framework for service communication"
HOMEPAGE="https://github.com/facebook/fbthrift"
EGIT_REPO_URI="https://github.com/facebook/fbthrift"
EGIT_COMMIT="v2021.12.06.00"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-cpp/folly
	dev-cpp/fizz
	dev-cpp/wangle
"
