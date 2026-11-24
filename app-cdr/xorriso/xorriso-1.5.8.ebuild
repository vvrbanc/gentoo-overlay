# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GNU xorriso: ISO 9660 Rock Ridge filesystem manipulator (standalone bundle)"
HOMEPAGE="https://www.gnu.org/software/xorriso/"
SRC_URI="mirror://gnu/xorriso/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="acl readline xattr zlib"

RDEPEND="
	acl? ( virtual/acl )
	readline? ( sys-libs/readline:= )
	xattr? ( sys-apps/attr )
	zlib? ( virtual/zlib:= )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

# The tarball bundles libburn, libisofs and libisoburn and installs the same
# programs, so it cannot coexist with the separate Gentoo packages.
RDEPEND+="
	!dev-libs/libisoburn
"

src_configure() {
	# Bundled libraries are linked in; do not build separate shared ones.
	econf \
		--disable-static \
		--disable-debug \
		$(use_enable readline libreadline) \
		$(use_enable acl libacl) \
		$(use_enable xattr) \
		$(use_enable zlib) \
		--disable-libjte \
		--disable-libcdio \
		--disable-ldconfig-at-install
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
