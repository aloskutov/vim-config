# _vimrc #
Файл конфигурации для windows, хотя можно и под иксами в линуксе. Особой разницы между конфигами нет, но линуксовый по-легче.

## Установка ##
Скачиваем в %USERPROFILE%:
```sh
wget https://raw.githubusercontent.com/aloskutov/vim-config/master/_vimrc
```
или curl'ом
```sh
curl -O https://raw.githubusercontent.com/aloskutov/vim-config/master/_vimrc
```

# .vimrc #
Файл конфигурации vim для консоли линукс. Относительно легковесный, лишнее всегда можно убрать.

## Установка ##
Устанавливается просто - сливается в домашнюю директорию и готово:
```sh
wget https://raw.githubusercontent.com/aloskutov/vim-config/master/.vimrc
```
или curl'ом
```sh
curl -O https://raw.githubusercontent.com/aloskutov/vim-config/master/.vimrc
```

## О Конфиге ##

При запуске проверяется наличие установленного менеджера плагинов [vim-plug], если нет, то устанавливает. Далее нужно только установить плагины командой
```vim
:PlugInstall
```

После строки ```call plug#begin('~/.vim/plugged')``` прописаны устанавливаемые плагины.

```vim
" Declare the list of plugins.
Plug 'dikiaap/minimalist'
Plug 'junegunn/seoul256.vim'
Plug 'croaker/mustang-vim'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
```

## Minimalist ##
Тёмная цветовая схема [minimalist]. Мне понравилась, сижу под ней в консоле. Больше добавить нечего, можно сидеть на стандартных, можно добавить свою. Скачивать множество цветовых схем смысла нет, ибо многие дублируются или только под GUI. А используется обычно одна схема, которую включил и забыл.

## Mustang ##
Тёмная цветовая схема [mustang]. Моя основная схема под GUI, но нормально отображается и в консоле.

## NERDTree ##
>The [NERDTree] is a file system explorer for the Vim editor. Using this plugin, users can visually browse complex directory hierarchies, quickly open files for reading or editing, and perform basic file system operations.

Можно жить и без него, но с ним удобнее ;)

### Настройки ###
Хоткеи
<pre>
\n      Переключить фокус на NERDTree
Ctrl+n  Включить на панель NERDTree
F7      Включение/выключение панели NERDTree
Ctrl+f  Найти текущий файл в дереве каталогов открытой панели NERDTree
</pre>

## Emmet ##
Если работаете с HTML, то без [emmet-vim] не обойтись.

### Настройки ###
Хоткеи
<pre>
Ctrl+y+,    Развернуть аббвературу в фрагмент кода
Ctrl+y+/    Закомментировать/раскомментировать блок
</pre>
Остальные описаны в руководстве https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL

Переопределение комбинации клавиш c Cntrl+Y на Cntrl+Z:
```vim
let g:user_emmet_leader_key='<C-Z>'
```

Подключение Emmet только для html и css файлов:
```vim
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
```
Более подробная информация есть в документации к плагину.

## Lightline ##

Лёгкий и конфигурируемый плагин [lightline] для управления строкой статуса. Настройки довольно гибкие, но мне хватает дефолтных.

Аналогичные плагины: [vim-airline] и [powerline]. Есть [vim-powerline], но он находится в стадии β-версии и с 2012 года не поддерживается.

## seoul256 ##
Низкоконтрастная тема [seoul256] с большими возможностями кастомизации.

![seoul256-bg](https://raw.github.com/junegunn/i/master/seoul256-bg.png)


[vim-plug]: https://github.com/junegunn/vim-plug
[minimalist]: https://github.com/dikiaap/minimalist
[seoul256]: https://github.com/junegunn/seoul256.vim
[mustang]: https://github.com/croaker/mustang-vim
[NERDTree]: https://github.com/preservim/nerdtree
[emmet-vim]: https://github.com/mattn/emmet-vim
[Lightline]: https://github.com/itchyny/lightline.vim
[vim-airline]: https://github.com/vim-airline/vim-airline
[powerline]: https://github.com/powerline/powerline
[vim-powerline]: https://github.com/Lokaltog/vim-powerline