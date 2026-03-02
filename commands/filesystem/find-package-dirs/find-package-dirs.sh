#!/bin/bash

find-package-dirs() {
  find . -maxdepth 2 -type f -name package.json \
    -exec dirname {} \; | sort -u
}
