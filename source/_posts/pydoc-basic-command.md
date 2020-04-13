---
title: pydoc-basic-command
author: Daniel
tags:
  - python
  - pydoc
categories:
  - - python
    - pydoc
date: 2019-11-05 22:43:09
---
This is a post

Pydoc can be used to access the doc for python modules or classes easily. We will show the basic command for the pydoc.

<!-- more -->

1. **Show help for pydoc**
``` bash
pydoc -h

pydoc - the Python documentation tool

pydoc <name> ...
    Show text documentation on something.  <name> may be the name of a
    Python keyword, topic, function, module, or package, or a dotted
    reference to a class or function within a module or module in a
    package.  If <name> contains a '/', it is used as the path to a
    Python source file to document. If name is 'keywords', 'topics',
    or 'modules', a listing of these things is displayed.

pydoc -k <keyword>
    Search for a keyword in the synopsis lines of all available modules.

pydoc -p <port>
    Start an HTTP server on the given port on the local machine.  Port
    number 0 can be used to get an arbitrary unused port.

pydoc -g
    Pop up a graphical interface for finding and serving documentation.

pydoc -w <name> ...
    Write out the HTML documentation for a module to a file in the current
    directory.  If <name> contains a '/', it is treated as a filename; if
    it names a directory, documentation is written for all the contents.


```

2. **Show document for a python module.**
``` bash
python -m pydoc pow

Help on built-in function pow in module __builtin__:

pow(...)
    pow(x, y[, z]) -> number

    With two arguments, equivalent to x**y.  With three arguments,
    equivalent to (x**y) % z, but may be more efficient (e.g. for longs).
```

3. **Search python modules with specific keyword**
``` bash
# Find python modules which name contains "json"
python -m pydoc -k json

json - JSON (JavaScript Object Notation) <http://json.org> is a subset of
json.decoder - Implementation of JSONDecoder
json.encoder - Implementation of JSONEncoder
json.scanner - JSON token scanner
json.tests
```

4. **Start an HTTP server for pydoc on the given port**
``` bash
python -m pydoc -p 4000
# Open the browser and visit "http://localhost:4000" to view the documents for all your local python modules.
```


5. **Start an HTTP server for pydoc on a free port**
``` bash
python -m pydoc -g
```

6. **Write out the HTML documentation for a module**
``` bash
python -m pydoc -w json
# We will get json.html in current folder.
```