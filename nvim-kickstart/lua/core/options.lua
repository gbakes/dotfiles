vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true
opt.autoindent = true
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true

-- faster scrolling
opt.lazyredraw = false
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use clipboard default register

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.hlsearch = false -- Set highlight on search

opt.breakindent = true -- Enable break indent
opt.undofile = true -- Save undo history

opt.updatetime = 250 -- Decrease update time
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.backup = false -- creates a backup file
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
opt.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed to travel to prev/next line
opt.linebreak = true -- companion to wrap don't split words
opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`
opt.swapfile = false -- creates a swapfile
opt.smartindent = true -- make indenting smarter again
opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
opt.iskeyword:append("-") -- hyphenated words recognized by searches
opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
