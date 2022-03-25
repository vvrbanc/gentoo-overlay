# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/DISTRHO/Nekobi"
EGIT_COMMIT="da4ee81c92acd7a05f3cd116cf15afb172234566"

DESCRIPTION="Open source synthesizer plug-in"
HOMEPAGE="https://github.com/DISTRHO/Nekobi"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="-vst +vst3 -lv2"

DEPEND="
"
RDEPEND="${DEPEND}"
BDEPEND="
"

src_install() {
	use vst3 && dodir /usr/lib64/vst3
	use vst3 && cp -a ${S}/bin/Nekobi.vst3 ${D}/usr/lib64/vst3/
	use vst && dodir /usr/lib64/vst
	use vst && cp -a ${S}/bin/Nekobi-vst.so ${D}/usr/lib64/vst/
	use lv2 && dodir /usr/lib64/lv2
	use lv2 && cp -a ${S}/bin/Nekobi.lv2 ${D}/usr/lib64/lv2/
}
