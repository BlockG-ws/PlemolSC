#!/bin/bash
set -e

mkdir -p source/IBM-Plex-Mono
mkdir -p source/IBM-Plex-Sans-SC/unhinted
mkdir -p source/hack
mkdir -p source/nerd-fonts

echo "Downloading IBM Plex Mono..."
curl -sL -o /tmp/ibm-plex-mono.zip "https://github.com/IBM/plex/releases/download/%40ibm/plex-mono%402.5.0/ibm-plex-mono.zip"
unzip -q -j -o /tmp/ibm-plex-mono.zip "ibm-plex-mono/fonts/split/ttf/*" -d source/IBM-Plex-Mono || true
# Fallback if structure is different
if [ ! -f "source/IBM-Plex-Mono/IBMPlexMono-Regular.ttf" ]; then
    unzip -q -j -o /tmp/ibm-plex-mono.zip "*.ttf" -d source/IBM-Plex-Mono || true
fi

echo "Downloading IBM Plex Sans SC..."
curl -sL -o /tmp/ibm-plex-sans-sc.zip "https://github.com/IBM/plex/releases/download/%40ibm/plex-sans-sc%401.1.0/ibm-plex-sans-sc.zip"
unzip -q -j -o /tmp/ibm-plex-sans-sc.zip "ibm-plex-sans-sc/fonts/split/ttf/unhinted/*" -d source/IBM-Plex-Sans-SC/unhinted || true
if [ ! -f "source/IBM-Plex-Sans-SC/unhinted/IBMPlexSansSC-Regular.ttf" ]; then
    unzip -q -j -o /tmp/ibm-plex-sans-sc.zip "*.ttf" -d source/IBM-Plex-Sans-SC/unhinted || true
fi

echo "Downloading Hack fonts..."
curl -sL -o /tmp/hack.zip "https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip"
unzip -q -j -o /tmp/hack.zip "ttf/Hack-Regular.ttf" "ttf/Hack-Bold.ttf" -d source/hack || true

echo "Downloading Nerd Fonts..."
# SymbolsNerdFont-Regular.ttf
curl -sL -o /tmp/NerdFontsSymbolsOnly.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip"
unzip -q -j -o /tmp/NerdFontsSymbolsOnly.zip "SymbolsNerdFont-Regular.ttf" -d source/nerd-fonts || true

# BlexMonoNerdFont-Regular.ttf
curl -sL -o /tmp/IBMPlexMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/IBMPlexMono.zip"
unzip -q -j -o /tmp/IBMPlexMono.zip "BlexMonoNerdFont-Regular.ttf" -d source || true

echo "Done!"
