# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Converts PSID and RSID files into C64 executables"
HOMEPAGE="https://sourceforge.net/projects/psid64/"
SRC_URI="https://downloads.sourceforge.net/project/psid64/psid64/${PV}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

src_prepare() {
	default
	# upstream hardcodes -Werror, which breaks with newer compilers
	sed -i -e 's/ -Werror"/"/' configure.ac || die
	AT_M4DIR="macros" eautoreconf
}
