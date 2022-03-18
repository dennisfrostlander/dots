SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname $(realpath -s $0))

ln -s -f "${SCRIPTPATH}"/.zshrc ~/.zshrc
ln -s -f "${SCRIPTPATH}"/.zshrc_icons ~/.zshrc_icons
ln -s -f "${SCRIPTPATH}"/.tmux.conf ~/.tmux.conf
ln -s -f "${SCRIPTPATH}"/.dir_colors ~/.dir_colors
ln -s -f "${SCRIPTPATH}"/.alacritty.yml ~/.alacritty.yml
ln -s -f "${SCRIPTPATH}"/lfrc ~/.config/lf/lfrc
