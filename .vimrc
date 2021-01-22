if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
    Plug 'dikiaap/minimalist'
    Plug 'junegunn/seoul256.vim'
    Plug 'croaker/mustang-vim'
    Plug 'mattn/emmet-vim'
    Plug 'itchyny/lightline.vim'
    Plug 'preservim/nerdtree'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

color minimalist

set statusline=%t\ %y%m%r[%{&fileencoding}]%<[%{strftime(\"%d.%m.%y\",getftime(expand(\"%:p\")))}]%k%=%-14.(%l,%c%V%)\ %P

set laststatus=2
let python_highlight_all=1

" Шифруем используя Blowfish
set cm=blowfish

scriptencoding utf-8

set encoding=utf-8

set nocompatible
" Отключаем перенос строк
set wrap
" Включаем вывод в заголовке окна имя редактируемого файла
set title
" Включаем автоотступы
set ai
set si
" Включаем нумерацию строк :set numbers
set nu
" Включаем относительную нумерацию строк :set relativenumber
set rnu
" Включаем рулер
set ru
" Настраиваем отображения скрытых символов, при включении их отображения:
" tab - два символа для отображения табуляции (первый символ и заполнитель)
" eol - символ для отображения конца строки
" precedes - индикатор продолжения строки в лево
" extends - индикатор продолжения строки в право
set listchars=tab:>·,trail:·,eol:¬,precedes:«,extends:»
" Настраиваем отображение символа переноса строки, при включении переноса
" строки
" set showbreak=…

" Формат файлов
set fileformats=dos,unix
" Кодировки файлов
set fileencodings=utf-8,ucs-bom,utf-16le,cp1251,koi8-r,cp866

" .vimrc on the fly {{{1
if has("autocmd")
	autocmd bufwritepost .vimrc,_vimrc source $MYVIMRC
endif

" Auto whitespace" {{{1
if has("autocmd")
	"Enable file type detection
	filetype on
	autocmd FileType php setlocal ts=4 sts=4 sw=4 et
	autocmd FileType python setlocal ts=4 sts=4 sw=4 et
	autocmd FileType lisp setlocal ts=4 sts=4 sw=4 et
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType ruby setlocal ts=4 sts=4 sw =4 noet
	autocmd FileType html setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType xhtml setlocal ts=4 sts=4 sw=4 noet
	autocmd FileType ant setlocal ts=4 sts=4 sw=4 noet
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
	autocmd Filetype json setlocal ts=4 sts=4 sw=4 et
	autocmd FileType git setlocal ts=2 sts=2 sw=2 et

	autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
	autocmd BufNewFile,BufRead .gitconfig,.gitignore set filetype=git
endif

" Map keys {{{1
" F2 - Save
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i
" Alt+F2 - Save As..
imap <A-F2> <C-o>:browse confirm sav<Enter>
" \l - show invisibles
nmap <leader>l :set list!<CR>
" \m - tab with .vimrc or _vimrc
nmap <leader>m :tabedit $MYVIMRC<CR>
" \w - set wrap
nmap <leader>w :set wrap!<CR>
" \z - set Zend Coding Standards & retab
nmap <leader>z :set ts=4 sw=4 et<CR>:retab<CR>:set ff=unix<CR>

" Menu Encoding {{{1
set wildmenu
set wcm=<TAB>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.dos :e ++enc=ibm866<CR>
menu Encoding.utf-8 :e ++enc=utf-8 <CR>
menu Encoding.utf-16le :e ++enc=utf-16le <CR>
map <F9> :emenu Encoding.<TAB>

" NERDTree config {{{1
let NERDTreeShowHidden=1
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
