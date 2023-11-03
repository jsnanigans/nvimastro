-- TODO: Add more plugins
return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- {
  --   "folke/todo-comments.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function() require("todo-comments").setup {} end,
  --   event = "User Astrofile",
  --   cmd = { "TodoQuickFix" },
  --   keys = {
  --     { "<leader>T", "<cmd>TodoTelescope<cr>", desc = "Open TODOs with Telescope" },
  --   },
  -- },
  { "junegunn/fzf", build = "./install --bin", lazy = false },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup {}
    end,
  },
  -- { "nvim-lua/plenary.nvim" },
  { "haydenmeade/neotest-jest" },
  { "nvim-treesitter/nvim-treesitter" },
  { "antoinemadec/FixCursorHold.nvim" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    requires = {
      "haydenmeade/neotest-jest",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-jest" {
            jestCommand = "npm test --",
            -- jestConfigFile = "custom.jest.config.ts",
            -- env = { CI = true },
            -- cwd = function(path) return vim.fn.getcwd() end,
            cwd = function()
              -- only run tests in the 'src' directory
              return vim.fn.getcwd() .. "/src"
            end,
          },
        },
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        -- floats = "transparent",
      },
    },
    config = function(_, opts)
      local tokyonight = require "tokyonight"
      tokyonight.setup(opts)
      tokyonight.load()
    end,
  },
  -- {
  --   "ggandor/lightspeed.nvim",
  --   lazy = false,
  -- },
  {
    "smoka7/hop.nvim",
    version = "v2",
    config = function() require("hop").setup {} end,
    lazy = false,
  },

  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        "/Users/bdan/Projects/web-2",
        "/Users/bdan/Projects/template-9am/app",
        "/Users/bdan/Projects/patientmanagement/app",
        "/Users/bdan/rad/honestweb-works/*",
      },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append "globals" -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        -- panel = {
        --   enabled = true,
        --   auto_refresh = false,
        --   keymap = {
        --     jump_prev = "[[",
        --     jump_next = "]]",
        --     accept = "<CR>",
        --     refresh = "gr",
        --     open = "<leader-tgo>",
        --   },
        --   layout = {
        --     position = "bottom", -- | top | left | right
        --     ratio = 0.4,
        --   },
        -- },
        suggestion = {
          auto_trigger = true,
          enabled = true,
          debounce = 75,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "C-h>",
          },
          --
        },
        filetypes = {
          ["*"] = true,
          sh = function()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
              -- disable for .env files
              return false
            end
            return true
          end,
        },
      }
    end,
  },
}
