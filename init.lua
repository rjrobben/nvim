vim.cmd [[
runtime! lua/modules/options.lua
runtime! plug-config/diagnostics.lua
runtime! plug-config/auto-cmp.lua
]]
vim.cmd [[
let g:UltiSnipsExpandTrigger="<space>"
let g:UltiSnipsJumpForwardTrigger="<space>"
let g:UltiSnipsJumpBackwardTrigger="<s-space>"
]]

vim.cmd [[
filetype plugin on
]]

require "paq" {
	"savq/paq-nvim";


	--lsp snippets	
	
	"SirVer/ultisnips";
	-- lsp 
	"neovim/nvim-lspconfig";
	"hrsh7th/nvim-cmp";
	"hrsh7th/cmp-nvim-lsp";
	"hrsh7th/cmp-cmdline";
	"hrsh7th/cmp-path";
	"hrsh7th/cmp-buffer";
	"hrsh7th/cmp-nvim-lsp-signature-help";
	"nvim-telescope/telescope.nvim";
	"nvim-lua/plenary.nvim";
	"williamboman/mason.nvim";
	"quangnguyen30192/cmp-nvim-ultisnips";
	
	-- find
	"junegunn/fzf";
	"junegunn/fzf.vim";

	-- appearance
	"vim-airline/vim-airline";
	"vim-airline/vim-airline-themes";

	-- latex and markdown 
	"lervag/vimtex";
	"iamcco/markdown-preview.nvim"
}

-- spell check setting

vim.cmd[[
set spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
]]

vim.api.nvim_command([[autocmd BufWinEnter *.tex :setlocal spell]])

vim.keymap.set("n", "<Leader>S", function()
	vim.o.spell = not vim.o.spell
	print("spell: " .. tostring(vim.o.spell))
end)

-- shortct

vim.cmd[[
map <C-g> :FZF<CR>
map <C-f> :BLines<CR>
map <leader>g :Rg<CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
noremap <A-h> :bp<CR>
noremap <A-l> :bn<CR>
]]

-- lspconfig 

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	-- symbols
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
	-- declaratino and definition
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	--hover
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	--implementation
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	--signature help
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>h', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	--code action
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	--reference 
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'R', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	--formatting
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { 'pyright', 'sumneko_lua', 'clangd', 
				'bashls', 'quick_lint_js', 'texlab',
				'vimls'
			  	  }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- require'lspconfig'.pyright.setup{}

-- mason
require("mason").setup()

--appearnce

-- pop up menu

vim.cmd[[
    highlight Pmenu ctermbg=white guibg=white
    highlight PmenuSel ctermbg=gray guibg=gray
    highlight PmenuSbar ctermbg=white guibg=white
    highlight PmenuThumb ctermbg=black guibg=black
]]
-- airline
vim.g['airline_theme'] = 'base16'
vim.g['airline_section_b'] = ''
vim.g['airline_section_warning'] = ''

vim.cmd [[
let g:airline_section_y = airline#section#create(['%{strftime("%D")}'])
let g:airline_section_z = airline#section#create(['%{strftime("%H:%M")}'])
]]

-- vimtex

vim.cmd [[
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
" let g:vimtex_view_general_viewer = '/usr/bin/zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
]]
--[[
-- md-img-paste

vim.cmd [[
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'image'
]]
--]]

-- create user command
local cmd = vim.api.nvim_create_user_command

cmd("CD", "cd %:p:h", {})
