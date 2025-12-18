#!/usr/bin/env bash

set -euo pipefail

# Colors
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
NC="\033[0m"

# Package lists
PACMAN_PACKAGES=(
ptyxis
tree
epiphany
firefox-developer-edition
rp-pppoe
base-devel
bluez
bluez-utils
nano
git
vim
vi
bat
fzf
btop
ranger
speedtest-cli
ffmpeg
man
tldr
gufw
mission-center
cameractrls
cmatrix
figlet
cava
sl
p7zip
unrar
tar
rsync
htop
ntfs-3g
nvm
flac
jasper
aria2
jdk-openjdk
intel-ucode
flatpak
libreoffice-fresh
vlc
gimp
thunderbird
kdenlive
krita
inkscape
obs-studio
ufw
bash-completion
unzip
enchant
mythes-en
ttf-liberation
hunspell-en_US
ttf-bitstream-vera
pkgstats
adobe-source-sans-pro-fonts
gst-plugins-good
ttf-droid
ttf-dejavu
aspell-en
icedtea-web
gst-libav
ttf-ubuntu-font-family
ttf-anonymous-pro
jre8-openjdk
languagetool
libmythes
starship
gnome-font-viewer
a52dec
faac
faad2
lame
libdca
libdv
libmad
libmpeg2
libtheora
libvorbis
libxv
wavpack
x264
xvidcore
intellij-idea-community-edition
pycharm-community-edition
mpv
python-pip
cargo
exfat-utils
curl
wget
gcc
make
bzip2
cmake
gstreamer-vaapi
linux-headers
vulkan-tools
vulkan-validation-layers
fastfetch
nodejs
npm
bleachbit
nvtop
cpufetch
go
yazi
qbittorrent
archlinux-keyring
guvcview
neovim
gnome-browser-connector
qemu-full
virt-manager
virt-viewer
dnsmasq
bridge-utils
vde2
bpytop
clang
cargo
samba
openbsd-netcat
rocm-hip-sdk
ollama-cuda
cuda
cuda-tools
nvidia-container-toolkit
nvidia-utils
nvidia-settings
mysql-workbench
os-prober
spotify-launcher
base-devel
openssl
zlib
xz
tk
jupyter-notebook
pyenv
drawio-desktop
docker
docker-compose
touchegg
gnome-shell-extensions
gnome-menus
python-pipx
curl
mesa-utils
git
steam
unzip
zip 
xz glu 
ninja
lm_sensors
mesa
vulkan-intel
swtpm
noto-fonts-extra
python-pyqt6
iotas
ptyxis
telegram-desktop
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
noto-fonts-extra
ttf-dejavu
ttf-liberation
ttf-roboto
noto-fonts-extra
)

PARU_PACKAGES=(
mongodb-compass-bin
ttf-google-sans
ttf-google
xnviewmp
proton-vpn-gtk-app
portainer-bin
preload
parabolic
planify 
#devtoolbox # module Issue
visual-studio-code-bin
visual-studio-code-insiders-bin
#vscodium-bin
google-chrome
postman-bin
android-studio
onlyoffice-bin
lorien-bin
xampp
mongodb-bin
hydra-launcher-bin
protontricks
lutris
protonplus
heroic-games-launcher-bin
protonup-qt-bin
ttf-ms-fonts
ibus-avro-git
extension-manager
ttf-google-sans
ttf-google
pencil
)

UNINSTALL_PACKAGES=(
epiphany
potrace
gimp
inkscape
intellij-idea-community-edition
iotas
krita
mpv
pycharm-community-edition
heroic-games-launcher-bin
lutris
)

# --------------------------------------------------
# Logging helpers
# --------------------------------------------------
log()   { echo -e "${GREEN}[+] $*${NC}"; }
warn()  { echo -e "${YELLOW}[!] $*${NC}"; }
error() { echo -e "${RED}[x] $*${NC}" >&2; }

# --------------------------------------------------
# Sudo check
# --------------------------------------------------
check_sudo() {
  if ! sudo -v; then
    error "Sudo access is required."
    exit 1
  fi
}

# --------------------------------------------------
# AUR helper mode (selected once)
# --------------------------------------------------
AUR_HELPER_MODE=""

