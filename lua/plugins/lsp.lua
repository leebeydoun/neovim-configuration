local _on_attach = function(_, _)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.renamed, {})
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
  vim.keymap.set("n", "gi", require("telescope.builtin").lsp_references, {})
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
end

return {
  {
    "williamboman/mason.nvim",
    config = function()
      local c = require("mason")

      c.setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local configs = require("mason-lspconfig")
      configs.setup({
        ensure_installed = { "lua_ls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lsp.lua_ls.setup({
        on_attach = _on_attach,
        capabilities = capabilities,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      local util = require("formatter.util")

      require("formatter").setup({
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
              -- Supports conditional formatting
              if util.get_current_buffer_file_name() == "special.lua" then
                return nil
              end

              -- Full specification of configurations is down below and in Vim help
              -- files
              return {
                exe = "stylua",
                args = {
                  "--search-parent-directories",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--",
                  "-",
                },
                stdin = true,
              }
            end,
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })
    end,
  },
}
