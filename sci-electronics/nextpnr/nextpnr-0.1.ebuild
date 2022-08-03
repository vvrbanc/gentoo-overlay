EAPI=7

GIT_COMMIT=fd2d4a8f999947ece42f791e19ddc4c2d8b823f2
S=$WORKDIR/$PN-$GIT_COMMIT


DESCRIPTION="portable FPGA place and route tool"
HOMEPAGE="https://github.com/YosysHQ/nextpnr"
SRC_URI="https://github.com/YosysHQ/$PN/archive/$GIT_COMMIT.tar.gz -> $P.tar.gz"
LICENSE=ISC
SLOT=0
KEYWORDS=amd64
IUSE="+ice40 +ecp5 gui"

DEPEND="ice40? ( sci-electronics/icestorm
	>=dev-embedded/yosys-0.8 )
	ecp5? ( sci-electronics/prjtrellis
	>dev-embedded/yosys-0.8 )
	gui? ( dev-qt/qtcore:5
	virtual/opengl )
	dev-libs/boost
	dev-cpp/eigen"

src_unpack() {
	unpack $P.tar.gz
	rmdir $S/3rdparty/fpga-interchange-schema # $S/3rdparty/abseil-cpp
}

src_configure() {
	local mycmakeargs=(
		$(usex ice40 $(usex ecp5 "-DARCH=all" "-DARCH=ice40") $(usex ecp5 "-DARCH=ecp5" "-DARCH=generic"))
		$(usex ice40 -DICEBOX_ROOT=/usr/share/icebox "")
		$(usex ecp5 -DTRELLIS_ROOT=/usr/share/trellis "")
		$(usex gui -DBUILD_GUI=ON "")
	)
	cmake-utils_src_configure
}

