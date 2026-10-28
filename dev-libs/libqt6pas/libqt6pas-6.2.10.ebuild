# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Get PV from lcl/interfaces/qt6/cbindings/Qt6Pas.pro
inherit qmake-utils

LAZARUS_PV=4.8
MY_PV="${LAZARUS_PV//./_}"

# We want to keep the version here in correspondence with dev-lang/lazarus
# so dev-lang/lazarus can use the bindings.
DESCRIPTION="Free Pascal Qt6 bindings library updated by lazarus IDE"
HOMEPAGE="https://gitlab.com/freepascal.org/lazarus/lazarus https://github.com/fpc/Lazarus"
SRC_URI="https://github.com/fpc/Lazarus/archive/refs/tags/lazarus_${MY_PV}.tar.gz -> lazarus-${LAZARUS_PV}.tar.gz"
S="${WORKDIR}/Lazarus-lazarus_${MY_PV}/lcl/interfaces/qt6/cbindings"

LICENSE="LGPL-3"
SLOT="0/${LAZARUS_PV}"
KEYWORDS="amd64 ~x86"

DEPEND="
	dev-qt/qtbase:6
"
RDEPEND="${DEPEND}"


src_configure() {
	eqmake6 Qt6Pas.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
