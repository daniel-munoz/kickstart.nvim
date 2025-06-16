# kickstart.nvim (AI-Enhanced Fork)

## Introduction

A customized starting point for Neovim that is:

* Small
* Single-file
* Completely Documented
* **AI-Enhanced** with Claude Code, GitHub Copilot, and Avante integration
* **Environment-gated** for conditional feature activation

**NOT** a Neovim distribution, but instead a sophisticated starting point for AI-powered development workflows.

## Key Features

This fork extends the original kickstart.nvim with:

### 🤖 AI Assistant Integration
- **Claude Code**: Direct integration with Claude for coding assistance (environment-gated)
- **GitHub Copilot**: Full code completion and chat capabilities  
- **Avante**: Multi-provider AI assistant (Claude, OpenAI, Copilot, Gemini)

### 🚀 Enhanced Productivity
- **Advanced Navigation**: File tree (NvimTree), code outline (Aerial), fuzzy finding (Telescope)
- **Terminal Integration**: Floating and split terminals with seamless workflow
- **Search & Replace**: Powerful search with CtrlSF
- **Git Integration**: Enhanced git workflow with vim-fugitive

### ⚙️ Environment-Based Configuration
Features are conditionally enabled via environment variables:
- `PROJECT_CONTEXT=personal` - Enables Claude Code integration
- `NVIM_COPILOT=true` - Enables GitHub Copilot features
- `NVIM_AVANTE=true` - Enables Avante AI assistant

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): **Required** for icons in file tree and UI
  - Set `vim.g.have_nerd_font = true` in `init.lua` (default in this fork)
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

#### AI Assistant Setup (Optional)
- **Claude Code**: Set `PROJECT_CONTEXT=personal` environment variable
- **GitHub Copilot**: Set `NVIM_COPILOT=true` and authenticate with `:Copilot auth`
- **Avante**: Set `NVIM_AVANTE=true` and configure API keys for desired providers

> [!NOTE]
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> [!NOTE]
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> This fork's URL is: `https://github.com/daniel-munoz/kickstart.nvim.git`

> [!IMPORTANT]  
> This fork tracks `lazy-lock.json` in version control for reproducible plugin versions.
> The `.gitignore` has been updated to include this file, ensuring consistent plugin
> versions across different installations.

#### Clone This Fork

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/daniel-munoz/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/daniel-munoz/kickstart.nvim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/daniel-munoz/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
the current plugin status. Hit `q` to close the window.

#### Read The Friendly Documentation

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


## Key Keybindings

This fork includes extensive custom keybindings for enhanced productivity:

### AI Assistants
- `<leader>cc` - Open Copilot Chat
- `<leader>lc` - Toggle Claude Code panel

### Navigation & Files  
- `<M-1>` - Toggle file tree (NvimTree)
- `<M-2>` - Focus file tree
- `<M-3>` - Toggle code outline (Aerial) 
- `<M-4>` - Focus code outline
- `<leader>sf` - Find files (Telescope)
- `<leader>sg` - Live grep (Telescope)
- `<leader>fa` - Find in all files (CtrlSF)

### Terminal Integration
- `<leader>tt` - Horizontal terminal
- `<leader>tf` - Floating terminal
- `<leader>tv` - Vertical terminal

### Window Management
- `<C-Up/Down/Left/Right>` - Resize windows
- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally

### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

> [!TIP]
> Press `<leader>` (space by default) in normal mode to see available keybindings with which-key.

### FAQ

* What should I do if I already have a pre-existing Neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* **Can I keep my existing configuration in parallel to this fork?**
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install this fork in
    `~/.config/nvim-kickstart-ai` and create an alias:
    ```bash
    alias nvim-ai='NVIM_APPNAME="nvim-kickstart-ai" nvim'
    ```

* **How do I enable AI features?**
  * **Claude Code**: Set `export PROJECT_CONTEXT=personal` in your shell profile
  * **GitHub Copilot**: Set `export NVIM_COPILOT=true` and run `:Copilot auth` in Neovim
  * **Avante**: Set `export NVIM_AVANTE=true` and configure API keys for desired providers

* **Why are AI features environment-gated?**
  * This allows selective activation of AI assistants based on project context or personal preference
  * Prevents accidental activation in restricted environments or when API costs are a concern
  * Keeps the configuration flexible for different use cases

* **What if I want to "uninstall" this configuration?**
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information

* **Why is the `init.lua` still a single file despite all the additions?**
  * Maintains the educational philosophy of kickstart.nvim - everything visible in one place
  * Custom plugins are modularized in `lua/custom/plugins/` for organization
  * Advanced users can further modularize as needed

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Clone This Fork](#Clone-This-Fork) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>

