#!/usr/bin/env bash

## Author : Twilight4
## Github : @Twilight4
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15

dir="$HOME/.config/rofi/launcher/"
theme='style'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
