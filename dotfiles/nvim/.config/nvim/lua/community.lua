-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.scrolling.mini-animate" },
  { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
  { import = "astrocommunity.split-and-window.windows-nvim" },
  { import = "astrocommunity.icon.mini-icons" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.split-and-window.mini-map" },
  { import = "astrocommunity.editing-support.multicursors-nvim" },
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.utility.hover-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.editing-support.comment-box-nvim" },
}
