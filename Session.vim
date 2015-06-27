let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/ComplexityPlot/Web
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +496 ~/Documents/ComplexityPlot/Vis/vis.py
badd +2 \[Vundle]\ clean
badd +42 index.html
badd +19 data.tsv
badd +21 complexityplot/complexityplot/urls.py
badd +109 complexityplot/complexityplot/views.py
badd +75 complexityplot/complexityplot/settings.py
badd +445 complexityplot/templates/complexityplot/index.html
badd +14 complexityplot/static/data.tsv
badd +1 ~/.vimrc.local
badd +23 ~/Dropbox/Energy/PlotData/fig6-a.csv
badd +19 ~/Desktop/fig6-b.csv
badd +1 js/data.csv
badd +66 complexityplot/static/datatest.csv
badd +1 \'/Users/sim/Dropbox/Energy/Estimators/PerfectTestData/reliability_table_2.csv
badd +12 ~/Dropbox/Energy/Estimators/PerfectTestData/reliability_table_2.csv
badd +14 complexityplot/static/baseline.csv
badd +112 complexityplot/static/cp.js
badd +4 complexityplot/code/cp_data.py
badd +10 complexityplot/complexityplot/code/cp_data.py
badd +37 testdata/sortinglarge_0_shell.csv
badd +102 testdata/sortinglarge_1_quick.csv
badd +12 testdata/sortinglarge_2_selection.csv
badd +135 complexityplot/complexityplot/code/estimators.py
badd +15 complexityplot/templates/complexityplot/introduction.html
badd +93 complexityplot/complexityplot/models.py
badd +73 complexityplot/templates/complexityplot/browse.html
badd +6 complexityplot/complexityplot/admin.py
badd +11 complexityplot/templates/complexityplot/header.html
badd +14 complexityplot/templates/base.html
badd +17 complexityplot/static/chart.css
badd +1 complexityplot/static/css/common.css
badd +26 complexityplot/static/css/cp.css
badd +8 complexityplot/templates/complexityplot/about.html
badd +157 complexityplot/templates/complexityplot/contact.html
badd +5 complexityplot/static/jquery.validate.js
badd +1 complexityplot/templates/complexityplot/privacy.html
badd +1 complexityplot/static/cp.css
badd +80 complexityplot/complexityplot/code/cp_session.py
badd +16 complexityplot/templates/complexityplot/series-editor-list.html
badd +18 complexityplot/templates/complexityplot/series-editor-edit.html
badd +18 complexityplot/static/series-editor-edit.html
badd +16 complexityplot/static/series-editor-list.html
badd +1 complexityplot/series-editor-angular.js
badd +12 complexityplot/static/series-editor-django.js
badd +33 complexityplot/static/series-editor-angular.js
badd +17 complexityplot/templates/complexityplot/dataformat.html
badd +8 complexityplot/static/chart-meta-django.js
badd +67 complexityplot/templates/complexityplot/print.html
badd +65 complexityplot/complexityplot/settings_ovii.py
silent! argdel *
edit complexityplot/static/css/cp.css
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 27 + 48) / 96)
exe 'vert 1resize ' . ((&columns * 144 + 159) / 319)
exe '2resize ' . ((&lines * 66 + 48) / 96)
exe 'vert 2resize ' . ((&columns * 144 + 159) / 319)
exe '3resize ' . ((&lines * 45 + 48) / 96)
exe 'vert 3resize ' . ((&columns * 174 + 159) / 319)
exe '4resize ' . ((&lines * 48 + 48) / 96)
exe 'vert 4resize ' . ((&columns * 174 + 159) / 319)
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
let s:l = 26 - ((23 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
26
normal! 015|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/static/css
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/about.html
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 21 - ((17 * winheight(0) + 33) / 66)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
21
normal! 0
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/templates/base.html
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 45 - ((30 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
45
normal! 032|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates
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
let s:l = 22 - ((21 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
22
normal! 08|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
wincmd w
exe '1resize ' . ((&lines * 27 + 48) / 96)
exe 'vert 1resize ' . ((&columns * 144 + 159) / 319)
exe '2resize ' . ((&lines * 66 + 48) / 96)
exe 'vert 2resize ' . ((&columns * 144 + 159) / 319)
exe '3resize ' . ((&lines * 45 + 48) / 96)
exe 'vert 3resize ' . ((&columns * 174 + 159) / 319)
exe '4resize ' . ((&lines * 48 + 48) / 96)
exe 'vert 4resize ' . ((&columns * 174 + 159) / 319)
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/dataformat.html
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 146 + 159) / 319)
exe 'vert 2resize ' . ((&columns * 172 + 159) / 319)
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
let s:l = 17 - ((16 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
17
normal! 05|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/privacy.html
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 13 - ((11 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
13
normal! 010|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
wincmd w
exe 'vert 1resize ' . ((&columns * 146 + 159) / 319)
exe 'vert 2resize ' . ((&columns * 172 + 159) / 319)
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/print.html
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 91 + 159) / 319)
exe 'vert 2resize ' . ((&columns * 227 + 159) / 319)
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
let s:l = 67 - ((63 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
67
normal! 02|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
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
let s:l = 529 - ((88 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
529
normal! 06|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
wincmd w
exe 'vert 1resize ' . ((&columns * 91 + 159) / 319)
exe 'vert 2resize ' . ((&columns * 227 + 159) / 319)
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/static/series-editor-angular.js
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 62 + 48) / 96)
exe 'vert 1resize ' . ((&columns * 93 + 159) / 319)
exe '2resize ' . ((&lines * 62 + 48) / 96)
exe 'vert 2resize ' . ((&columns * 76 + 159) / 319)
exe '3resize ' . ((&lines * 28 + 48) / 96)
exe 'vert 3resize ' . ((&columns * 148 + 159) / 319)
exe '4resize ' . ((&lines * 33 + 48) / 96)
exe 'vert 4resize ' . ((&columns * 148 + 159) / 319)
exe '5resize ' . ((&lines * 31 + 48) / 96)
exe 'vert 5resize ' . ((&columns * 162 + 159) / 319)
exe '6resize ' . ((&lines * 31 + 48) / 96)
exe 'vert 6resize ' . ((&columns * 156 + 159) / 319)
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
let s:l = 51 - ((4 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
51
normal! 029|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/static
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/static/series-editor-django.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 34 - ((17 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
34
normal! 049|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/static
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/static/series-editor-list.html
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 6 - ((5 * winheight(0) + 14) / 28)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
6
normal! 037|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/static
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/static/series-editor-edit.html
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 18 - ((17 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
18
let s:c = 154 - ((108 * winwidth(0) + 74) / 148)
if s:c > 0
  exe 'normal! ' . s:c . '|zs' . 154 . '|'
else
  normal! 0154|
endif
lcd ~/Documents/ComplexityPlot/Web/complexityplot/static
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/static/cp.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 134 - ((12 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
134
normal! 0
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
let s:l = 12 - ((7 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 025|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
wincmd w
exe '1resize ' . ((&lines * 62 + 48) / 96)
exe 'vert 1resize ' . ((&columns * 93 + 159) / 319)
exe '2resize ' . ((&lines * 62 + 48) / 96)
exe 'vert 2resize ' . ((&columns * 76 + 159) / 319)
exe '3resize ' . ((&lines * 28 + 48) / 96)
exe 'vert 3resize ' . ((&columns * 148 + 159) / 319)
exe '4resize ' . ((&lines * 33 + 48) / 96)
exe 'vert 4resize ' . ((&columns * 148 + 159) / 319)
exe '5resize ' . ((&lines * 31 + 48) / 96)
exe 'vert 5resize ' . ((&columns * 162 + 159) / 319)
exe '6resize ' . ((&lines * 31 + 48) / 96)
exe 'vert 6resize ' . ((&columns * 156 + 159) / 319)
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/contact.html
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
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
let s:l = 169 - ((53 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
169
normal! 090|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/models.py
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 89 + 48) / 96)
exe 'vert 1resize ' . ((&columns * 145 + 159) / 319)
exe '2resize ' . ((&lines * 61 + 48) / 96)
exe 'vert 2resize ' . ((&columns * 173 + 159) / 319)
exe '3resize ' . ((&lines * 27 + 48) / 96)
exe 'vert 3resize ' . ((&columns * 173 + 159) / 319)
exe '4resize ' . ((&lines * 4 + 48) / 96)
argglobal
setlocal fdm=expr
setlocal fde=pymode#folding#expr(v:lnum)
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 93 - ((70 * winheight(0) + 44) / 89)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
93
normal! 069|
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
let s:l = 66 - ((33 * winheight(0) + 30) / 61)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
66
normal! 051|
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
let s:l = 23 - ((13 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
23
normal! 051|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot
wincmd w
argglobal
enew
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
lcd ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot
wincmd w
exe '1resize ' . ((&lines * 89 + 48) / 96)
exe 'vert 1resize ' . ((&columns * 145 + 159) / 319)
exe '2resize ' . ((&lines * 61 + 48) / 96)
exe 'vert 2resize ' . ((&columns * 173 + 159) / 319)
exe '3resize ' . ((&lines * 27 + 48) / 96)
exe 'vert 3resize ' . ((&columns * 173 + 159) / 319)
exe '4resize ' . ((&lines * 4 + 48) / 96)
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/contact.html
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
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
let s:l = 169 - ((59 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
169
normal! 090|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/code/cp_data.py
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 143 + 159) / 319)
exe 'vert 2resize ' . ((&columns * 175 + 159) / 319)
argglobal
setlocal fdm=expr
setlocal fde=pymode#folding#expr(v:lnum)
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 10 - ((9 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
normal! 0130|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/code
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot/settings.py
setlocal fdm=expr
setlocal fde=pymode#folding#expr(v:lnum)
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 66 - ((61 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
66
normal! 017|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/complexityplot
wincmd w
exe 'vert 1resize ' . ((&columns * 143 + 159) / 319)
exe 'vert 2resize ' . ((&columns * 175 + 159) / 319)
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/static/cp.js
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 26 + 48) / 96)
exe '2resize ' . ((&lines * 67 + 48) / 96)
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
let s:l = 54 - ((15 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
54
normal! 0107|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/static
wincmd w
argglobal
edit ~/Documents/ComplexityPlot/Web/complexityplot/static/cp.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 306 - ((63 * winheight(0) + 33) / 67)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
306
normal! 044|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/static
wincmd w
exe '1resize ' . ((&lines * 26 + 48) / 96)
exe '2resize ' . ((&lines * 67 + 48) / 96)
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/index.html
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 47 + 48) / 96)
exe '2resize ' . ((&lines * 46 + 48) / 96)
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
let s:l = 696 - ((13 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
696
normal! 033|
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
let s:l = 598 - ((21 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
598
normal! 047|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
wincmd w
exe '1resize ' . ((&lines * 47 + 48) / 96)
exe '2resize ' . ((&lines * 46 + 48) / 96)
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/browse.html
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
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
let s:l = 140 - ((77 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
140
normal! 053|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/about.html
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
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
let s:l = 22 - ((21 * winheight(0) + 47) / 94)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
22
normal! 06|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
tabedit ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot/index.html
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 29 + 48) / 96)
exe '2resize ' . ((&lines * 64 + 48) / 96)
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
let s:l = 31 - ((26 * winheight(0) + 14) / 29)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
31
normal! 018|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
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
let s:l = 609 - ((3 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
609
normal! 045|
lcd ~/Documents/ComplexityPlot/Web/complexityplot/templates/complexityplot
wincmd w
exe '1resize ' . ((&lines * 29 + 48) / 96)
exe '2resize ' . ((&lines * 64 + 48) / 96)
tabnext 10
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
