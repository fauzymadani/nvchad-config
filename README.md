### Nvchad config
this is my personal config for neovim with Nvchad

## Requirements
- nerd font
- ripgrep
- some basic knowledge of lua
- Neovim 0.10

## Installation
make a backup of your neovim config.
```bash
mv ~/.config/nvim ~/.config/nvim_backup
```

clone this repo
```bash
git clone https://github.com/fauzymadani/nvchad-config.git ~/.config/nvim
```

## preview
![nvchad](https://github.com/user-attachments/assets/7ad45deb-96ca-455c-b89b-80600e639477)

## Features
- Support laravel development
- laravel lsp
- blade syntax highlighting
- equipped with Nvchad menu, <a href="https://github.com/NvChad/menu">see here</a>
- color picker
- auto formatting / format on save
- clangd lsp for C development

## Post-install guide
`cd ~/.config/nvim`, run `nvim` after cloning. inside neovim, run this in the command mode (remove ':')
```bash
:TSInstall php blade html
```
for Lsp:
```bash
:MasonInstallAll
```
and `Mason` and press Ctrl-f for install the specific lsp, the required lsp is `stimulus-language-server`, `cssls`, `tailwind-ls`.

### Optional
a formatter for C language, `clangd`(lsp for C).prettier for a better formatting. `ast-grep` for global multi-language support lsp.
