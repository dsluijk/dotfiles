-- Global
local g = vim.g
g.rustfmt_autosave = 1
g['prettier#autoformat'] = 1
g['prettier#autoformat_require_pragma'] = 0
g.bufferline = {
    auto_hide = true
}
g.NERDTreeGitStatusUseNerdFonts = 1
g.NERDTreeShowHidden = 1

-- Options
local o = vim.o
o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.compatible = false
o.showmatch = true
o.smartcase = true
o.undodir = vim.env.HOME .. '/.vim/undo'
o.directory = vim.env.HOME .. '/.vim/tmp'
o.backupdir = vim.env.HOME .. '/.vim/backup'
o.undofile = true
o.laststatus = 2
o.confirm = true

o.mouse = 'a'
o.termguicolors = true
o.clipboard = "unnamedplus"

-- window local
local wo = vim.wo
wo.number = true
wo.wrap = false
wo.list = true
wo.listchars = 'tab:>-,trail:·'
wo.signcolumn = 'yes'

-- buffer-local
local bo = vim.bo
bo.autoindent = true
bo.expandtab = true
bo.fileencoding = 'UTF-8'
bo.formatoptions = 'tcq'
bo.shiftwidth = 4
bo.smartindent = true
bo.softtabstop = 4
bo.syntax = 'on'
bo.tabstop = 4

-- Override saving commands
vim.cmd([[
  cnoreabbrev W w
  cnoreabbrev X x
  cnoreabbrev Q q
]])

