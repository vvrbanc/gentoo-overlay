# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )
inherit python-any-r1

ABC_COMMIT="85b74f68f19fc4857daba703f909a02410f04065"
EGIT_COMMIT="2156e20db5b88ac7e3530abd2f27d27e12a412b2"

SRC_URI="https://github.com/YosysHQ/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${PN}-${EGIT_COMMIT}.tar.gz https://github.com/berkeley-abc/abc/archive/${ABC_COMMIT}.tar.gz -> berkeley-abc-${ABC_COMMIT}.tar.gz"

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+abc"

RDEPEND="
	sys-libs/readline:=
	dev-libs/libffi:=
	dev-vcs/git
	dev-lang/tcl:="

DEPEND="
	${PYTHON_DEPS}
	sys-devel/bison
	sys-devel/flex
	sys-apps/gawk
	virtual/pkgconfig
	${RDEPEND}"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_prepare() {
	ln -s "${WORKDIR}/abc-${ABC_COMMIT}" abc
	sed "s/^ABCREV = .*/ABCREV = default/g" -i Makefile
	default
}

src_configure() {
	emake config-gcc
	echo "ENABLE_ABC := $(usex abc 1 0)" >> "${S}/Makefile.conf"
}

src_compile() {
	emake PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake PREFIX="${ED}/usr" STRIP=true install
}
