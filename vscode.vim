" remap jk to escape
":imap jk <Esc>
" Copy paste to 'clipboard registry'
set clipboard=unnamedplus
nmap <C-c> "+yy
vmap <C-c> "+y

" add line numbers
"set number
"set relativenumber


" replace when pasting from yank in visual mode (to use with whichkey)
vnoremap "_0p _c<c-r>0<esc>


" highlight yank text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
augroup END


" fold unfold in vscode
if(exists("g:vscode"))
    nnoremap zM :call VSCodeNotify('editor.foldAll')<CR>
    nnoremap zR :call VSCodeNotify('editor.unfoldAll')<CR>
    nnoremap zc :call VSCodeNotify('editor.fold')<CR>
    nnoremap zC :call VSCodeNotify('editor.foldRecursively')<CR>
    nnoremap zo :call VSCodeNotify('editor.unfold')<CR>
    nnoremap zO :call VSCodeNotify('editor.unfoldRecursively')<CR>
    nnoremap za :call VSCodeNotify('editor.toggleFold')<CR>
    
    function! MoveCursor(direction) abort
        if(reg_recording() == '' && reg_executing() == '')
            return 'g'.a:direction
        else
            return a:direction
        endif
    endfunction

    nmap <expr> j MoveCursor('j')
    nmap <expr> k MoveCursor('k')
endif

if(exists("g:vscode"))
" go to definition in vscode
    nnoremap gd :call VSCodeNotify('editor.action.revealDefinition')<CR>
" see references 
    nnoremap gr :call VSCodeNotify('editor.action.goToReferences')<CR>
" fix o issue
" nnoremap <silent> o <Cmd>call VSCodeNotify('editor.action.insertLineAfter')<CR>i
" nnoremap <silent> O <Cmd>call VSCodeNotify('editor.action.insertLineBefore')<CR>i
endif

" plugins
call plug#begin()
"Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-surround'
call plug#end()

" vim-surround keybinding for vim-sandwich
"runtime macros/sandwich/keymap/surround.vim
