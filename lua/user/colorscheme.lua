vim.cmd [[
try
  " colorscheme darkplus

  " let g:dracula_colorterm = 0
  " colorscheme dracula
  colorscheme monokai_pro
  " fix windows terminal pb with italic
  hi Identifier gui=NONE
  hi Type gui=None
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
