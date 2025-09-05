require("shared.core")
require("shared.lazy").bootstrap()

require("shared.lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "preservim/tagbar" },

  -- Telescope（ビルド不要構成）
  { "nvim-telescope/telescope.nvim", version = false, dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("shared.telescope").setup() end },
  { "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },

  -- ctags 自動
  { "ludovicchabant/vim-gutentags",
    init = function() require("shared.gutentags").init() end },

  -- UI
  { "nvim-tree/nvim-web-devicons" },
  { "akinsho/bufferline.nvim", version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("shared.ui").setup_bufferline() end },
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("shared.ui").setup_lualine(false) end },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        shell = "pwsh.exe",   -- "powershell.exe" でもOK
        --shell = "pwsh.exe -NoLogo -NoExit -Command Invoke-Expression ($PROFILE)",
        direction = "float",  -- フローティングで開く
      })
      -- 一時利用用のトグル
      vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
    end,
  },

  -- Markdown
  {
    "brianhuster/live-preview.nvim",
    ft = { "markdown", "html", "asciidoc", "svg" },
    opts = {
      browser_cmd = "msedge --new-tab",  -- 普段の Edge をそのまま利用
      port = 8080,                       -- お好みで固定。競合するなら変えてOK
    },
    keys = {
      {
        "<leader>ms",
        "<cmd>LivePreview start<CR>",
        desc = "Markdown Live Preview",
      },
      {
        "<leader>mc",
        "<cmd>LivePreview close<CR>",
        desc = "HTML Live Preview",
      },
    },
  },
  
  -- Colors
  { "jacoborus/tender.vim", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "sainnhe/gruvbox-material", lazy = false,
    config = function() require("shared.colors") end },
})

-- Tagbar / ctags キーマップ
vim.keymap.set("n","<F8>", ":TagbarToggle<CR>", { silent = true, desc="Tagbar Toggle" })
vim.keymap.set("n","gD", ":tselect <C-r><C-w><CR>", { silent = true, desc="Tag select (ctags)" })

-- Markdown style
local root = os.getenv("GHQ_ROOT")
local screen_css = root .. "/github.com/jasonm23/markdown-css-themes/screen.css"
local aaa_css    = root .. "/github.com/pxlrbt/markdown-css/markdown.css"
vim.g.mkdp_markdown_css = "C:/Users/kz/vault/dev/src/github.com/jasonm23/markdown-css-themes/screen.css"

--vim.g.mkdp_markdown_css = screen_css
