# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/cc65/cc65/archive/V${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cc65/cc65.git"
fi

DESCRIPTION="A C compiler for 6502-based systems"
HOMEPAGE="https://cc65.github.io/"
LICENSE="ZLIB"
SLOT="0"
IUSE="doc"

DEPEND="doc? ( app-text/linuxdoc-tools )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake
	use doc && emake -C doc 
}
src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
