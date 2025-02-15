#!/usr/bin/env bash

if [ -d build ]; then
  rm -rf build
fi

if [ -d lambda ]; then
  rm -rf lambda
fi

# Recreate build directory
mkdir -p build/function/ build/layer/

# Copy source files
echo "Copy source files"
cp -r src build/function/

# Pack python libraries
echo "Pack python libraries"
#pip install -r requirements.txt -t build/layer/python
pip install -r requirements.txt --no-deps -t build/layer/python

# Remove pycache in build directory
find build -type f | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm