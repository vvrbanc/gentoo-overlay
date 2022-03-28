# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils git-r3 autotools cmake-utils

DESCRIPTION="Facebook Open Source C++ Library"
HOMEPAGE="https://github.com/facebook/folly"
EGIT_REPO_URI="https://github.com/facebook/folly"
EGIT_COMMIT="v2022.01.03.00"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/boost[context]
	dev-libs/double-conversion
	dev-cpp/glog
	dev-cpp/gflags
	dev-libs/libevent
	app-arch/snappy
	dev-libs/libfmt
"
