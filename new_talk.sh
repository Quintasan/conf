#!/usr/bin/env bash

mkdir -p $1
cd $1
git init
git commit --allow-empty -m "Initial empty commit"
git submodule add https://github.com/hakimel/reveal.js reveal.js
cd reveal.js
git checkout `git tag -l | tac | head -n1`
cd ..
git add .
git commit -m "Add reveal.js as submodule"
touch slides.md custom.css
cp ~/conf/Makefile.revealjs Makefile
git add .
git commit -m "Initial version"
