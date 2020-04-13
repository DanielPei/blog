---
title: 01-Deploy hexo blog to githubPage
date: 2019-10-31 23:56:14
tags: [ "Hexo" ]
author: Daniel
---

1. Install hexo-deployer-git.
``` bash
cd hexo_project
npm install hexo-deployer-git --save
```

<!-- more -->

2. Edit **_config.yml**
``` yml
deploy:
  type: git
  repo: <repository url> #https://github.com/DanielPei/danielpei.github.io
  branch: [branch] # master
  message: [message] # leave this blank
```

3. Deploy
``` bash
hexo clean && hexo deploy
```

**Ref:**
1. [Hexo one-command-deploy](https://hexo.io/docs/one-command-deployment)
