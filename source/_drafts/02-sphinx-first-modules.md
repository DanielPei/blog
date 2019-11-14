---
title: "02-sphinx: first module"
author: Daniel
date: 2019-11-13 23:19:04
tags:  
  - python
  - sphinx
categories:
  - python
  - sphinx
---
We will add a module to our sphinx docs in this post.

1. Create a python script.

``` python
# src/op/utils.py

# !/bin/python
# -*- coding:utf-8 -*-

# @Author  : Daniel.Pei
# @Email   : peixq1222@icloud.com
# @Created : 13/11/2019 22:19

class CalOp(object):
    """
        Calculator for nums.

    """
    def __index__(self, num):
        """
            Init CalOp instance.

        :param num: number data.
        :return:
        """
        self.num = num
        pass

    def add_op(self, other):
        """
            Add number data with other.

        :param CalOp other: Another CalOp.
        :return: sum
        :rtype: int
        """
        return self.num + other.num

```

2. Add CalOp class to doc.
Create **source/utils.rst** for our **utils.py**.
``` python
Utils
==================================================

.. automodule:: op.utils
   :members:
```

Add **source/utils.rst** to **index.rst**.
``` python
Welcome to pydoc_demo's documentation!
======================================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   utils.rst

Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

```

3. Build docs.
``` bash
make html

open build/html/index.html
```
**Index page**
{% asset_img 001-index-page.png "Index page"%}

**Module docs**
{% asset_img 002-module-docs.png "Module doc page" %}