#!/bin/bash
set -e

if [[ "$*" == npm*start* ]]; then

	if [ ! -e "$GHOST_CONTENT/config.js" ]; then
		sed -r '
		s/127\.0\.0\.1/0.0.0.0/g;
		s!path.join\(__dirname, (.)/content!path.join(process.env.GHOST_CONTENT, \1!g;
		' "$GHOST_SOURCE/config.example.js" > "$GHOST_SOURCE/config.js"
	fi

	ln -sf "$GHOST_CONTENT/config.js" "$GHOST_SOURCE/config.js"

	chown -R user "$GHOST_CONTENT"

	set -- gosu user "$@"
fi

exec "$@"
