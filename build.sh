#!/bin/bash

WORKDIR=`pwd`
BUILDDIR=$WORKDIR/build

# clean slate
rm -rf $BUILDDIR
mkdir build

# check out submodules
git submodule update --init --recursive
VINE=$WORKDIR/vinesweeper
TEXT=$BUILDDIR/text
WIND=$BUILDDIR/windbag

# install build tools
rustup default stable
cargo install wasm-pack

# build the text-only page
mkdir $TEXT
cd $VINE
git checkout text
cd $WORKDIR
cp -r $VINE/* $TEXT

# build the wind page
mkdir $WIND
cd $VINE
git checkout wind
wasm-pack build --target web --no-typescript --no-pack
cd $WORKDIR
cp -r $VINE/* $WIND
