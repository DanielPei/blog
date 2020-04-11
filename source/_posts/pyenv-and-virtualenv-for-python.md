---
title: "Python-environment-management: pyenv + virtualenv + virtaulenvwrapper"

author: Daniel
date: 2019-11-07 23:20:33
tags: [python,pyenv,virtualenv]
categories:
- [python, tools]
---

**pyenv** 与 **virtualenv** 是两个目的不同的 python 环境管理工具。

**pyenv** ： **版本切换**。用于在多个不同的python版本之间进行切换并互不影响。
- 需要临时**引用／安装**当前python版本不支持的模块／库；
- 测试／验证不同python版本间兼容性；


**virtualenv** : **site-packages隔离**。为某个项目或目录创建一个独立的 python 环境，该环境不受当前系统已经安装的 python 包影响。同时，在该环境中安装 python 包也不会影响其他项目。
- 需要使用某一个工具／模块／类库的不同版本；

**virtaulenvwrapper** 则是对 **virtualenv** 创建的虚拟环境进行管理的工具。
- 快速激活／去激活某个 virtualenv 创建的虚拟环境；




# 安装
``` bash
brew update
brew install pyenv
pip install virtualenv
pip install virtualenvwrapper

# add the below line into ~/.bash_profile or ~/.zshrc, to auto-active pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi


# Create a root path for virtualenvs we will created by virtualenv and virtualenvwrapper.
mkdir ~/.virtualenvs

# Set default path for virutalenvs in .zshrc or .bashrc.
export WORKON_HOME=~/.virtualenvs

# Enable virutalenvwrapper in .zshrc or .bashrc.
## As I am using python 3.7 created by pyenv, my virtualenvwrapper.sh script is located in */Users/daniel/.pyenv/versions/3.7.0/bin/virtualenvwrapper.sh*.
source /usr/local/bin/virtualenvwrapper.sh


# Enable virutalwrapper right now!
source ~/.zshrc

```

# pyenv

**场景**：Mac 自带的 python 版本为 2.7，遇到一个项目 *py3_project* 使用 python 3.X 的一些新特性，这时就需要用到 pyenv 将 python 版本临时切换到 3.X (随时可以一条命令再切换回来）。

pyenv 常用命令及场景：
``` bash
# 查看当前系统 python 版本：
python --version
# Python 2.7.10

# 查看本地 pyenv 当前有哪些版本。可以看到当前直邮系统默认的 python 版本。
pyenv versions
* system (set by /Users/daniel/.pyenv/version)


# 安装 python 3.7.0 
pyenv install 3.7.0


# 查看当前已安装版本。 system 前的 * 表示当前正在使用的 python 版本
pyenv versions
* system (set by /Users/daniel/.pyenv/version)
  3.7.0

# 切换到 3.7.0 版本
mkdir py3_project
cd py3_project
pyenv local 3.7.0	# 只切换本目录。 如果希望全局切换，使用 pyenv global 3.7.0

pyenv versions 		# 本目录切换为 3.7.0 
  system
* 3.7.0 (set by PYENV_VERSION environment variable)

cd ~
pyenv versions		# 其他目录未受影响，仍未系统python版本
* system (set by /Users/daniel/.pyenv/version)
  3.7.0


# 恢复项目或目录python版本（一般用不到）
cd py3_project
pyenv local system

pyenv versions
* system (set by /Users/daniel/pyenv_demo/.python-version)
  3.7.0



```

pyenv 帮助:
``` bash
pyenv
pyenv 1.2.10
Usage: pyenv <command> [<args>]

Some useful pyenv commands are:
   commands    List all available pyenv commands
   local       Set or show the local application-specific Python version
   global      Set or show the global Python version
   shell       Set or show the shell-specific Python version
   install     Install a Python version using python-build
   uninstall   Uninstall a specific Python version
   rehash      Rehash pyenv shims (run this after installing executables)
   version     Show the current Python version and its origin
   versions    List all Python versions available to pyenv
   which       Display the full path to an executable
   whence      List all Python versions that contain the given executable
```

# virtualenv  + virtualenvwrapper
**场景**：同时有两个项目 A 和 B，都需要使用 request 包，但由于外部依赖或兼容老系统等原因，A 和 B 需要使用的 request 包的版本有差异。此时，可以创建两个不同的虚拟环境，在各自的环境下分别安装对应版本的 request 包。


``` bash
# Create a virtualenv named py3dev.
mkvirtualenv py3dev

# Create a virtualenv named py3dev ignore the system site packages.
mkvirtualenv --no-site-packages py3dev 

# List virutalenvs.
lsvirtualenv

# Work on a *py3dev* virutalenv.
workon py3dev

# Exit a virtualenv
deactivate

# Remove a virutalenv
rmvirtualenv py3dev


```

# Task ： 分别创建 python 2.X 和 python 3.X 的虚拟环境

python 2.X 虚拟环境创建
``` bash
#确保切换成功，我建议 source .zshrc 一下在切换
#安装全新的Python2.7.10版本
pyenv install 2.7.10
pyenv rehash

#切换到刚安装的这个版本
pyenv local 2.7.10
#确保切换成功
source .zshrc
#验证一下版本,pip发现里面包很少
pip list
#验证版本
python -V
#务必在这个新的2.7.10中安装
pip install virtualenv
pip install virtualenvwrapper
#务必
source .zshrc
#创建2.7.10的开发环境
mkvirtualenv py2dev

#创建完某版本的开发环境后务必退出，当前虚拟环境，不然就是虚拟环境中在创建了。
deactivate
#退出2.7.10环境
pyenv local --unset 2.7.10
source .zshrc

```

python 3.x 虚拟环境创建类似 2.x

