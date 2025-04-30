let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/dev/receipt-processor-challenge/receipt-processor
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +23 src/receipt_processor/core.clj
badd +70 src/receipt_processor/data.clj
badd +1 ~/dev/bloom
badd +3 ~/dev/bloom/src/bloom/datastore.clj
badd +36 ../../bloom/src/bloom/core.clj
badd +142 ../README.md
badd +2 project.clj
badd +1 resources/examples/morning-receipt.json
badd +71 ../api.yml
badd +1 src/receipt_processor/process.clj
badd +57 ~/.config/nvim/init.vim
badd +1 test/receipt_processor/data_test.clj
badd +1 test/receipt_processor/core_test.clj
badd +1 ../../bloom/test/bloom/core_test.clj
badd +1 ~/.lein/profiles.clj
badd +1 resources/examples/simple-receipt.json
badd +6 Dockerfile
badd +1 ../Dockerfile
argglobal
%argdel
$argadd src/receipt_processor/core.clj
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit test/receipt_processor/data_test.clj
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 27 + 28) / 57)
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe '2resize ' . ((&lines * 27 + 28) / 57)
exe 'vert 2resize ' . ((&columns * 118 + 118) / 236)
exe '3resize ' . ((&lines * 26 + 28) / 57)
exe 'vert 3resize ' . ((&columns * 118 + 118) / 236)
exe '4resize ' . ((&lines * 26 + 28) / 57)
exe 'vert 4resize ' . ((&columns * 117 + 118) / 236)
argglobal
balt src/receipt_processor/data.clj
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 64 - ((25 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 64
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("src/receipt_processor/core.clj", ":p")) | buffer src/receipt_processor/core.clj | else | edit src/receipt_processor/core.clj | endif
if &buftype ==# 'terminal'
  silent file src/receipt_processor/core.clj
endif
balt src/receipt_processor/data.clj
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 25 - ((4 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 25
normal! 015|
wincmd w
argglobal
if bufexists(fnamemodify("../README.md", ":p")) | buffer ../README.md | else | edit ../README.md | endif
if &buftype ==# 'terminal'
  silent file ../README.md
endif
balt test/receipt_processor/core_test.clj
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 160 - ((8 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 160
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("test/receipt_processor/core_test.clj", ":p")) | buffer test/receipt_processor/core_test.clj | else | edit test/receipt_processor/core_test.clj | endif
if &buftype ==# 'terminal'
  silent file test/receipt_processor/core_test.clj
endif
balt ../README.md
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 34 - ((24 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 34
normal! 0
wincmd w
exe '1resize ' . ((&lines * 27 + 28) / 57)
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe '2resize ' . ((&lines * 27 + 28) / 57)
exe 'vert 2resize ' . ((&columns * 118 + 118) / 236)
exe '3resize ' . ((&lines * 26 + 28) / 57)
exe 'vert 3resize ' . ((&columns * 118 + 118) / 236)
exe '4resize ' . ((&lines * 26 + 28) / 57)
exe 'vert 4resize ' . ((&columns * 117 + 118) / 236)
tabnext
edit ~/.lein/profiles.clj
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe 'vert 2resize ' . ((&columns * 118 + 118) / 236)
argglobal
balt project.clj
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 3 - ((2 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 021|
wincmd w
argglobal
if bufexists(fnamemodify("project.clj", ":p")) | buffer project.clj | else | edit project.clj | endif
if &buftype ==# 'terminal'
  silent file project.clj
endif
balt ~/.lein/profiles.clj
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 4 - ((3 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 4
normal! 018|
wincmd w
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe 'vert 2resize ' . ((&columns * 118 + 118) / 236)
tabnext
edit ../Dockerfile
argglobal
balt project.clj
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 12 - ((11 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 12
normal! 021|
tabnext
edit resources/examples/morning-receipt.json
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 26 + 28) / 57)
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe '2resize ' . ((&lines * 27 + 28) / 57)
exe 'vert 2resize ' . ((&columns * 117 + 118) / 236)
exe 'vert 3resize ' . ((&columns * 118 + 118) / 236)
argglobal
balt resources/examples/simple-receipt.json
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 2 - ((1 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 028|
wincmd w
argglobal
if bufexists(fnamemodify("resources/examples/simple-receipt.json", ":p")) | buffer resources/examples/simple-receipt.json | else | edit resources/examples/simple-receipt.json | endif
if &buftype ==# 'terminal'
  silent file resources/examples/simple-receipt.json
endif
balt resources/examples/morning-receipt.json
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 8 - ((7 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 8
normal! 05|
wincmd w
argglobal
if bufexists(fnamemodify("../README.md", ":p")) | buffer ../README.md | else | edit ../README.md | endif
if &buftype ==# 'terminal'
  silent file ../README.md
endif
balt ../api.yml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 39 - ((2 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 39
normal! 0
wincmd w
exe '1resize ' . ((&lines * 26 + 28) / 57)
exe 'vert 1resize ' . ((&columns * 117 + 118) / 236)
exe '2resize ' . ((&lines * 27 + 28) / 57)
exe 'vert 2resize ' . ((&columns * 117 + 118) / 236)
exe 'vert 3resize ' . ((&columns * 118 + 118) / 236)
tabnext 3
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
