#!/usr/bin/env bash

if [ "$#" -lt 1 ]; then
    echo "don't forget to provide the year to use as the directory (e.g. 2019-2020)"
    exit
fi

repo=annualreport-archive

wget --mirror            \
     --convert-links     \
     --html-extension    \
     --wait=2            \
     -o log              \
     https://annualreport.ep.wisc.edu/

cd annualreport.ep.wisc.edu
sed -i -e 's/window.cookieconsent.initialize()//g' $(find . -name "*.html")
cd ..
mv annualreport.ep.wisc.edu $repo/$1
cd $repo
git add $1
git commit -m "Adding archive for $1"
echo "git push uw-ep main"
