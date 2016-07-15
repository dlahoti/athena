EAPI="6"

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="graphical interface for the Moira service management system"
HOMEPAGE="https://sipb.mit.edu/"
EGIT_REPO_URI="https://github.com/mit-athena/moira-gui.git"
if [[ "${PV}" -ne "9999" ]]; then
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~x86 ~amd64"
else
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	${RDEPEND}
	dev-util/glade[python,${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i -e 's:gladeFile = "/usr/share/debathena-moira-gui/xmoira.glade":gladeFile = "/usr/share/xmoira/xmoira.glade":g' "${S}/xmoira" || die
	sed -i -e 's:Locker:X-Locker:g' "${S}/xmoira.desktop"

	eapply_user
}

src_install() {
	distutils-r1_src_install

	doman "${S}/xmoira.1"

	insinto /usr/share/xmoira
	doins "${S}/xmoira.glade"
	doins "${S}/xmoira.gladep"

	insinto /usr/share/applications
	doins "${S}/xmoira.desktop"
}
