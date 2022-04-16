# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

#EGIT_REPO_URI="https://github.com/surge-synthesizer/surge.git"
#EGIT_COMMIT="60228e84944cdba072be2d43bd4fe97b82c30a86"

MY_PV=$(ver_rs 3 '-')
MY_PN="Percona-Server"
MY_P="${PN}-${MY_PV}"
MY_MAJOR_PV=$(ver_cut 1-2)
MY_RELEASE_NOTES_URI="https://www.percona.com/doc/percona-server/5.7/release-notes/release-notes_index.html"

SRC_URI="https://www.percona.com/downloads/${MY_PN}-${MY_MAJOR_PV}/${MY_PN}-${MY_PV}/source/tarball/${PN}-${MY_PV}.tar.gz
	mirror://sourceforge/boost/boost_1_59_0.tar.gz
	"

HOMEPAGE="https://www.percona.com/software/mysql-database/percona-server"
LICENSE="GPL-2"
SLOT="5.7"
KEYWORDS="~amd64"

DEPEND="
	acct-group/mysql
	acct-user/mysql
	dev-db/mysql-init-scripts
"

src_unpack() {
	unpack ${A}
	mv -f "${WORKDIR}/${MY_P}" "${S}" || die
}

src_configure() {
	mycmakeargs=(
	-DMYSQL_DATADIR="${EPREFIX}/var/lib/mysql"
	-DSYSCONFDIR="${EPREFIX}/etc/mysql"
	-DINSTALL_BINDIR=bin
	-DINSTALL_DOCDIR=share/doc/${PF}
	-DINSTALL_DOCREADMEDIR=share/doc/${PF}
	-DINSTALL_INCLUDEDIR=include/mysql
	-DINSTALL_INFODIR=share/info
	-DINSTALL_LIBDIR=$(get_libdir)
	-DINSTALL_MANDIR=share/man
	-DINSTALL_MYSQLSHAREDIR=share/mysql
	-DINSTALL_PLUGINDIR=$(get_libdir)/mysql/plugin
	-DINSTALL_SCRIPTDIR=share/mysql/scripts
	-DINSTALL_MYSQLDATADIR="${EPREFIX}/var/lib/mysql"
	-DINSTALL_MYSQLTESTDIR=''
	-DINSTALL_SBINDIR=sbin
	-DINSTALL_SUPPORTFILESDIR="${EPREFIX}/usr/share/mysql"
	-DCOMPILATION_COMMENT="Gentoo Linux ${PF}"
	-DWITH_UNIT_TESTS=OFF
	-DMYSQL_UNIX_ADDR="${EPREFIX}/var/run/mysqld/mysqld.sock"
	-DWITH_BOOST="${WORKDIR}/boost_1_59_0"
	-DWITH_EXAMPLE_STORAGE_ENGINE=0
	-DWITH_ARCHIVE_STORAGE_ENGINE=1
	-DWITH_BLACKHOLE_STORAGE_ENGINE=1
	-DWITH_CSV_STORAGE_ENGINE=1
	-DWITH_FEDERATED_STORAGE_ENGINE=1
	-DWITH_HEAP_STORAGE_ENGINE=1
	-DWITH_INNOBASE_STORAGE_ENGINE=1
	-DWITH_INNODB_MEMCACHED=0
	-DWITH_MYISAMMRG_STORAGE_ENGINE=1
	-DWITH_MYISAM_STORAGE_ENGINE=1
	-DWITH_PARTITION_STORAGE_ENGINE=1
	-DWITH_ROCKSDB=0
	-DWITHOUT_TOKUDB=1
	-DWITH_EMBEDDED_SERVER=OFF
	-DWITH_LIBEVENT=system
	-DWITH_LZ4=system
	-DWITH_NUMA=ON
	-DWITH_EDITLINE=bundled
	-DWITH_ZLIB=system
	-DWITH_LIBWRAP=0
	-DENABLED_LOCAL_INFILE=1
	-DWITH_CURL=system
	)
	sed -i -e "s/.*_decompress.*//g" ${S}/extra/CMakeLists.txt
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -rf ${D}/usr/cmake
	rm -rf ${D}/usr/bin/mysql_config
	rm -rf ${D}/usr/bin/perror
	rm -rf ${D}/usr/bin/my_print_defaults
	rm -rf ${D}/usr/include/mysql/mysqld_error.h
	rm -rf ${D}/usr/include/mysql/mysql_version.h
	rm -rf ${D}/usr/include/mysql/errmsg.h
	rm -rf ${D}/usr/include/mysql/my_list.h
	rm -rf ${D}/usr/include/mysql/mysql_time.h
	rm -rf ${D}/usr/include/mysql/my_command.h
	rm -rf ${D}/usr/include/mysql/mysql_com.h
	rm -rf ${D}/usr/include/mysql/mysql.h
	rm -rf ${D}/usr/include/mysql/mysql/plugin_auth_common.h
	rm -rf ${D}/usr/include/mysql/mysql/client_plugin.h
	rm -rf ${D}/usr/share/man/man1/zlib_decompress*
	rm -rf ${D}/usr/share/man/man1/perror*
	rm -rf ${D}/usr/share/man/man1/my_print_defaults*
}
