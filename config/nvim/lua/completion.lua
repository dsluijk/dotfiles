-- Setup nvim-cmp.
local cmp = require 'cmp'
local types = require('cmp.types')
local luasnip = require('luasnip')

cmp.setup {
  completion = {
    keyword_length = 1,
    get_trigger_characters = function(trigger_characters) return trigger_characters end
  },

  snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},

  mapping = {
    ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true}),
    ['<s-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<Esc>'] = cmp.mapping.close(),
  },

  formatting = {
    deprecated = true,
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
        path = "[Path]"
      })[entry.source.name]
      return vim_item
    end
  },

  experimental = {ghost_text = true},

  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'spell' }
  })
}

