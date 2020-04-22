#!/bin/bash

function _info(){
    echo -e "\033[32m$1\033[0m"
}

function _warning(){
    echo -e "\033[33m$1\033[0m"
}

function _error(){
    echo -e "\033[31m$1\033[0m"
}

function _green(){
	echo "\033[32m"$1"\033[0m"
}

function _cyan(){
	echo "\033[36m"$1"\033[0m"
}

function _blue(){
	echo "\033[34m"$1"\033[0m"
}

function _magenta(){
	echo "\033[35m"$1"\033[0m"
}

function _grey(){
	echo "\033[37m"$1"\033[0m"
}

function _yellow(){
	echo "\033[33m"$1"\033[0m"
}

function _red(){
	echo "\033[31m"$1"\033[0m"
}

# 确保脚本抛出遇到的错误
set -e

_info '
-------------------------------------
把当前项目拷贝到 blog 同步脚本
-------------------------------------
'



if [ $# == 0 ]
then
    echo -e "$(_warning '请输入一个目录用于复制')"
else
	name=$1
	exit
fi

function copy(){
    cd ../blog/
    # git
    git pull
    git status

    cd ../$name-analysis

    rsync -av --exclude  .git/ --exclude --exclude  $name/ --exclude scripts/  .  ../blog/docs/$name

    echo

    cd ../blog/

    git
    git pull
    git status
    git add docs/$name
    git commit -m "docs: docs/$name 同步 $name-analysis :construction:"
    git push
}

copy $name

cd -


echo

_info '
-------------------------------------
同步完成，并提交到远程仓库
-------------------------------------
'
cd -
