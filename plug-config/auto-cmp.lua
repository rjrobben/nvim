--[[
vim.cmd [[
let g:UltiSnipsExpandTrigger='<C-e>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
]]
--]]

local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
	  completion = cmp.config.window.bordered(),
	  documentation = cmp.config.window.bordered(),
	},
--[[
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) --Concatonate the icons with name of the item-kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        spell = "[Spellings]",
        zsh = "[Zsh]",
        buffer = "[Buffer]",
        ultisnips = "[Snip]",
        treesitter = "[Treesitter]",
        calc = "[Calculator]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        nvim_lsp_signature_help = "[Signature]",
        cmdline = "[Vim Command]"
      })[entry.source.name]
      return vim_item
    end,
  },
--]]
  mapping = {
    ['<tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<s-tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-M-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-5), { 'i', 'c' }),
    ['<C-M-j>'] = cmp.mapping(cmp.mapping.scroll_docs(5), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  completion = {
	keyword_length = 1,
  },
  matching = {
    disallow_fuzzy_matching = false,
  },
  sources = cmp.config.sources(
  {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
  }, {
    { name = 'buffer' },
  }, {
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'path' },
  }
  )
})

-- autocompletion for cmd
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' },
  })
})

-- autocompletion for search 

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  }
})


