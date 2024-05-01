set modeline
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
call plug#begin()
Plug 'navarasu/onedark.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'creativenull/efmls-configs-nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

let g:onedark_config = {
    \ 'style': 'warm',
\}
if !empty($TF_TERM_DISCOVERY)
	if $TF_TERM_DISCOVERY ==# 'gnome-terminal'
		colorscheme onedark
	elseif $TERM ==# 'cool-retro-term'
		" Nothing, stock color scheme is better here.
	endif
else
	" Fall back to $TERM based discovery
	if $TERM ==# 'xterm-256color'   " Probably gnome-terminal
		colorscheme onedark
	elseif $TERM ==# 'xterm'        " Probably cool-retro-term, or something basic
		" Do nothing for now
	endif
endif


map <C-B> <Cmd>NvimTreeToggle<CR>
