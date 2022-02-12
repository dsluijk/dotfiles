-- Make sure packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd('packadd packer.nvim')
else
  vim.cmd('packadd packer.nvim') -- Load package
  vim.cmd('autocmd BufWritePost plugins.lua PackerCompile') -- Auto compile plugins
end

-- Packer
require('plugins')

-- Generic vim settings
require('settings')

-- Language Server Settings
require('lsp')
require('lsp_signature').setup()

-- Treesitter
local ts = require('nvim-treesitter.configs')
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-- Autocompletion
require('completion')
require('luasnip/loaders/from_vscode').lazy_load()

-- Colorscheme
vim.cmd('colorscheme gruvbox')

-- Icons
require('nvim-web-devicons').setup {
    default = true
}

-- Autocmds
vim.cmd('filetype plugin indent on')

-- enable dicts for textfiles
vim.cmd([[autocmd BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_gb]])

-- auto remove trailing whitespace
vim.cmd([[autocmd BufWritePre * :%s/\s\+$//e]])

-- Remap
local remap = vim.api.nvim_set_keymap
vim.g.mapleader = " "
remap('n', '<C-f>', ':FZF<CR>', {}) -- ctrl+f for fzf
remap('n', '<Space>', ':noh<Bar>echo<CR>', {silent = true}) -- Space clears highlights and messages
remap('n', '<C-_>', '<Plug>kommentary_line_default', {}) -- (un)comment with ctrl+/
remap('n', '<Up>', '<Nop>', {})
remap('n', '<Down>', '<Nop>', {})
remap('n', '<Left>', '<Nop>', {})
remap('n', '<Right>', '<Nop>', {})

-- Tab comment out
vim.cmd([[
  nnoremap <tab> >>_          " increase indent with >>
  nnoremap <s-tab> <<_        " decrease indent with <<
  inoremap <s-tab> <c-d>
  vnoremap <Tab> >gv          " tab to increase indent
  vnoremap <S-Tab> <gv        " shift tab to decrease indent
]])

-- Telescope
remap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', {})
remap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', {})
remap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
remap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', {})

-- Nerdtree
vim.cmd([[autocmd StdinReadPre * let s:std_in=1]])
vim.cmd([[autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif]])
vim.cmd([[autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]])
vim.cmd([[autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif]])


remap('n', '<leader>n', '<cmd>NERDTree<cr>', {})
remap('n', '<leader>t', '<cmd>NERDTreeToggle<cr>', {})

-- Barbar
remap('n', '<A-,>', ':BufferPrevious<CR>', {})
remap('n', '<A-.>', ':BufferNext<CR>', {})
remap('n', '<A-<>', ':BufferMovePrevious<CR>', {})
remap('n', '<A->>', ':BufferMoveNext<CR>', {})
remap('n', '<A-1>', ':BufferGoto 1<CR>', {})
remap('n', '<A-2>', ':BufferGoto 2<CR>', {})
remap('n', '<A-3>', ':BufferGoto 3<CR>', {})
remap('n', '<A-4>', ':BufferGoto 4<CR>', {})
remap('n', '<A-5>', ':BufferGoto 5<CR>', {})
remap('n', '<A-6>', ':BufferGoto 6<CR>', {})
remap('n', '<A-7>', ':BufferGoto 7<CR>', {})
remap('n', '<A-8>', ':BufferGoto 8<CR>', {})
remap('n', '<A-9>', ':BufferGoto 9<CR>', {})
remap('n', '<A-0>', ':BufferLast<CR>', {})
remap('n', '<A-c>', ':BufferClose<CR>', {})
