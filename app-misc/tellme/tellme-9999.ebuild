EAPI="6"

inherit git-r3

DESCRIPTION="utility to provide Athena-specific information"
HOMEPAGE="https://sipb.mit.edu/"
EGIT_REPO_URI="https://github.com/mit-athena/tellme.git"
if [[ "${PV}" != 9999 ]]; then
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	sys-apps/machtype
	net-fs/locker-support
"
RDEPEND="${DEPEND}"

src_install() {
	dobin "${S}/tellme"
	doman "${S}/tellme.1"
}
