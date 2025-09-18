# 🚀 Arch Linux Setup Kit

Welcome to the ultimate collection of scripts and configuration files designed to make your Arch Linux installation and setup a breeze! This repository is your one-stop solution for a fast, consistent, and highly personalized Arch system.

---

## ✨ Features

* **⚡ Automated Installation:** Say goodbye to long, manual setups. Our interactive `setup.sh` script automates the installation of essential packages from both the official Arch repositories and the AUR.
* **🔧 Customizable Package Lists:** Easily tailor your system to your needs. Just open `setup.sh` and add or remove packages from the pre-defined lists.
* **🎨 Post-Installation Configuration:** Instantly apply your favorite aesthetics and functionality. The `config` directory holds custom configurations for popular tools like `fastfetch` and `starship`.
* **📚 Utility Guides:** Get help with specific tasks! The `tools` directory is packed with simple text files containing commands and instructions for setting up popular software and services.
* **📖 Manual Setup Guide:** For those who prefer a hands-on approach, a detailed `manual_setup.txt` file is included, walking you through every step of the installation process.

## 📦 What's Inside?

```

.
├── 📜 setup.sh (The main installer script)
├── ✍️ manual\_setup.txt (The step-by-step guide)
├── ⚙️ config/
│   ├── 💻 fastfetch/ (System info display configurations)
│   │   ├── assets/
│   │   │   └── ... (Custom images and ASCII art)
│   │   └── presets/
│   │       └── ... (Custom display layouts)
│   └── ✨ starship.toml (Custom terminal prompt)
└── 🔧 tools/
├── 📦 paru.txt (AUR helper setup)
├── 🖥️ grub.txt (Bootloader configuration)
├── 🧠 ollama.txt (Local LLM setup)
├── 🐍 python versions.txt (Python version management)
└── ... (Many more helpful guides\!)

````

## 📝 How to Use

Follow these simple steps to get started:

1.  **1️⃣ Clone the Repository**

    Navigate to your desired directory and clone this repository using Git.

    ```bash
    git clone [https://github.com/Bishwajit-2810/arch_setup](https://github.com/Bishwajit-2810/arch_setup)
    cd arch_setup
    ```

2.  **2️⃣ Make the Script Executable**

    Give the script the necessary permissions to run.

    ```bash
    chmod +x setup.sh
    ```

3.  **3️⃣ Run the Script**

    Execute the script from your terminal.

    ```bash
    ./setup.sh
    ```

4.  **4️⃣ Follow the Menu**

    An interactive menu will guide you through the process of installing, uninstalling, or previewing packages.

## ⚠️ Important Notes

* **Always** run the **dry run** option first to ensure you understand all changes before they are applied. 🚨
* The `setup.sh` script requires `sudo` privileges to install system packages.
* The script will automatically install the `paru` AUR helper if it's not already on your system.
* Some packages may require extra steps or manual configuration. Check the `tools` directory for specific instructions.

**Happy Arching!** 😄
