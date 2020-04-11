---
title: '01-sphinx : basic demo'
author: Daniel
tags:
  - python
  - sphinx
categories:
  - python
  - sphinx
date: 2019-11-06 22:09:26
---

# Install **sphinx** and **sphinx-rtd-theme**
``` bash
workon py3dev 

pip install sphinx
pip install sphinx-rtd-theme

pip list
```

# Init a project with sphinx.
``` bash
mkdir sphinx_demo

cd sphinx_demo
sphinx-quickstart

# Choose seprate source and builder, for other configuration, choose whatever you want.

mkdir src

tree -L 1

.
├── Makefile	# build script for Unix.
├── build 		# sphinx docs build result.
├── make.bat	# build script for windows os.
├── source		# source folder for sphinx docs.
└── src 		# user defined folder for python modules and scripts.
```

# Config sphinx.
Edit **source/conf.py**

## Set python source folder.

``` python
# add those lines.
import os
import sys

sys.path.insert(0, os.path.abspath('../src/'))

```

## Enable autodoc plugins.
``` python
extensions = [
    'sphinx.ext.autodoc'
]
```

## Enable read-the-doc theme.

``` python
html_theme = 'sphinx_rtd_theme'
```

# Build sphinx docs.
``` bash
make html 	# build the docs by html builder.

open build/html/index.html
```

{% asset_img 001_rtd_default.png Default homepage for rtd theme %}

