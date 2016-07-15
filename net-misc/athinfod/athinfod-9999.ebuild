EAPI="6"

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="Host information about an Athena workstation"
HOMEPAGE="https://sipb.mit.edu/"
EGIT_REPO_URI="https://github.com/mit-athena/athinfod.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

src_install() {
	distutils-r1_src_install

	doman "${S}/athinfod.8"
	doman "${S}/athinfo.access.5"
	doman "${S}/athinfo.defs.5"

	mv "${D}/usr/bin" "${D}/usr/sbin" || die
}
