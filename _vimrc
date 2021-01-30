" vim600: foldmethod=marker
scriptencoding utf-8
set encoding=utf-8

" Install vim-plug
" - Windows PowerShell:
" iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ni $HOME/vimfiles/autoload/plug.vim -Force
" - Unix:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
" Themes
    Plug 'dikiaap/minimalist'
    Plug 'junegunn/seoul256.vim'
    Plug 'croaker/mustang-vim'
" Interface
    Plug 'itchyny/lightline.vim'
" Web-dev
    Plug 'mattn/emmet-vim'
" File management
    Plug 'preservim/nerdtree'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set statusline=%t\ %y%m%r[%{&fileencoding}]%<[%{strftime(\"%d.%m.%y\",getftime(expand(\"%:p\")))}]%k%=%-14.(%l,%c%V%)\ %P

set laststatus=2
let python_highlight_all=1

" Шифруем используя Blowfish
set cm=blowfish

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
set listchars=tab:▸·,trail:·,space:·,eol:↲,precedes:«,extends:»

" Настраиваем отображение символа переноса строки, при включении переноса строки
" set showbreak=…

" Формат файлов
set fileformats=dos,unix

" Кодировки файлов
set fileencodings=utf-8,ucs-bom,utf-16le,cp1251,koi8-r,cp866

" EditorConfig
if has("win32")
    let g:EditorConfig_exec_path = 'c:\ProgramData\chocolatey\bin\editorconfig.exe'
    let g:EditorConfig_core_mode = 'external_command'
endif


" Включаем запись backup'ов
set backup writebackup

" Каталоги бэкапов для unix и windows {{{1
au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'
if has("unix")
    " Указываем каталог для backup'ов
    set backupdir=$HOME/.vim/backup
    " Указываем каталог для swap файла
    set directory=$HOME/.vim/swap
    " Указываем каталог для undo файла
    set udir=$HOME/.vim/undo

endif
if has("win32")
    " Указываем каталог для backup'ов
    set backupdir=~/vimfiles/backup//
    " Указываем каталог для swap файла
    set directory=~/vimfiles/swap//
    " Указываем каталог для undo файлов
    set udir==~/vimfiles/undo//
endif

" Функции специфические для GUI {{{1
if has("gui_running")
    "set guioptions=mlrbT
    " Включаем отображение:
    " m - (m)enu bar
    " r - (r)ight-hand scrollbar
    " b - (b)ottom scrollbar
    " T - (T)oolbar
    set guioptions=mrb
    set t_Co=256
    " Отображаем ruler
    colorscheme mustang
    if has("gui_win32")
        "Устанавливаем шрифт и его размер
        "set gfn=Courier_New_Cyr:h10:cRUSSIAN
        set gfn=DejaVu_Sans_Mono:h10:cRUSSIAN
        "set gfn=Cascadia_Code_PL:h10:cRUSSIAN
        "set gfn=Consolas:h9:cRUSSIAN
    endif
    else " Функции спецические для консоли
    colorscheme minimalist
endif


:filetype plugin on

:filetype indent on

" Plugins

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
    autocmd FileType vim setlocal ts=4 sts=4 sw=4 et
    autocmd FileType apache setlocal ts=2 sts=2 sw=2 noet
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et
    autocmd Filetype json setlocal ts=4 sts=4 sw=4 et
    autocmd FileType git setlocal ts=2 sts=2 sw=2 et

    autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
    autocmd BufNewFile,BufRead .gitconfig,.gitignore set filetype=git
endif

" Menu Encoding {{{1
set wildmenu
set wcm=<TAB>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.dos :e ++enc=ibm866<CR>
menu Encoding.utf-8 :e ++enc=utf-8 <CR>
menu Encoding.utf-16le :e ++enc=utf-16le <CR>
map <F9> :emenu Encoding.<TAB>

" Map keys {{{1
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
" \z - set Zend Coding Standards & retab
nmap <leader>z :set ts=4 sw=4 et<CR>:retab<CR>:set ff=unix<CR>

" Для нормальной работы под windows (выделение/копирование/вставка и т.д.) {{{1
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

" NERDTree config {{{1
let NERDTreeShowHidden=1
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
