# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit toolchain-funcs

MY_P=${P//./_}

DESCRIPTION="A program to analyze and adjust MP3 files to same volume"
HOMEPAGE="http://mp3gain.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip
	media-sound/mpg123"

S=${WORKDIR}

src_prepare() {
	default
	sed -i \
		-e 's:CFLAGS= -Wall -O2:CFLAGS+= -Wall:' \
		-e 's:$(CC) -o:$(CC) $(LDFLAGS) -o:' \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin mp3gain || die
}
