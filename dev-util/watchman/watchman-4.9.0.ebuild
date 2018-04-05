# Copyright 2018 Andrew Hughes
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit autotools git-r3 python-single-r1

#
# eclasses tend to list descriptions of how to use their functions properly.
# take a look at /usr/portage/eclass/ for more examples.

DESCRIPTION="A file watching service"
HOMEPAGE="https://facebook.github.io/watchman/"
# Sources are retrieved from git, so no source download
SRC_URI=""
EGIT_REPO_URI="https://github.com/facebook/watchman.git"
EGIT_COMMIT="v${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pcre python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="dev-libs/openssl
	pcre? ( dev-libs/libpcre )
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND} python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"

pkg_setup()
{
	use python && python-single-r1_pkg_setup
}

src_prepare()
{
	default
	eautoreconf
}

src_configure()
{
	econf \
		$(use_with pcre) \
		$(use_with python)
}
