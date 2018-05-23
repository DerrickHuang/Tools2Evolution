1、What's Neovim
Bram Moolenaar 在写 Vim 时还是 90 年代初，至今已经 20 多年 过去了。其中，不仅包含了大量的遗留代码，而且程序的维护、Bug 的 修复、以及新特性的添加都变得越来越困难。为了解决这些问题，Neovim 项目应运而生。Neo 即“新”之意，它是 Vim 在这个新时代的重生。

根据 Neovim 的自述说明，在总体上，它将达到下列目的：

通过简化维护以改进 Bug 修复及特性添加的速度；
分派各个开发人员的工作；
实现新的、现代化的用户界面，而不必修改核心源代码；
利用新的、基于协同进程的新插件架构改善扩展性，并支持使用任何语言 编写插件
以上介绍来自linuxtoy

此外, 在最近的版本中, 还有非常值得注意的几点:

实现了嵌入式终端模拟器, 可以跟各种REPL插件说再见了
使用远程API(好像是socket), 不光能使用各种语言编写插件, 而且可以很方便的编写GUI版本, 甚至嵌入至IDE中
由于内部优化了事件监听器还是什么的, 代码粘贴的时候, 可以自动识别, 不像vim里一样需要:set paste, 不然会出现蜜汁缩进和括号对
直接支持剪贴板, 不需要重新编译
2、How to install Neovim
注意：本安装教程日期为2018年3月5日，遇到问题请参考官网安装文档 Installing-Neovim

2.1、先安装 neovim
ls /unsullied/sharefs/wangyuzhi
sudo apt-key add /unsullied/sharefs/wangyuzhi/shared-utils/ppa/neovim/gpg.key
# 下面两行是一条指令
echo "deb file:///unsullied/sharefs/wangyuzhi/shared-utils/ppa/neovim xenial main " | \
  sudo tee /etc/apt/sources.list.d/neovim.list
sudo apt update
sudo apt install -y neovim
# set brainpp proxy before installing python plugin
sudo -E pip_brain install neovim jedi
2.2、copy配置文件
把 wangyuzhi 的配置文件 copy 给自己

mkdir -p ~/.config/nvim
cd ~/.config/nvim
tar vxf /unsullied/sharefs/wangyuzhi/shared-utils/neovim-config.tar
# 让 neovim 成为默认的 vim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
# 刷新插件
nvim -c UpdateRemotePlugins
2.3、配置tmux.conf
vim ~/.tmux.conf

# add line
set -sg escape-time 10
该 vim 对 python 程序能自动补全、提示函数参数，在普通模式下按 \g (先按\，再按g) 即可跳转到定义，\u 即可查找函数被调用的地点等。

p.s. 刚安装完成时，补全引擎需要建立缓存，会比较慢，过一会儿就好了。

 3、常用neovim配置
neovim的配置文件地址在

~/.config/nvim/init.vim

我们推荐使用vim-plug来管理插件。

安装vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
配置~/.config/nvim/init.vim
" vim-plug plugins {
call plug#begin('~/.vim/plugged')

" some common practice are in vim-sensible
Plug 'tpope/vim-sensible'


" Nerdtree to navigate among directories
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" YouCompleteMe for auto completion
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" fzf  for fuzzy search {
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" activate fzf by ctrl-p
nnoremap <silent> <C-p> :Files<CR>
" }


" mundo for navigate in undo-tree {
Plug 'simnalamburt/vim-mundo'
nnoremap <F5> :MundoToggle<CR>
" }


" vim-airline for pretty status bar
Plug 'vim-airline/vim-airline'
call plug#end()
" }



" show line number all the time
set number


" python: set indent to 4 spaces {
" autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" }


" shortcuts for common python boilerplates {
" `ipeb` for ipython embed
abbr ipeb from IPython import embed; embed()


" `agps` for argparse
abbr agps parser = argparse.ArgumentParser()
\<CR>parser.add_argument(dest='')
\<CR>args = parser.parse_args()
" }


" Move cursor in insert mode {
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
inoremap <c-e> <End>
inoremap <c-f> <Home>
inoremap <c-w> <Right><Esc>wi
inoremap <c-b> <Right><Esc>bi
inoremap <c-O> <Esc>O
" }
安装插件
vim +PlugInstall



 4、vim cheet sheet
参考文档：https://www.fprintf.net/vimCheatSheet.html


