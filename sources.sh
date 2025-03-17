#!/bin/bash

# 检查是否为 root 用户
if [ "$(id -u)" -eq 0 ]; then
    echo "root 用户"

    # 备份原有的 sources.list 文件
    cp /etc/apt/sources.list /etc/apt/sources.list.bak
    echo "已备份 /etc/apt/sources.list 为 /etc/apt/sources.list.bak"

    # 写入新的 sources.list 内容
    cat << EOF > /etc/apt/sources.list
## 默认禁用源码镜像以提高速度，如需启用请自行取消注释
deb http://mirrors.aliyun.com/ubuntu focal main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu focal-updates main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu focal-backports main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu focal-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu focal-security main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu focal-security main restricted universe multiverse

## 预发布软件源（不建议启用）
# deb http://mirrors.aliyun.com/ubuntu focal-proposed main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu focal-proposed main restricted universe multiverse
EOF

    echo "已更新 /etc/apt/sources.list 文件"

    # 更新包列表并升级系统
    apt-get update -y && apt-get upgrade -y
    echo "系统更新完成"
else
    echo "非 root 用户，请使用 root 权限运行此脚本"
fi