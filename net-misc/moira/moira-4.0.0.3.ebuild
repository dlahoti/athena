EAPI="6"

inherit autotools

MY_PV="${PV}+51+g65d55c5"
MY_PN="${PN}-${MY_PV}"

DESCRIPTION="The Moira service management system"
HOMEPAGE="https://debathena.mit.edu/"
SRC_URI="https://github.com/mit-athena/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="+hesiod +zephyr"

RESTRICT="mirror"

DEPEND="
	virtual/krb5
	sys-libs/libtermcap-compat
	sys-libs/e2fsprogs-libs
	dev-libs/openssl
	hesiod? ( net-dns/hesiod )
	zephyr? ( net-im/zephyr )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN//+/-}/moira"

src_prepare() {
	local client toreplace

	cd "${S}" || die
	for client in chfn chsh; do
		toreplace=(
			"clients/Makefile.in"
			"clients/${client}/Makefile.in"
			"configure.in"
			"man/Makefile.in"
			"man/${client}.1"
			"man/moira.1"
			"configure"
		)
		for file in "${toreplace[@]}"; do
			sed -i -e "s:${client}:mr${client}:g" "${S}/${file}" || die
		done
		mv "${S}/man/${client}.1" "${S}/man/mr${client}.1" || die
		mv "${S}/clients/${client}/${client}.c" "${S}/clients/${client}/mr${client}.c" || die
		mv "${S}/clients/${client}" "${S}/clients/mr${client}" || die
	done

	eapply_user
}

src_configure() {
	econf --with-krb5 --with-com_err $(use_with hesiod) $(use_with zephyr)
}
