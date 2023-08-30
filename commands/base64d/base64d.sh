#!/bin/bash

base64d() {
  "$(echo -n "$1" | base64 --decode)"
}
