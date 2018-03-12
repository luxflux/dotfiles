#!/usr/bin/env bash

test ! -f ~/Library/Fonts/Hack-Regular.ttf && curl https://raw.githubusercontent.com/powerline/fonts/master/Hack/Hack-Regular.ttf > ~/Library/Fonts/Hack-Regular.ttf
test ! -f ~/Library/Fonts/Knack\ Regular\ Nerd\ Font\ Complete.ttf && curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Knack%20Regular%20Nerd%20Font%20Complete.ttf > ~/Library/Fonts/Knack\ Regular\ Nerd\ Font\ Complete.ttf

test ! -f ~/Library/Fonts/FuraCode-Bold.ttf && curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FiraCode/Bold/complete/Fura%20Code%20Bold%20Nerd%20Font%20Complete.ttf > ~/Library/Fonts/FuraCode-Bold.ttf
test ! -f ~/Library/Fonts/FuraCode-Light.ttf && curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FiraCode/Light/complete/Fura%20Code%20Light%20Nerd%20Font%20Complete.ttf > ~/Library/Fonts/FuraCode-Light.ttf
test ! -f ~/Library/Fonts/FuraCode-Medium.ttf && curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FiraCode/Medium/complete/Fura%20Code%20Medium%20Nerd%20Font%20Complete.ttf > ~/Library/Fonts/FuraCode-Medium.ttf
test ! -f ~/Library/Fonts/FuraCode-Regular.ttf && curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete.ttf > ~/Library/Fonts/FuraCode-Regular.ttf
test ! -f ~/Library/Fonts/FuraCode-Retina.ttf && curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete.ttf > ~/Library/Fonts/FuraCode-Retina.ttf
