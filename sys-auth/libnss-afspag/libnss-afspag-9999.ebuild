EAPI="6"

inherit git-r3 multilib-build

DESCRIPTION="assign group names to AFS fake groups"
HOMEPAGE="https://debathena.mit.edu/"
EGIT_REPO_URI="https://github.com/mit-athena/libnss-afspag"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i -e 's: = : ?= :' "${S}/Makefile"

	eapply_user
}

src_install() {
	dolib.so "${S}/libnss_afspag.so.2"
}
