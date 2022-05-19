SCRIPT=$(realpath "$0")
DIRPATH=$(dirname $(realpath -s $0))

ln -s -f "${DIRPATH}"/.zshrc ~/.zshrc
ln -s -f "${DIRPATH}"/.zshrc_icons ~/.zshrc_icons
ln -s -f "${DIRPATH}"/.tmux.conf ~/.tmux.conf
ln -s -f "${DIRPATH}"/.dir_colors ~/.dir_colors
ln -s -f "${DIRPATH}"/.alacritty.yml ~/.alacritty.yml
ln -s -f "${DIRPATH}"/lfrc ~/.config/lf/lfrc
ln -s -f "${DIRPATH}"/.i3.conf ~/.config/i3/config
ln -s -f "${DIRPATH}"/previewer.sh ~/.config/lf/previewer.sh

curl -L git.io/antigen > ~/.antigen.zsh

mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Italic/complete/Sauce%20Code%20Pro%20Italic%20Nerd%20Font%20Complete.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf
mv *.ttf ~/.local/share/fonts
