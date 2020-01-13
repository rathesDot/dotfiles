#!/bin/sh

cat vscode-extensions.txt | while read i; do
   code --install-extension $i
done