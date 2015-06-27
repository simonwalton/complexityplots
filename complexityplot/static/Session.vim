let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +42 ~/Documents/ComplexityPlot/Web/index.html
badd +33 ~/Documents/ComplexityPlot/Web/data.tsv
badd +0 ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/urls.py
badd +0 ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/views.py
badd +3 ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/settings.py
badd +0 index.html
badd +0 ~/Documents/ComplexityPlot/Web/complexityplot/static/data.tsv
silent! argdel *
edit ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/settings.py
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 45 + 46) / 92)
exe 'vert 1resize ' . ((&columns * 153 + 153) / 306)
exe '2resize ' . ((&lines * 44 + 46) / 92)
exe 'vert 2resize ' . ((&columns * 153 + 153) / 306)
exe 'vert 3resize ' . ((&columns * 152 + 153) / 306)
argglobal
setlocal fdm=expr
setlocal fde=pymode#folding#expr(v:lnum)
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 78 - ((35 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
78
normal! 044l
lcd ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/views.py
setlocal fdm=expr
setlocal fde=pymode#folding#expr(v:lnum)
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
4
normal! zo
let s:l = 4 - ((3 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 019l
lcd ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/urls.py
setlocal fdm=expr
setlocal fde=pymode#folding#expr(v:lnum)
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 17 - ((16 * winheight(0) + 45) / 90)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
17
normal! 01l
lcd ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot
wincmd w
exe '1resize ' . ((&lines * 45 + 46) / 92)
exe 'vert 1resize ' . ((&columns * 153 + 153) / 306)
exe '2resize ' . ((&lines * 44 + 46) / 92)
exe 'vert 2resize ' . ((&columns * 153 + 153) / 306)
exe 'vert 3resize ' . ((&columns * 152 + 153) / 306)
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/static/data.tsv
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 45 + 46) / 92)
exe '2resize ' . ((&lines * 44 + 46) / 92)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 14 - ((13 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
14
normal! 016l
lcd ~/Documents/ComplexityPlot/Web/complexityplot/static
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/index.html
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 69 - ((21 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
69
normal! 016l
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
wincmd w
exe '1resize ' . ((&lines * 45 + 46) / 92)
exe '2resize ' . ((&lines * 44 + 46) / 92)
tabnext 2
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filmnrxoOtT
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
