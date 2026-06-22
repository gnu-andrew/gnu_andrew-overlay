# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Fast and simple GTK+ image viewer"
HOMEPAGE="https://sourceforge.net/projects/xzgv/"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${PN}/${PV}/${P}.tar.gz/download -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-apps/gawk
	sys-apps/texinfo
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${P}-asneeded-and-cflags.patch
	"${FILESDIR}"/${P}-gcc15.patch
	"${FILESDIR}"/${P}-missing-install-dirs.patch
)

src_compile() {
	tc-export PKG_CONFIG

	emake CC="$(tc-getCC)"
	# all will also run pdf which requires virtual/texi2dvi
	emake -C doc CC="$(tc-getCC)" info man
}

src_install() {
	emake PREFIX="${D}/usr" install
	dodoc AUTHORS NEWS README TODO
}
