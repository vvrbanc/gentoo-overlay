# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

# See https://wiki.freepascal.org/Lazarus_4.0_fixes_branch for notes and
# changes in FPCVER. It *does* change between minor versions of lazarus.
FPCVER="3.2.2"

MY_PV="${PV//./_}"

DESCRIPTION="feature rich visual programming environment emulating Delphi"
HOMEPAGE="https://www.lazarus-ide.org/ https://github.com/fpc/Lazarus"
SRC_URI="https://github.com/fpc/Lazarus/archive/refs/tags/${PN}_${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Lazarus-${PN}_${MY_PV}"

LICENSE="GPL-2 LGPL-2.1-with-linking-exception"
SLOT="0/4.8" # Note: Slotting Lazarus needs slotting fpc, see DEPEND.
KEYWORDS="~amd64 ~x86"
IUSE="+gui gtk2 gtk qt6 extras"
# TODO: Drop REQUIRED_USE per QA policy for USE=gui
REQUIRED_USE="gui? ( ^^ ( gtk2 gtk qt6 ) ) extras? ( gui )"

# Pascal ignores CFLAGS and does its own stripping. Nothing else can be done about it.
QA_FLAGS_IGNORED="
	usr/share/lazarus/startlazarus
	usr/share/lazarus/lazarus
	usr/share/lazarus/tools/lazres
	usr/share/lazarus/tools/lrstolfm
	usr/share/lazarus/tools/updatepofiles
	usr/share/lazarus/tools/svn2revisioninc
	usr/share/lazarus/lazbuild
	usr/share/lazarus/components/chmhelp/lhelp/lhelp
"
QA_PRESTRIPPED="${QA_FLAGS_IGNORED}"

DEPEND="
	>=dev-lang/fpc-${FPCVER}[source]
	>=sys-devel/binutils-2.19.1-r1:=
	gui? (
		gtk2? ( x11-libs/gtk+:2 )
		gtk? ( x11-libs/gtk+:3 )
		qt6? ( dev-libs/libqt6pas:0/4.8 )
	)
"
BDEPEND="net-misc/rsync"
RDEPEND="${DEPEND}"

RESTRICT="strip" #269221

src_prepare() {
	default

	# Allow compilers other than gcc to be used for locating libgcc
	find . -name Makefile -exec sed -i -e 's/`gcc /`${CC} /' {} + || die

	# Use default configuration (minus stripping) unless specifically requested otherwise
	if ! test ${PPC_CONFIG_PATH+set} ; then
		local FPCVER=$(fpc -iV)
		export PPC_CONFIG_PATH="${WORKDIR}"
		sed -e 's/^FPBIN=/#&/' /usr/lib/fpc/${FPCVER}/samplecfg |
			sh -s /usr/lib/fpc/${FPCVER} "${PPC_CONFIG_PATH}" || die
	fi
}

src_compile() {
	# bug #732758
	if use gui ; then
		if use gtk2 ; then
			export LCL_PLATFORM=gtk2
		elif use gtk ; then
			export LCL_PLATFORM=gtk3
		else
			export LCL_PLATFORM=qt6
		fi
	else
		export LCL_PLATFORM=nogui
	fi

	if use gui ; then
		emake -j1 all $(usev extras "bigide lhelp")
	else
		emake -j1 lazbuild
	fi
}

src_install() {
	diropts -m0755
	dodir /usr/share
	# Using rsync to avoid unnecessary copies and cleaning...
	# Note: *.o and *.ppu are needed
	rsync -a \
		--exclude="CVS"     --exclude=".cvsignore" \
		--exclude="*.ppw"   --exclude="*.ppl" \
		--exclude="*.ow"    --exclude="*.a"\
		--exclude="*.rst"   --exclude=".#*" \
		--exclude="*.~*"    --exclude="*.bak" \
		--exclude="*.orig"  --exclude="*.rej" \
		--exclude="*.app"   --exclude=".xvpics" \
		--exclude="*.compiled" --exclude="killme*" \
		--exclude=".gdb_hist*" --exclude="debian" \
		--exclude="COPYING*" --exclude=".git*" \
		"${S}"/ "${ED}"/usr/share/lazarus \
		|| die "Unable to copy files!"

	if ( use gui ) ; then
		dosym ../share/lazarus/startlazarus /usr/bin/startlazarus
		dosym ../share/lazarus/startlazarus /usr/bin/lazarus
	fi
	dosym ../share/lazarus/lazbuild /usr/bin/lazbuild
	use extras && dosym ../share/lazarus/components/chmhelp/lhelp/lhelp /usr/bin/lhelp
	dosym ../lazarus/images/ide_icon48x48.png /usr/share/pixmaps/lazarus.png

	use gui && make_desktop_entry startlazarus "Lazarus IDE" "lazarus"
}
