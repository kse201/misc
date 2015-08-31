# Cookbook Name:: deploy
# Attributes:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

default['deploy']['user'] = "vagrant"
default['deploy']['group'] = "vagrant"
default['deploy']['home'] = "/home/#{default['deploy']['user']}"

default['deploy']['dotfiles']['repository'] = "https://github.com/kse201/.dotfiles.git"
default['deploy']['dotfiles']['branch'] = "master"
default['deploy']['dotfiles']['item'] = %w{ .bashrc .gitconfig .gvimrc .screenrc .tmux.conf .vim .vimrc .vimrc.plugin .zsh.d .zshrc bin }

default['deploy']['dotfiles']['shougowares'] = %w{ unite.vim neobundle.vim }

default['deploy']['libevent']['version'] = "2.0.21"
default['deploy']['tmux']['version'] = "1.9a"

default['deploy']['vim']['dependencies'] = %w[ make gcc atk-devel ctags gtk2-devel libX11-devel libXt-devel lua lua-devel git ncurses-devel perl-devel python-devel ruby ruby-devel]
default['deploy']['vim']['source_repo'] = "https://github.com/vim/vim.git
default['deploy']['vim']['src_dir'] = "/usr/local/src"
default['deploy']['vim']['compile_options'] = "--disable-selinux --enable-cscope --enable-gpm --enable-gui=gtk2 --enable-luainterp=yes --enable-multibyte --enable-pythoninterp --enable-rubyinterp --enable-rubyinterp --enable-xim --enable-fontset --prefix=/usr/local --with-features=huge --with-lua-prefix=/usr --with-python-config-dir=/usr/lib/python2.6/config"
