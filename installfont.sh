#!/bin/sh

set -uex

install_path="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/material-design-icons"
url_prefix="https://raw.githubusercontent.com/google/material-design-icons/master/font"
fonts="MaterialIcons-Regular.ttf MaterialIconsOutlined-Regular.otf MaterialIconsRound-Regular.otf"
fonts="$fonts MaterialIconsSharp-Regular.otf MaterialIconsTwoTone-Regular.otf"

for font in $fonts
do
	wget \
		--no-verbose \
		--directory-prefix="$install_path" \
		--output-document="$font" \
		"$url_prefix/$font"
done
