---
title: Local search for hexo
author: Daniel
date: 2019-11-14 23:55:19
tags: 
	- hexo
	- next
categories:
	- hexo 	
---

Enable local search for hexo blog with **next** theme.

# 1. Install **Local Search** plugin.

``` bash
npm install hexo-generator-searchdb --save
```

# 2. Edit site config : **_config.yml**
``` bash
# Add these config to any position.
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

# 3. Edit theme config : **themes/next/_config.yml**
``` bash
# Local search
local_search:
  enable: true
```

# 4. Restart your blog.
``` bash
hexo server
```

