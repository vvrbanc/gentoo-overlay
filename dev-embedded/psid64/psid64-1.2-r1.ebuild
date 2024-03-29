# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="Converts PSID and RSID files into C64 executables"
HOMEPAGE="https://sourceforge.net/projects/psid64/"
SRC_URI="mirror://sourceforge/psid64/psid64/${PV}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

src_prepare() {
	AT_M4DIR="macros" eautoreconf
	append-flags "-Wno-error"
	default
}
