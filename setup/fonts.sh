#!/usr/bin/env bash

test ! -f ~/Library/Fonts/Hack-Regular.ttf && curl https://raw.githubusercontent.com/powerline/fonts/master/Hack/Hack-Regular.ttf > ~/Library/Fonts/Hack-Regular.ttf
test ! -f ~/Library/Fonts/Knack\ Regular\ Nerd\ Font\ Complete.ttf && curl https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Knack%20Regular%20Nerd%20Font%20Complete.ttf > ~/Library/Fonts/Knack\ Regular\ Nerd\ Font\ Complete.ttf
