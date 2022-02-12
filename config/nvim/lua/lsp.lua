local lsp = require('lspconfig')

local servers = {'cssls', 'html', 'dockerls', 'eslint', 'jsonls', 'sqls', 'tsserver', 'yamlls'}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Rust
lsp.rust_analyzer.setup {
  capabilities = capabilities,
  tools = {
    autoSetHints = true, -- automatically set inlay hints
    hover_with_actions = true, -- show hover actions in the hover window
    runnables = {
      use_telescope = true -- use telescope.nvim
    },
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = " « ",
      -- other_hints_prefix = " » ",
      other_hints_prefix = ">=> ",
      max_len_align_padding = false, -- don't align to longest line in file
      right_align = false -- don't align to the extreme right
    },
    hover_actions = {
      -- see vim.api.nvim_open_win()
      border = {
        {"╭", "FloatBorder"}, {"─", "FloatBorder"}, {"╮", "FloatBorder"}, {"│", "FloatBorder"},
        {"╯", "FloatBorder"}, {"─", "FloatBorder"}, {"╰", "FloatBorder"}, {"│", "FloatBorder"}
      }
    }
  },
  server = {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {command = "clippy"}
      }
    }
  } -- options for rust-analyzer
}

for _, server in pairs(servers) do lsp[server].setup {on_attach = on_attach, capabilities = capabilities} end

