EAPI="6"

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="Python support for Moira"
HOMEPAGE="https://debathena.mit.edu/"
EGIT_REPO_URI="https://github.com/mit-athena/python-moira.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	${DEPEND}
	dev-python/pyrex[${PYTHON_USEDEP}]
	dev-python/moira-python[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
