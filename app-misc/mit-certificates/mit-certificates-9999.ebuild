EAPI="6"

inherit git-r3

DESCRIPTION="MIT CA certificates"
HOMEPAGE="https://ist.mit.edu/"
EGIT_REPO_URI="https://github.com/mit-athena/ssl-certificates.git"
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
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/ca-certificates/mit.edu
	doins "${S}"/*.crt
}
