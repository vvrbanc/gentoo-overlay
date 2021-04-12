# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Compressor for 6502 executable files"
HOMEPAGE="https://bitbucket.org/magli143/exomizer/wiki"
SRC_URI="https://bitbucket.org/magli143/exomizer/wiki/downloads/${P}.zip"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}/src

src_install() {
	dobin exomizer
	dobin exobasic
}
