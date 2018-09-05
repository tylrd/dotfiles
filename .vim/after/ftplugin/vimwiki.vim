setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

setlocal textwidth=80
setlocal colorcolumn=80

setlocal wrap

autocmd VimEnter * Limelight

if exists('+colorcolumn')
  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
  let &l:colorcolumn='+' . join(range(0, 254), ',+')
endif

" Restore original mappings:
nmap <silent><buffer> = <nop>
nmap <silent><buffer> - <Plug>VinegarUp
