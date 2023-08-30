EAPI="7"
inherit git-r3 autotools
DESCRIPTION="ULX2S / ULX3S JTAG programmer"
HOMEPAGE="https://github.com/kost/fujprog"
EGIT_REPO_URI="https://github.com/kost/fujprog"
EGIT_COMMIT="cc3ea93f2b8d36515a752c8d70be389bf0ed29e8"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-embedded/libftdi
"
