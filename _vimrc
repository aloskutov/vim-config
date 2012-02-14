" vim600:foldmethod=marker

set statusline=%t\ %y%m%r[%{&fileencoding}]%<[%{strftime(\"%d.%m.%y\",getftime(expand(\"%:p\")))}]%k%=%-14.(%l,%c%V%)\ %P

set nocompatible
" Отключаем перенос строк
set nowrap
" Включаем вывод в заголовке окна имя редактируемого файла
set title
" Включаем автоотступы
set ai
set si
" Включаем нумерацию строк
set nu
" Настраиваем отображения скрытых символов, при включении их отображения:
" tab - два символа для отображения табуляции (первый символ и заполнитель)
" eol - символ для отображения конца строки
" precedes - индикатор продолжения строки в лево
" extends - индикатор продолжения строки в право
set listchars=tab:>·,trail:·,eol:¬,precedes:«,extends:»
" Настраиваем отображение символа переноса строки, при включении переноса
" строки
set showbreak=…

" Формат файлов 
set fileformats=dos,unix
" Кодировки файлов
set fileencodings=utf-8,cp1251,koi8-r,cp866
" Включаем запись backup'ов
set backup writebackup

" Каталоги бэкапов для unix и windows {{{1
if has("unix")
	" Указываем каталог для backup'ов
	set backupdir=$HOME/.vim/backup
	" Указываем каталог для swap файла
	set directory=$HOME/.vim/temp
endif
if has("win32")
	" Указываем каталог для backup'ов
	set backupdir=~\vimfiles\backup
	" Указываем каталог для swap файла
	set directory=~\vimfiles\swap
endif

" Функции специфические для GUI {{{1
if has("gui_running")
	"set guioptions=mlrbT
	" Включаем отображение:
	" m - (m)enu bar
	" r - (r)ight-hand scrollbar
	" b - (b)ottom scrollbar
	" T - (T)oolbar
	set guioptions=mrbT
	" Отображаем ruler
	set ru
	if has("gui_win32")
		"Устанавливаем шрифт и его размер
		"set gfn=Courier_New_Cyr:h10:cRUSSIAN
		"set gfn=DejaVu_Sans_Mono:h10:cRUSSIAN
		set gfn=Consolas:h10:cRUSSIAN
	endif
	" Устанавливаем цветовую схему
	colorscheme mustang
endif

" Функции спецические для консоли {{{1
if !has("gui_running")
	" Устанавливаем цветовую схему
	colorscheme torte
endif


:filetype plugin on

:filetype indent on

" Clean html function {{{1
command! -nargs=* Chtml call Chtml()
function! Chtml()
	let s:count = line("$")
	for n in range (1, s:count)
		let s:str = getline(n)
		let s:str = substitute (s:str, "\&", '\&amp;', "g")	
		let s:str = substitute (s:str, "\\(\\s\\)\\(--\\)\\(\\s\\)","\\1\\&mdash;\\3", "g")	
		let s:str = substitute (s:str, "\"", '\&quot;', "g")
		let s:str = substitute (s:str, "«", '\&laquo;', "g")
		let s:str = substitute (s:str, "»", '\&raquo;', "g")
		let s:str = substitute (s:str, "“", '\&ldquo;;', "g")
		let s:str = substitute (s:str, "”", '\&rdquo;', "g")
		let s:str = substitute (s:str, "„", '\&bdquo;', "g")
		let s:str = substitute (s:str, "<", '\&lt;', "g")
		let s:str = substitute (s:str, ">", '\&gt;', "g")
		call setline(n,s:str)
	endfor
endfunction

" xml-plugin config {{{1
let xml_tag_completion_map = "<C-l>"

" Wrap function {{{1
command! -nargs=* Wrap call Wrap()
function! Wrap()
	" Перенос слов
	set wrap!
	" Перенос по словам
	set linebreak!
endfunction

" _vimrc on the fly {{{1
if has("autocmd")
	autocmd bufwritepost .vimrc,_vimrc source $MYVIMRC
endif

" Set tabstop, softtabstop and shiftwidth to the same value {{{1
command! -nargs=* Stab call Stab()
function! Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
		finally
		echohl None
	endtry
endfunction

" Auto whitespace" {{{1
if has("autocmd")
	"Enable file type detection
	filetype on
	autocmd FileType php setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType python setlocal ts=4 sts=4 sw=4 et
	autocmd FileType lisp setlocal ts=4 sts=4 sw=4 et
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType ruby setlocal ts=4 sts=4 sw =4 noet

	autocmd FileType html setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType xhtml setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType xml setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType css setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType sass setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType scss setlocal ts=2 sts=2 sw=2 noet

	autocmd FileType crontab setlocal ts=8 sts=8 sw=8 noet
	autocmd FileType fstab setlocal ts=8 sts=8 sw=8 noet
	autocmd FileType make setlocal ts=8 sts=8 sw=8 noet

	autocmd FileType vim setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType apache setlocal ts=2 sts=2 sw=2 noet
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
	" Treat .rss file as XML
	autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
	" Treat .phps file as php
	autocmd BufNewFile,BufRead *.phps set filetype=php
	" .scss file
	autocmd BufNewFile,BufRead *.scss set filetype=scss
	" .sass file
	autocmd BufNewFile,BufRead *.sass set filetype=sass

endif

" Auto set compiler "{{{1
if has("autocmd")
	filetype on
	autocmd FileType html compiler tidy
	autocmd FileType xhtml compiler tidy
	autocmd FileType css compiler tidy
	autocmd FileType php compiler php
endif

" Menu Encoding {{{1
set wildmenu
set wcm=<TAB>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.dos :e ++enc=ibm866<CR>
menu Encoding.utf-8 :e ++enc=utf-8 <CR>
map <F8> :emenu Encoding.<TAB>

" Map keys {{{1
imap <C-o> :set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i
" F2 - Save
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i
" Alt+F2 - Save As..
imap <A-F2> <C-o>:browse confirm sav<Enter>
" F5 - RU Spell
nmap <F5> :setlocal spell! spelllang=ru_ru<cr>
vmap <F5> <esc>:setlocal spell! spelllang=ru_ru<cr>
imap <F5> <esc>:setlocal spell! spelllang=ru_ru<cr>
" Alt+F5 - EN Spell
nmap <A-F5> :setlocal spell! spelllang=en<cr>
vmap <A-F5> <esc>:setlocal spell! spelllang=en<cr>
imap <A-F5> <esc>:setlocal spell! spelllang=en<cr>
" \l - show invisibles
nmap <leader>l :set list!<CR>
" \m - tab with .vimrc or _vimrc
nmap <leader>m :tabedit $MYVIMRC<CR>
" \w - set wrap
nmap <leader>w :set wrap!<CR>

" Other {{{1
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" Function MyDiff() {{{1
set diffexpr=MyDiff()
function! MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
