# \_vimrc

Файл конфигурации для windows, хотя можно и под иксами в линуксе. Особой разницы между конфигами нет, но линуксовый по-легче и ориентирован под установку на сервер.

## Установка

Скачиваем в %USERPROFILE%:

```sh
wget https://raw.githubusercontent.com/aloskutov/vim-config/master/_vimrc
```

или curl'ом

```sh
curl -O https://raw.githubusercontent.com/aloskutov/vim-config/master/_vimrc
```

После копирования конфига следует вручную установить [vim-plug] и запустив vim установить все остальные плагины командой:

```vim
:PlugInstall
```

Список устанавливаемых плагинов:

```vim
call plug#begin('~/vimfiles/plugged')
" Declare the list of plugins.
" Themes
    Plug 'dikiaap/minimalist'
    Plug 'junegunn/seoul256.vim'
    Plug 'croaker/mustang-vim'
" Interface
    Plug 'itchyny/lightline.vim'
" Web-dev
    Plug 'mattn/emmet-vim'
    Plug 'bpearson/vim-phpcs'
    Plug 'editorconfig/editorconfig-vim'
" File management
    Plug 'preservim/nerdtree'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
```

# .vimrc

Файл конфигурации vim для консоли линукс. Относительно легковесный, лишнее всегда можно убрать.
Отсутствуют плагины:

-   [vim-phpcs]
-   [editorconfig-vim]

Можно отключить [emmet-vim]

## Установка

Устанавливается просто - скачивается в домашнюю директорию и готово:

```sh
wget https://raw.githubusercontent.com/aloskutov/vim-config/master/.vimrc
```

или curl'ом

```sh
curl -O https://raw.githubusercontent.com/aloskutov/vim-config/master/.vimrc
```

## О Конфиге

При запуске проверяется наличие установленного менеджера плагинов [vim-plug], если нет, то устанавливает. Далее нужно только установить плагины командой

```vim
:PlugInstall
```

После строки `call plug#begin('~/.vim/plugged')` прописаны устанавливаемые плагины.

```vim
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
```

# Темы

Небольшое отступление. Если используете Windows Terminal или Windows Terminal Preview, то из-за некоторых цветовых схем терминала могут "съезжать" цвета в консольной версии vim'а открытого в терминале. В моей основной цветовой схеме [mustang] от "One Half Dark", становится нечитаемым текст свёрнутого кода. Из серого на синем он становится светлосерым на ярко-голубом. Поэтому для консольной версии установлена другая цветовая схема - [minimalist]. Можно установить в Windows Terminal цветовую схему "Vintage", в ней нет такой проблемы.

## Minimalist

Тёмная цветовая схема [minimalist]. Подключена в консольной версии.

## Mustang

Тёмная цветовая схема [mustang]. Подключена в gui-версии.

## seoul256

Низкоконтрастная тема [seoul256] с большими возможностями кастомизации.

# Управление интерфейсом

## Lightline

Лёгкий и конфигурируемый плагин [lightline] для управления строкой статуса. Настройки довольно гибкие, но мне хватает дефолтных.
Аналогичные плагины: [vim-airline] и [powerline]. Есть [vim-powerline], но он находится в стадии β-версии и с 2012 года не поддерживается.

# Web-dev

## Emmet

Если работаете с HTML, то без [emmet-vim] не обойтись.

### Настройки

Хоткеи

```
    Ctrl+y+,    Развернуть аббвературу в фрагмент кода
    Ctrl+y+/    Закомментировать/раскомментировать блок
```

Остальные описаны в руководстве <https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL>.

Переопределение комбинации клавиш c Ctrl+Y на Ctrl+Z:

```vim
let g:user_emmet_leader_key='<C-Z>'
```

Подключение Emmet только для html и css файлов:

```vim
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
```

Более подробная информация есть в документации к плагину.

## vim-phpcs

[vim-phpcs] небольшой плагин для проверки кода в PHP CodeSniffer текущего файла. Соответственно в системе должен быть установлен phpcs и стандарты кодирования. По умолчанию, в настройках плагина установлена проверка на соответствие стандарту кодирования Pear.

Проверка кода запускается командой `:CodeSniff`

### Настройка vim-phpcs

Я использую следующиее настройки:

```vim
if exists('g:loaded_Vimphpcs')
    let g:Vimphpcs_Standard = 'PSR12'
    let g:Vimphpcs_ExtraArgs= '-q'
endif
```

Во первых, проверятся устновлена ли глобальная переменная loaded_Vimphpcs, если да, у нас подключен плагин [vim-phpcs] и можно устаналивать следующие параметры.

`Vimphpcs_Standard` Указываем стандарт, на соответствие которому будем проверять код. В моём случае - PSR12.

`Vimphpcs_ExtraArgs` Дополнительные аргументы командной строки `-q Quiet mode; disables progress and verbose output`

## EditorConfig Vim Plugin

Плагин поддерживающий работу с EditorConfig, в новых версиях не требуется подключение внешней библиотеки "ядра".

> Previous versions of this plugin also required a Python "core". The core included the code to parse .editorconfig files. This plugin includes the core, so you don't need to download the core separately.

Есть баг с `insert_final_newline` пустая строка в конце файла не добавляется. И вроде как, это не баг а фича vim'а. Судя по отзывам в neovim'е такая же проблема. Есть "костыли" для решения этой проблемы.

### Настройка EditorConfig

Так как в новых версиях не требуется подключать внешнее ядро конфигурирование упростилось.

```vim
" EditorConfig options {{{1
if exists("g:loaded_EditorConfig")
    au FileType gitcommit let b:EditorConfig_disable = 1
endif
```

# Управление файлами

## NERDTree

> The [NERDTree] is a file system explorer for the Vim editor. Using this plugin, users can visually browse complex directory hierarchies, quickly open files for reading or editing, and perform basic file system operations.

Можно жить и без него, но с ним удобнее ;)

### Настройки

Хоткеи

```
\n      Переключить фокус на NERDTree
Ctrl+n  Включить на панель NERDTree
F7      Включение/выключение панели NERDTree
Ctrl+f  Найти текущий файл в дереве каталогов открытой панели NERDTree
t       Открыть текущий файл в новой вкладкеa
i       Открыть текущий файл в горизонтально разделённом окне
s       Открыть текущий файл в вертикально разделённом окне
I       Показать/скрыть скрытые файлы (dot-files)
m       Показать NERDTree меню
R       Обновиь дерево файлов, полезно когда файлы изменялись/добавлялись вне vim'а
?       Показать/скрыть бытрую помощь по NERDTree
```

[vim-plug]: https://github.com/junegunn/vim-plug
[minimalist]: https://github.com/dikiaap/minimalist
[seoul256]: https://github.com/junegunn/seoul256.vim
[mustang]: https://github.com/croaker/mustang-vim
[nerdtree]: https://github.com/preservim/nerdtree
[emmet-vim]: https://github.com/mattn/emmet-vim
[lightline]: https://github.com/itchyny/lightline.vim
[vim-airline]: https://github.com/vim-airline/vim-airline
[powerline]: https://github.com/powerline/powerline
[vim-powerline]: https://github.com/Lokaltog/vim-powerline
[vim-phpcs]: https://github.com/bpearson/vim-phpcs
[editorconfig-vim]: https://github.com/editorconfig/editorconfig-vim
