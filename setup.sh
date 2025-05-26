#!/usr/bin/env bash

set -euo pipefail

# Colors
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
NC="\033[0m"

# Package lists
PACMAN_PACKAGES=(
tree
firefox-developer-edition
rp-pppoe
base-devel
bluez
bluez-utils
nano
git
vim
vi
neofetch
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
chromium
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
git
unzip
zip 
xz glu 
ninja
lm_sensors
mesa
vulkan-intel
swtpm
noto-fonts-extra
)

PARU_PACKAGES=(
proton-vpn-gtk-app
arduino-ide-bin
portainer-bin
preload
parabolic
visual-studio-code-bin
vscodium-bin
lmstudio
google-chrome
postman-bin
android-studio
onlyoffice-bin
lorien-bin
xampp
mongodb-bin
mongodb-compass-bin
ttf-ms-fonts
ibus-avro-git
)

UNINSTALL_PACKAGES=(
  epiphany
)

# Logging helpers
log()    { echo -e "${GREEN}[+] $*${NC}"; }
warn()   { echo -e "${YELLOW}[!] $*${NC}"; }
error()  { echo -e "${RED}[x] $*${NC}" >&2; }

check_sudo() {
  if ! sudo -v; then
    error "Sudo access is required."
    exit 1
  fi
}

install_paru() {
  if ! command -v paru &>/dev/null; then
    warn "paru not found. Installing paru..."
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    pushd /tmp/paru >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null
    rm -rf /tmp/paru
    log "paru installed successfully."
  fi
}

install_pacman_packages() {
  log "Installing official packages with pacman..."
  sudo pacman -Syu --needed --noconfirm "${PACMAN_PACKAGES[@]}"
}

install_paru_packages() {
  log "Installing AUR packages with paru..."
  paru -S --needed --noconfirm "${PARU_PACKAGES[@]}"
}

uninstall_packages() {
  log "Uninstalling selected packages with paru..."
  paru -Rns --noconfirm "${UNINSTALL_PACKAGES[@]}"
}

show_dry_run() {
  echo -e "${YELLOW}Pacman packages to install:${NC}"
  printf '  - %s\n' "${PACMAN_PACKAGES[@]}"
  echo -e "\n${YELLOW}AUR packages to install:${NC}"
  printf '  - %s\n' "${PARU_PACKAGES[@]}"
  echo -e "\n${YELLOW}Packages to uninstall:${NC}"
  printf '  - %s\n' "${UNINSTALL_PACKAGES[@]}"
}


main_menu() {
  clear
  echo -e "${GREEN}Arch Linux Package Manager Menu${NC}"
  echo "-------------------------------------"
  echo "1) Install official (pacman) packages"
  echo "2) Install AUR (paru) packages"
  echo "3) Uninstall packages"
  echo "4) Dry run (preview)"
  echo "5) Exit"
  echo "-------------------------------------"

  read -rp "Choose an option [1-7]: " choice

  case "$choice" in
    1)
      install_pacman_packages
      ;;
    2)
      install_paru
      install_paru_packages
      ;;
    3)
      install_paru
      uninstall_packages
      ;;
    4)
      show_dry_run
      ;;
    5)
      echo "Goodbye!"
      exit 0
      ;;
    *)
      error "Invalid option. Try again."
      ;;
  esac

  echo -e "\nPress Enter to return to the menu..."
  read
  main_menu
}

# Run the script
check_sudo
install_paru
main_menu
