---
title: sphinx-basic
author: Daniel
date: 2019-11-06 22:09:26
tags: [ python, sphinx]
categories:
- [ python, sphinx ]
---

``` bash
pip install sphinx

mkdir my_modules
cd my_modules

mkdir scripts rst html

sphinx-quickstart 
# choose what you need.
# For *autodoc* section, choose yes.

```

``` python
# conf.py
sys.path.append("/path/to/your/script_root")	# add this line
```

``` bash
make html
open build/html/index.html

sphinx-apidoc -o /root/sphinx/rst/ /root/sphinx/scripts
cp /root/sphinx/rst/modules.rst index.rst

sphinx-build -b html /root/sphinx/rst /root/sphinx/html
```

``` rst

```