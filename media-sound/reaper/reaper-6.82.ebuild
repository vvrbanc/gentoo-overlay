# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


DESCRIPTION="Reaper Digital Audio Workstation"
HOMEPAGE="https://reaper.fm"
SRC_URI="https://www.reaper.fm/files/6.x/reaper682_linux_x86_64.tar.xz"
LICENSE="Reaper"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""

QA_PREBUILT="
	.*
"

S=${WORKDIR}

src_install() {
	chmod -R ugo-w reaper_linux_x86_64/REAPER
	insinto /opt
	cp -a reaper_linux_x86_64/REAPER "${ED}"/opt || die "cp failed"
	dosym ../../opt/REAPER/reaper /usr/bin/reaper
}
