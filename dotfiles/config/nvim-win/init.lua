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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()  -- Node.jsでバックエンドをインストール
    end,
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

-- Markdown
vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreview<CR>", { desc = "Markdown Preview Start" })
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>mx", "<cmd>MarkdownPreviewStop<CR>", { desc = "Markdown Preview Stop" })
vim.keymap.set("n", "<leader>mt", "<cmd>MkdpToggleTheme<CR>",       { desc = "Preview: Theme Toggle" })
vim.g.mkdp_theme = "light"
vim.g.mkdp_browser = "msedge"        -- ブラウザ指定（chrome, edge など）
vim.g.mkdp_open_ip = "127.0.0.1"
vim.g.mkdp_echo_preview_url = 1      -- URLをエコー出力 (コピーして他環境で開ける)

-- >>> パスは自分の環境に合わせて変更 <<<
local root = os.getenv("GHQ_ROOT")
local screen_css= root .. "/github.com/jasonm23/markdown-css-themes/screen.css"
local aaa_css   = root .. "/github.com/pxlrbt/markdown-css/markdown.css"

-- デフォルトはライトにしておく（共有時に見やすい）
vim.g.mkdp_markdown_css = aaa_css
vim.g.mkdp_auto_start = 1            -- 起動時に自動プレビューしない
vim.g.mkdp_auto_close = 1            -- バッファ閉じたらプレビュー終了
vim.g.mkdp_refresh_slow = 0          -- リアルタイム更新
vim.g.mkdp_command_for_global = 0    -- markdownファイルのみ有効
vim.g.mkdp_open_to_the_world = 0     -- 外部からアクセス禁止 (セキュア)

-- <C-\> で開閉（デフォルト）
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Open Terminal" })