select_aur_helper() {
  echo -e "${GREEN}Select AUR helper${NC}"
  echo "-------------------------------------"
  echo "1) paru"
  echo "2) yay"
  echo "3) both (paru → yay fallback)"
  echo "-------------------------------------"

  read -rp "Choose [1-3]: " choice

  case "$choice" in
    1) AUR_HELPER_MODE="paru" ;;
    2) AUR_HELPER_MODE="yay" ;;
    3) AUR_HELPER_MODE="both" ;;
    *)
      error "Invalid choice."
      select_aur_helper
      ;;
  esac
}

# --------------------------------------------------
# Install selected AUR helpers
# --------------------------------------------------
install_aur_helpers() {

  if [[ "$AUR_HELPER_MODE" == "paru" || "$AUR_HELPER_MODE" == "both" ]]; then
    if ! command -v paru &>/dev/null; then
      warn "Installing paru..."
      git clone https://aur.archlinux.org/paru.git /tmp/paru
      pushd /tmp/paru >/dev/null
      makepkg -si --noconfirm
      popd >/dev/null
      rm -rf /tmp/paru
      log "paru installed."
    fi
  fi

  if [[ "$AUR_HELPER_MODE" == "yay" || "$AUR_HELPER_MODE" == "both" ]]; then
    if ! command -v yay &>/dev/null; then
      warn "Installing yay..."
      git clone https://aur.archlinux.org/yay.git /tmp/yay
      pushd /tmp/yay >/dev/null
      makepkg -si --noconfirm
      popd >/dev/null
      rm -rf /tmp/yay
      log "yay installed."
    fi
  fi
}

# --------------------------------------------------
# Unified AUR runner
# --------------------------------------------------
aur() {
  case "$AUR_HELPER_MODE" in
    paru) paru "$@" ;;
    yay)  yay "$@" ;;
    both)
      if command -v paru &>/dev/null; then
        paru "$@"
      else
        yay "$@"
      fi
      ;;
    *)
      error "AUR helper not set."
      exit 1
      ;;
  esac
}

# --------------------------------------------------
# Package operations
# --------------------------------------------------
install_pacman_packages() {
  log "Installing official packages with pacman..."
  sudo pacman -Syu --needed --noconfirm "${PACMAN_PACKAGES[@]}"
}

install_aur_packages() {
  log "Installing AUR packages..."
  aur -S --needed --noconfirm "${AUR_PACKAGES[@]}"
}

uninstall_packages() {
  log "Uninstalling selected packages..."
  aur -R --noconfirm "${UNINSTALL_PACKAGES[@]}"
}

# --------------------------------------------------
# Dry run
# --------------------------------------------------
show_dry_run() {
  echo -e "${YELLOW}Pacman packages to install:${NC}"
  printf '  - %s\n' "${PACMAN_PACKAGES[@]}"

  echo -e "\n${YELLOW}AUR packages to install:${NC}"
  printf '  - %s\n' "${AUR_PACKAGES[@]}"

  echo -e "\n${YELLOW}Packages to uninstall:${NC}"
  printf '  - %s\n' "${UNINSTALL_PACKAGES[@]}"
}

# --------------------------------------------------
# Menu (no helper spam)
# --------------------------------------------------
main_menu() {
  clear
  echo -e "${GREEN}Arch Linux Package Manager Menu${NC}"
  echo "-------------------------------------"
  echo "1) Install official (pacman) packages"
  echo "2) Install AUR packages"
  echo "3) Uninstall packages"
  echo "4) Dry run (preview)"
  echo "5) Exit"
  echo "-------------------------------------"

  read -rp "Choose an option [1-5]: " choice

  case "$choice" in
    1) install_pacman_packages ;;
    2) install_aur_helpers; install_aur_packages ;;
    3) install_aur_helpers; uninstall_packages ;;
    4) show_dry_run ;;
    5) exit 0 ;;
    *) error "Invalid option." ;;
  esac

  read -rp "Press Enter to return to the menu..."
  main_menu
}

# --------------------------------------------------
# Script entry point
# --------------------------------------------------
check_sudo
select_aur_helper
install_aur_helpers
main_menu

