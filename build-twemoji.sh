#!/bin/bash
cd `dirname $0`
rm -rf dist/twemoji && mkdir -p dist/twemoji/svg  && mkdir -p src/
cd src
if [ -e ./twemoji ]; then 
cd ./twemoji && git pull -p && cd -
else
git clone https://github.com/twitter/twemoji.git
fi
cp -aR ./twemoji/assets/svg/*.svg ../dist/twemoji/svg
cd ..

# build dir
cd ./dist/twemoji
find svg/* -type l | xargs -I{} sh -c 'echo "`basename {}` `readlink {}`"' | sed -e "s/\([^.]*\)\.svg/\1/g" >> emoji_codes.txt
find svg/* -type l | xargs -L1 unlink

echo "" >> emoji_codes.txt

ls -L1 svg/ | sed -ne "s/^\([^.]*\)\.svg$/\1/p" >> emoji_codes.txt
