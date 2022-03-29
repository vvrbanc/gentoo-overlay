# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

inherit git-r3

DESCRIPTION="SOIL is a tiny C library used primarily for uploading textures into OpenGL."
HOMEPAGE="https://github.com/littlstar/soil"
EGIT_REPO_URI="https://github.com/littlstar/soil"
EGIT_COMMIT="acf8852eb82dd00105f40ec52424dc049665a306"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="virtual/opengl"
RDEPEND="virtual/opengl"

src_install() {
	dodir /usr/include/SOIL
	dodir /usr/lib64
	cp -a ${S}/${CBUILD}/include/SOIL/* ${D}/usr/include/SOIL/
	cp -a ${S}/${CBUILD}/lib/* ${D}/usr/lib64/
}

#pkg_postinst() {
#	mkdir /usr/include/SOIL
#	ln -s /usr/include/SOIL.h /usr/include/SOIL/SOIL.h
#	einfo "/usr/include/SOIL.h header file was linked to"
#	einfo "/usr/include/SOIL/SOIL.h."
#}

#pkg_postrm() {
#	rm -rf /usr/include/SOIL
#}
