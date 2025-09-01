require("shared.core")
require("shared.lazy").bootstrap()

require("shared.lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "preservim/tagbar" },

  -- Telescope（WSLは fzf-native を有効化）
  { "nvim-telescope/telescope.nvim", version = false, dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("shared.telescope").setup({
        pickers = { lsp_workspace_symbols = { fname_width = 60, symbol_width = 60 } }
      })
    end },
  
  -- === Git: WSL 限定で軽量導入 ===
  {
    "tpope/vim-fugitive",
    cond = is_wsl, -- WSL のときだけ読み込む
  },
  {
    "lewis6991/gitsigns.nvim",
    cond = is_wsl,
    opts = {
      -- 既定値で十分に軽い＆実用的
      -- ここに必要があれば minimal オプションを追加
    },
  },
  { "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- Treesitter（WSLのみ）
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c","cpp","lua","vim","vimdoc","query",
                             "markdown","markdown_inline","bash","json","yaml" },
        highlight = { enable = true },
      })
    end },

  -- LSP/CMP（WSLのみ）
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp","hrsh7th/cmp-buffer","hrsh7th/cmp-path" } },
  { "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")
      lsp.clangd.setup {
        cmd = { "clangd","--background-index","--clang-tidy","--header-insertion=never",
                "--completion-style=detailed","--query-driver=/usr/bin/arm-none-eabi-*,/opt/gcc-arm*/bin/arm-none-eabi-*" },
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function() end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = { { name = "nvim_lsp" }, { name = "path" }, { name = "buffer" } },
      })
      local on_attach = function(_, bufnr)
        local map = function(m, lhs, rhs, d) vim.keymap.set(m, lhs, rhs, { buffer = bufnr, desc = d }) end
        map("n","gd", vim.lsp.buf.definition, "Goto definition")
        map("n","gr", vim.lsp.buf.references, "References")
        map("n","gI", vim.lsp.buf.implementation, "Implementation")
        map("n","K",  vim.lsp.buf.hover, "Hover")
        map("n","<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n","<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n","[d", vim.diagnostic.goto_prev, "Diag prev")
        map("n","]d", vim.diagnostic.goto_next, "Diag next")
      end
      local orig = lsp.util.default_config.on_attach
      lsp.util.default_config.on_attach = function(client, bufnr)
        if orig then orig(client, bufnr) end
        on_attach(client, bufnr)
      end
      vim.diagnostic.config({ virtual_text=false, signs=true, underline=true, severity_sort=true, update_in_insert=false })
      vim.keymap.set("n","gl", vim.diagnostic.open_float, { desc="Line diagnostics" })
    end },

  -- ctags 自動（WSLでも便利）
  { "ludovicchabant/vim-gutentags", init = function() require("shared.gutentags").init() end },

  -- UI
  { "nvim-tree/nvim-web-devicons" },
  { "akinsho/bufferline.nvim", version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("shared.ui").setup_bufferline() end },
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("shared.ui").setup_lualine(true) end },

  -- Colors
  { "jacoborus/tender.vim", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "sainnhe/gruvbox-material", lazy = false,
    config = function() require("shared.colors") end },
})

-- Tagbar / ctags などの共通マップ
vim.keymap.set("n","<F8>", ":TagbarToggle<CR>", { silent = true, desc="Tagbar Toggle" })
vim.keymap.set("n","gD", ":tselect <C-r><C-w><CR>", { silent = true, desc="Tag select (ctags)" })

-- Telescope x LSP 追加（WSLのみ）
local tb = require("telescope.builtin")
vim.keymap.set('n','<leader>sn', function() tb.lsp_workspace_symbols({ query='@namespace' }) end, { desc = 'Symbols: Namespace' })
vim.keymap.set('n','<leader>sc', function() tb.lsp_workspace_symbols({ query='@class' })     end, { desc = 'Symbols: Class' })
vim.keymap.set('n','<leader>sf', function() tb.lsp_workspace_symbols({ query='@function' })  end, { desc = 'Symbols: Function' })
vim.keymap.set('n','<leader>ss', tb.lsp_workspace_symbols, { desc = 'Symbols: Any' })
vim.keymap.set('n','<leader>sd', tb.lsp_document_symbols,  { desc = 'Symbols: Document' })

-- fugitive: よく使う基本操作
vim.keymap.set("n", "<leader>gs", ":Git<CR>",                      { desc = "Git status (fugitive)" })
vim.keymap.set("n", "<leader>ga", ":Git add %<CR>",                { desc = "Git add current file" })
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>",               { desc = "Git commit" })
vim.keymap.set("n", "<leader>gp", ":Git push<CR>",                 { desc = "Git push" })
vim.keymap.set("n", "<leader>gx", ":Git switch ",                  { desc = "Git switch branch" })
vim.keymap.set("n", "<leader>gl", ":Git log --oneline --graph<CR>",{ desc = "Git log oneline" })

-- diff: 現在バッファ vs HEAD を素早く確認
vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>",               { desc = "Git diff split (HEAD vs %)" })

-- gitsigns: ハンク単位の操作（軽量＆直感的）
local gs_ok, gs = pcall(require, "gitsigns")
if gs_ok then
  vim.keymap.set("n", "]h", gs.next_hunk,                          { desc = "Next hunk" })
  vim.keymap.set("n", "[h", gs.prev_hunk,                          { desc = "Prev hunk" })
  vim.keymap.set("n", "<leader>hs", gs.stage_hunk,                 { desc = "Stage hunk" })
  vim.keymap.set("n", "<leader>hr", gs.reset_hunk,                 { desc = "Reset hunk" })
  vim.keymap.set("n", "<leader>hp", gs.preview_hunk,               { desc = "Preview hunk" })
  vim.keymap.set("n", "<leader>hb", function() gs.blame_line({full=true}) end, { desc = "Blame line (full)" })
end

-- （任意）Telescope を併用して履歴/ブランチを軽快に
local ok_tel, builtin = pcall(require, "telescope.builtin")
if ok_tel then
  vim.keymap.set("n", "<leader>gS", builtin.git_status,            { desc = "Telescope: git status" })
  vim.keymap.set("n", "<leader>gB", builtin.git_branches,          { desc = "Telescope: git branches" })
  vim.keymap.set("n", "<leader>gC", builtin.git_commits,           { desc = "Telescope: git commits" })
  vim.keymap.set("n", "<leader>gF", builtin.git_bcommits,          { desc = "Telescope: buffer commits" })
end
 