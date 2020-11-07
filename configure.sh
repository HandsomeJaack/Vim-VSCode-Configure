#!/usr/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./vim/vimrc ~/.vim
mkdir ~/.vim/colors && cp ./vim/monokai.vim ~/.vim/colors
echo "Installing Vim plugins..."
vim +PluginInstall +qall
echo "Done..."


command ldconfig -p | grep libpython3 >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Error: 'python3-devel' must be installed to build Vim autocompletion."
        return 1
    fi

command -v cmake >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Error: 'cmake' must be installed to build Vim autocompletion."
        return 1
    fi

command -v clang >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Error: 'clang' must be installed to build Vim autocompletion."
        return 1
    fi

echo "Building vim autocompletion..."
python3 ~/.vim/bundle/YouCompleteMe/install.py
echo "Done."

echo "Installing VSCode extensions..."
while IFS="" read -r p || [ -n "$p" ]
do
  code --install-extension $p
done < ./code/extentions_list
echo "Done."
