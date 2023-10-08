local on_attach = function(_,_)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.renamed, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
  
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

return {
  {
    "williamboman/mason.nvim",
    config = function()
      local c = require("mason")

      c.setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local configs = require("mason-lspconfig")
      configs.setup({
        ensure_installed = { "lua_ls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lsp.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  }
}
