#!/bin/bash

termux() {
    ln -sf $(pwd)/.termux/colors.properties ~/.termux/colors.properties
    ln -sf $(pwd)/.termux/termux.properties ~/.termux/termux.properties
}

command -v termux-info && termux || true
