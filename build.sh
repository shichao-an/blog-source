#!/usr/bin/env bash

set -e
# Directory for "shichao-an/blog" repo
blog_html_dir="$(dirname $0)/../blog"
tinker --build
gsed -i 's#http://fonts#https://fonts#g' blog/html/_static/flat.css
gsed -i 's#http://#https://#g' blog/html/_static/disqus.js
# Remove old files (dot files will not be affected)
[ -n "$(ls $blog_html_dir)" ] && rm -rf $blog_html_dir/*
cp -a blog/html/. $blog_html_dir
# Copy CNAME
echo 'blog.shichao.io' > $blog_html_dir/CNAME
