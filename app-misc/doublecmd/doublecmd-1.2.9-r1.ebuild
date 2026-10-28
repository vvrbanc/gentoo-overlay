# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Cross platform open source file manager with two panels side by side"
HOMEPAGE="https://doublecmd.sourceforge.io/ https://github.com/doublecmd/doublecmd"
SRC_URI="https://github.com/doublecmd/doublecmd/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2+ LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="amd64"
IUSE="-samba -unrar -7zip"

# Optional libraries are loaded with dlopen() at runtime
RDEPEND="
	dev-libs/glib:2
	dev-libs/libqt6pas:=
	dev-libs/openssl
	dev-lang/lua:5.1
	x11-libs/libX11
	samba? ( net-fs/samba )
	unrar? ( app-arch/unrar )
	7zip? ( app-arch/7zip )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-lang/fpc
	>=dev-lang/lazarus-4.2[gui,qt6]
"

# Free Pascal does its own stripping and ignores CFLAGS/LDFLAGS
QA_FLAGS_IGNORED="usr/lib.*/doublecmd/.*"
QA_PRESTRIPPED="${QA_FLAGS_IGNORED}"
RESTRICT="strip"

src_compile() {
	# build.sh calls whichever lazbuild is first in PATH; wrap it to use a
	# private configuration directory and the system-wide Lazarus tree
	mkdir -p "${T}/bin" "${T}/lazarus-config" || die
	cat > "${T}/bin/lazbuild" <<-EOF || die
		#!/bin/sh
		exec "${EPREFIX}/usr/share/lazarus/lazbuild" \\
			--pcp="${T}/lazarus-config" \\
			--lazarusdir="${EPREFIX}/usr/share/lazarus" "\$@"
	EOF
	chmod +x "${T}/bin/lazbuild" || die
	export PATH="${T}/bin:${PATH}"

	./build.sh release qt6 || die "build failed"
}

src_install() {
	./install/linux/install.sh --install-prefix="${D}" || die "install failed"
}
