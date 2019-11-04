# !/bin/bash

git add *

git commit -m "update blog content."

git push

hexo clean && hexo deploy