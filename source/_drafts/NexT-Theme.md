---
title: "Switch to NexT theme for hexo"
author: Daniel
date: 2019-11-03 20:15:32
tags: [Hexo, NexT]
categories:
- [Hexo, Themes]
---

# 1. Download NexT theme.
``` bash
git clone https://github.com/theme-next/hexo-theme-next themes/next
```

# 2. Enable theme in site config.
Edit **_config.yml**
``` yaml
# change theme to next 
theme: next
```


# 3. Restart your blog.
``` bash
hexo clean
hexo server
```


# **Ref:**
- [NexT](https://theme-next.org)