#!/bin/sh

git fetch --all
git reset --hard
git clean -df
git pull

flutter build web
