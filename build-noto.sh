#!/bin/bash
cd `dirname $0`
rm -rf dist/noto && mkdir -p dist/noto/svg  && mkdir -p src/
cd src
if [ -e ./noto-emoji ]; then 
cd ./noto-emoji && git pull -p && cd -
else
git clone https://github.com/googlefonts/noto-emoji.git
fi
cp -aR ./noto-emoji/svg/*.svg ../dist/noto/svg
cp -aR ./noto-emoji/third_party/region-flags/waved-svg/*.svg ../dist/noto/svg
cd ..

# build dir
cd ./dist/noto
find svg/* -type l | xargs -I{} sh -c 'echo "`basename {}` `readlink {}`"' | sed -e "s/emoji\_u\([^.]*\)\.svg/\1/g" >> emoji_codes.txt
find svg/* -type l | xargs -L1 unlink

echo "\n" >> emoji_codes.txt

ls -L1 svg/ | sed -ne "s/^emoji\_u\([^.]*\)\.svg$/\1/p" >> emoji_codes.txt
