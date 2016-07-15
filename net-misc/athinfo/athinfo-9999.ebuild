EAPI="6"

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="Retrieve information about an Athena workstation"
HOMEPAGE="https://debathena.mit.edu/"
EGIT_REPO_URI="https://github.com/mit-athena/athinfo.git"
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

	doman "${S}/athinfo.1"

	insinto /usr/share/bash-completion/completions
	newins "${S}/bash_completion" athinfo
}
