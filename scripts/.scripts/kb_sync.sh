#!/usr/bin/env sh

KB_PATH="/home/$USER/Documents/megasync/Notes"

cd "$KB_PATH"

CHANGES_EXIST="$(git status --porcelain | wc -l)"

if [ "$CHANGES_EXIST" -eq 0 ]; then
   exit 0
fi

git pull
git add .
git commit -q -m "Last sync: $(date +"%Y-%m-%d %H:%M:%S")"
git push -q
