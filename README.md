# Arch Linux Setup Kit

This repository provides a collection of scripts and configuration files to streamline and automate the installation and post-installation setup of Arch Linux. The goal is to create a consistent, personalized, and efficient system setup with minimal manual intervention.

## 🚀 Features

* **Automated Installation:** Use a single, interactive shell script (`setup.sh`) to install and configure essential packages from both the official Arch repositories and the Arch User Repository (AUR).

* **Customizable Package Lists:** Easily modify the package lists in `setup.sh` to include or exclude the software you need.

* **Post-Installation Configuration:** A dedicated `config` directory contains custom configuration files for popular tools like `fastfetch` and `starship`, allowing you to instantly apply your preferred aesthetics and functionality.

* **Utility Scripts & Guides:** The `tools` directory contains standalone text files with useful commands and instructions for setting up common applications and services after the main installation.

* **Manual Setup Guide:** A fallback `manual_setup.txt` file is included for users who prefer to follow a step-by-step guide and understand the installation process in detail.

## 📦 What's Inside?

### `setup.sh`

This is the main script that drives the package installation process. It features a simple menu-driven interface to:

* Install core packages via `pacman`.

* Install AUR packages via the `paru` helper.

* Uninstall a pre-defined list of packages.

* Perform a dry run to preview all actions before execution.

### `config/`

This directory holds configuration files for various applications:

* **`fastfetch/`:** Custom assets and presets to tailor the `fastfetch` system information display.

* **`starship.toml`:** A configuration file for `Starship`, a minimal, blazing-fast, and customizable prompt for any shell.

### `tools/`

This directory contains simple text files with commands and notes for setting up specific software and services, such as:

* `paru.txt` (Installing the `paru` AUR helper)

* `grub.txt` (GRUB bootloader setup)

* `ollama.txt` (Local LLM setup)

* `python versions.txt` (Managing Python versions)

* And many more...

### `manual_setup.txt`

A comprehensive, commented text file that walks you through each step of the Arch Linux installation, from partitioning and formatting to user setup and bootloader configuration.

## 📝 How to Use

1. Clone this repository to your system:

```

git clone [https://github.com/Bishwajit-2810/arch\_setup](https://github.com/Bishwajit-2810/arch_setup)
cd arch\_setup

```

2. Make the `setup.sh` script executable:

```

chmod +x setup.sh

```

3. Run the script:

```

./setup.sh

```

4. Follow the on-screen menu to choose your desired action.

## ⚠️ Important Notes

* Always perform a **dry run** first to see what packages will be installed or removed.

* The `setup.sh` script requires `sudo` privileges for package installation.

* For the AUR installation to work, the script will first automatically install the `paru` AUR helper if it's not already present on your system.

* Some packages may require manual intervention or additional configuration. Always review the included text files for specific instructions.

**Happy Arching!**
