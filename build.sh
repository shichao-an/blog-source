#!/usr/bin/env bash

set -e
blog_html_dir="$(dirname $0)/../blog"
echo $blog_html_dir
tinker --build
[ -n "$(ls $blog_html_dir)" ] && rm -rf $blog_html_dir/*
cp -a blog/html/. $blog_html_dir
echo 'blog.shichao.io' > $blog_html_dir/CNAME
