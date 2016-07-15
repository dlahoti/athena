EAPI="6"

inherit git-r3 multilib

DESCRIPTION="utility to determine the machine type"
HOMEPAGE="https://sipb.mit.edu/"
EGIT_REPO_URI="https://github.com/mit-athena/machtype.git"
if [[ "${PV}" != 9999 ]]; then
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~amd64 ~x86 ~arm"
else
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND=""

UBUNTU="${UBUNTU:-yes}"
DEB_VERSION="${DEB_VERSION:-8.0}"
UBUNTU_VERSION="${UBUNTU_VERSION:-16.04}"

src_prepare() {
	sed -i -e "s:^#!/usr/bin/python:#!/usr/bin/env python2:" -e 's:"""Run a command.*""":return "":' "${S}/generate_sysnames.py"

	if ! has_multilib_profile; then
		sed -i -e "s/{'amd64': \\['i386'\\],/{'amd64': \\[\\],/" "${S}/generate_sysnames.py" || die
	fi

	eapply_user
}

src_compile() {
	local arch ubuntu
	if use amd64; then
		arch="amd64"
	elif use x86; then
		arch="i386"
	elif use arm; then
		arch="armel"
	fi
	if [[ "${UBUNTU}" = "yes" ]]; then
		ubuntu="ubuntu"
	else
		ubuntu="debian"
	fi
	export \
		OVERRIDE_MACHTYPE_DEB_VERSION="${DEB_VERSION}" \
		OVERRIDE_MACHTYPE_UBUNTU_VERSION="${UBUNTU_VERSION}" \
		OVERRIDE_MACHTYPE_LSB_ID="${ubuntu}" \
		OVERRIDE_MACHTYPE_ARCH="${arch}"
	emake
}
