-- Bootstrap lazy.nvim into a separate data dir to avoid colliding with main nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy-lite/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
  { import = "plugins" },
}, {
  root = vim.fn.stdpath("data") .. "/lazy-lite",
  lockfile = vim.fn.stdpath("data") .. "/lazy-lite/lazy-lock.json",
})
