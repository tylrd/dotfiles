setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

setlocal textwidth=80
setlocal colorcolumn=80

setlocal wrap

autocmd VimEnter * Limelight

" Restore original mappings:
nmap <silent><buffer> = <nop>
nmap <silent><buffer> - <Plug>VinegarUp
