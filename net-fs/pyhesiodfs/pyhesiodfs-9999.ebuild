EAPI="6"

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1 user

DESCRIPTION="Hesiod-based AFS locker automounter"
HOMEPAGE="https://debathena.mit.edu/"
EGIT_REPO_URI="https://github.com/mit-athena/pyhesiodfs.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE="systemd"

RDEPEND="
	${RDEPEND}
	dev-python/fuse-python[${PYTHON_USEDEP}]
	net-fs/locker-support[${PYTHON_USEDEP}]
	dev-python/configparser[${PYTHON_USEDEP}]
	net-fs/openafs
"

pkg_setup() {
	enewgroup pyhesiodfs
	enewuser pyhesiodfs -1 -1 -1 "pyhesiodfs"
}

src_install() {
	distutils-r1_src_install

	newinitd "${FILESDIR}/pyhesiodfs.init" pyhesiodfs
	newconfd "${FILESDIR}/pyhesiodfs.conf" pyhesiodfs
	if use systemd; then
		insinto /usr/lib/systemd/system
		doins "${FILESDIR}/pyhesiodfs-setup.service"
		doins "${FILESDIR}/pyhesiodfs.service"
	fi

	insinto /etc
	newins "${FILESDIR}/pyhesiodfs.etc" pyhesiodfs
}

pkg_postinst() {
	elog "FUSE must be configured with user_allow_other in /etc/fuse.conf for the daemon to run as pyhesiodfs"
}
