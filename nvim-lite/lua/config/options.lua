vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.cmdheight = 1
opt.completeopt = "menuone,noinsert,noselect"
opt.showmode = false
opt.pumheight = 10
opt.conceallevel = 0
opt.lazyredraw = false
opt.fillchars = { eob = " " }

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir

opt.updatetime = 250
opt.timeoutlen = 300
opt.hidden = true
opt.backspace = "indent,eol,start"
opt.iskeyword:append("-")
opt.clipboard:append("unnamedplus")
opt.mouse = "a"
opt.encoding = "utf-8"
opt.selection = "inclusive"

opt.splitbelow = true
opt.splitright = true
opt.breakindent = true
opt.linebreak = true
opt.shortmess:append("c")
opt.whichwrap = "bs<>[]hl"
opt.formatoptions:remove({ "c", "r", "o" })
opt.runtimepath:remove("/usr/share/vim/vimfiles")

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.diffopt:append("linematch:60")
