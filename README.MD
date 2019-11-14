``` bash
# install node, npm
# install git

npm install -g hexo-cli

hexo -v 

hexo init project_name
cd project_name

# launch hexo 
hexo server


tree -L 1
# folder stucture
.
├── README.MD
├── _config.yml			# configuration
├── db.json
├── node_modules		# node modules, nothing need to do here
├── package-lock.json
├── package.json
├── scaffolds			# templates
├── source				# soure of posts
└── themes				# themes 

# create a new post named post_name
hexo new post_name

# create a draft
hexo new draft draft_name


# launch hexo with draft visible
hexo server --draft

# move a draft to posts
hexo publish draft_name


# create new page, which you can access by "http://localhost:4000/c/"
hexo new page c


# to change the default page for new post,change the config in _config.yml
default_layout: post

```


Post, draft and page are created by templates located in scaffolds.
We can also create our own templates in scaffolds, then we can use the command "hexo new template_name post_name" to create a new post with the new template.


Tags and categories:
``` yaml

---
...
tags: [Tag1, Tag2, Tag3]
categories:
- [Cat1, Cat1.1]
- [Cat2]
- [Cat3]
---
```


## Tag plugins
There is a lot **(tag plugins)[https://hexo.io/docs/tag-plugins.html]** for hexo we can use to render our posts.

## Assets

To add assets for posts, change *post_asset_folder: false* in _config.yml to *post_asset_folder: true* , then **hexo new post_name**, we will get a folder named post_name in the *source/_posts* folder with post_name.MD.

``` markdown

# put a pic in the post_name folder.
{% asset_img hexo.png Image Title %}
{% asset_link hexo.png %}

{% asset_path hexo.png %}

```

## Install a theme
(Hexo Themes)[https://hexo.io/themes/index.html]
``` bash
git clone https://github.com/dongyuanxin/theme-ad.git themes/ad

modify the theme in _config.yml
```
- https://xin-tan.com

## Create your own theme

``` bash

```


# ref
https://pengloo53.gitbooks.io/hexo/content/chapter2/7%20添加文章目录.html