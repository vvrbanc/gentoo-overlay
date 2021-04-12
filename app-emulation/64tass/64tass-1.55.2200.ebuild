# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Cross assembler targeting the MOS 65xx"
HOMEPAGE="https://sourceforge.net/projects/tass64/"
SRC_URI="mirror://sourceforge/tass64/source/${P}-src.zip"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

S=${S}-src

src_prepare() {
	default

	# prevent man compression
	sed -i -e 's/-gzip.*//g' Makefile || die "sed fix failed. Uh-oh..."
}

src_install() {
	emake prefix="${ED}/usr" docdir="${ED}/usr/share/doc/${P}" install
}
