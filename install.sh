SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname $(realpath -s $0))

ln -s -f "${SCRIPTPATH}"/.zshrc ~/.zshrc
ln -s -f "${SCRIPTPATH}"/.zshrc_icons ~/.zshrc_icons
ln -s -f "${SCRIPTPATH}"/.tmux.conf ~/.tmux.conf
ln -s -f "${SCRIPTPATH}"/.dir_colors ~/.dir_colors
ln -s -f "${SCRIPTPATH}"/.alacritty.yml ~/.alacritty.yml
ln -s -f "${SCRIPTPATH}"/lfrc ~/.config/lf/lfrc

curl -L git.io/antigen > ~/.antigen.zsh

mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Italic/complete/Sauce%20Code%20Pro%20Italic%20Nerd%20Font%20Complete.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf
mv *.ttf ~/.local/share/fonts
