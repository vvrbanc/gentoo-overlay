# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..14} )
PYTHON_REQ_USE="threads(+)"

inherit python-r1

DESCRIPTION="Piece of software used to help building software projects"
HOMEPAGE="https://waf.io/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://gitlab.com/ita1024/${PN}"
else
	SRC_URI="https://gitlab.com/ita1024/${PN}/-/archive/${P}/${PN}-${P}.tar.bz2"
	S="${WORKDIR}/${PN}-${P}"

	# FIXME: Fix install, then enable keywords.
	# KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"
RDEPEND="
	${PYTHON_DEPS}
"
BDEPEND="
	${RDEPEND}
"

src_configure() {
	python_foreach_impl ./waf-light configure
}

src_compile() {
	python_foreach_impl ./waf-light build
}

src_install() {
	sed -i waf \
		-e "/INSTALL=/s:=.*:='${EPREFIX}':" \
		-e "/REVISION=/s:=.*:='${PR}':" \
		-e "/dirname =/s:=.*:= '':" \
		-e "/^#\(==>\|BZ\|<==\)/d" \
		|| die

	python_foreach_impl python_doscript waf
	python_foreach_impl python_domodule waflib
}
