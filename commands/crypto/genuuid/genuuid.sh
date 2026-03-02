#!/bin/bash

genuuid() {
  uuidgen | tr '[:upper:]' '[:lower:]'
}
