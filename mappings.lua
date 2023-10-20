-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- All FZF commands
    ["<c-P>"] = { "<cmd>lua require('fzf-lua').files()<cr>", desc = "Fuzzyfind Files" },
    ["<c-B>"] = { "<cmd>lua require('fzf-lua').buffers()<cr>", desc = "Fuzzyfind Buffers" },
    ["<c-R>"] = { "<cmd>lua require('fzf-lua').oldfiles()<cr>", desc = "Fuzzyfind Oldfiles" },
    -- ["<leader>zg"] = { "<cmd>lua require('fzf-lua').grep()<cr>", desc = "Fuzzyfind Grep" },
    -- ["<leader>zG"] = { "<cmd>lua require('fzf-lua').live_grep()<cr>", desc = "Fuzzyfind Live Grep" },
    ["<leader>zg"] = { "<cmd>lua require('fzf-lua').grep_visual()<cr>", desc = "Fuzzyfind Grep Visual" },
    ["<leader>zf"] = { "<cmd>lua require('fzf-lua').grep_curbuf()<cr>", desc = "Fuzzyfind Grep Current Buffer" },
    -- ["<c-T>"] = { "<cmd>lua require('fzf-lua').grep_cWORD()<cr>", desc = "Fuzzyfind Grep CWORD" },
    -- ["<leader>zq"] = { "<cmd>lua require('fzf-lua').quickfix()<cr>", desc = "Fuzzyfind Quickfix" },
    -- ["<c-N>"] = { "<cmd>lua require('fzf-lua').loclist()<cr>", desc = "Fuzzyfind Loclist" },
    -- ["<c-Z>"] = { "<cmd>lua require('fzf-lua').blines()<cr>", desc = "Fuzzyfind BLines" },
    -- ["<c-X>"] = { "<cmd>lua require('fzf-lua').tags()<cr>", desc = "Fuzzyfind Tags" },
    -- ["<c-Y>"] = { "<cmd>lua require('fzf-lua').colorschemes()<cr>", desc = "Fuzzyfind Colorschemes" },

    -- autofix all problems
    ["<leader>fe"] = {
      function()
        vim.lsp.buf.code_action {
          filter = function(a) return a.isPreferred end,
          apply = true,
        }
      end,
      desc = "Fix all eslint errors",
      silent = true,
      noremap = true,
    },

    --map <C-a> ggVG
    ["<C-a>"] = { "ggVG", desc = "Select all" },

    -- tests
    ["<leader>tt"] = { function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run File" },
    ["<leader>tT"] = { function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
    ["<leader>tr"] = { function() require("neotest").run.run() end, desc = "Run Nearest" },
    ["<leader>ts"] = { function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    ["<leader>to"] = {
      function() require("neotest").output.open { enter = true, auto_close = true } end,
      desc = "Show Output",
    },
    ["<leader>tO"] = { function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    ["<leader>tS"] = { function() require("neotest").run.stop() end, desc = "Stop" },
    ["<leader>tw"] = {
      function()
        -- require("neotest").watch.toggle()
        require("neotest").watch.watch(vim.fn.expand "%")
      end,
      desc = "Watch Nearest Test",
    },

    -- org imports
    ["<leader>oi"] = {
      function()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        vim.lsp.buf.execute_command(params)
      end,
      desc = "Import org file",
      silent = true,
      noremap = true,
    },

    -- hop
    ["f"] = {
      function() require("hop").hint_words {} end,
      desc = "Hop to next character",
    },
    ["F"] = {
      function() require("hop").hint_char2() end,
      desc = "Hop to next character",
    },
    ["X"] = {
      function() require("hop").hint_patterns {} end,
      desc = "Hop to next character",
    },

    -- redo
    ["U"] = { "<c-r>", desc = "Redo" },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
