-- init.lua (clean ver.)
local util = require("util")

-- 1) lazy.nvim を用意
util.lazy_bootstrap()

-- 2) プラグイン定義
util.lazy_setup({
  { "nvim-lua/plenary.nvim" },
  { "preservim/tagbar" },
  
  -- ショートカットヒント
  --{ "folke/which-key.nvim", event = "VeryLazy", version = false},
  --{ "echasnovski/mini.icons", version = false },
  
  -- Telescope（ビルド不要構成）
  { "nvim-telescope/telescope.nvim", version = false, dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },
  -- 任意：fzfネイティブ
  -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- ctags 自動
  { "ludovicchabant/vim-gutentags" },

  -- UI
  { "nvim-tree/nvim-web-devicons" },
  { "akinsho/bufferline.nvim", version = "*", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- Terminal
  { "akinsho/toggleterm.nvim", version = "*" },

  -- Markdown live preview
  {
    "brianhuster/live-preview.nvim",
    ft = { "markdown", "html", "asciidoc", "svg" },
  },

  -- Colors
  { "jacoborus/tender.vim",        lazy = true  },
  { "sainnhe/everforest",          lazy = true  },
  { "sainnhe/gruvbox-material",    lazy = false }, -- ← util.setup_colors() で即適用するので eager
})

-- 3) 追加キーマップ（Tagbar / ctags）
vim.keymap.set("n","<F8>", ":TagbarToggle<CR>", { silent = true, desc = "Tagbar Toggle" })
vim.keymap.set("n","gD",  ":tselect <C-r><C-w><CR>", { silent = true, desc = "Tag select (ctags)" })

-- 4) Markdown style（そのまま）
local root = os.getenv("GHQ_ROOT")
local screen_css = root .. "/github.com/jasonm23/markdown-css-themes/screen.css"
local aaa_css    = root .. "/github.com/pxlrbt/markdown-css/markdown.css"
vim.g.mkdp_markdown_css = "C:/Users/kz/vault/dev/src/github.com/jasonm23/markdown-css-themes/screen.css"
-- vim.g.mkdp_markdown_css = screen_css

-- 5) プラグイン初期化が一段落したタイミングで “一発ロード”
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    util.setup_all()
  end,
})
