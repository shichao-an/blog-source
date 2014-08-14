Use Artistic Style with vim
===========================

.. highlight:: shell-session

Artistic Style is a "Free, Fast and Small Automatic Formatter for C, C++, C++/CLI, C#, and Java Source Code". It is basically a utility that reformats source code in a conventionally-defined indent and coding style.

First, install the program.

On Ubuntu/Debian::

    $ sudo apt-get install astyle

On OS X (with Homebrew)::

    $ brew install astyle

In order to use the command in a simple manner, you can set options in the options file `~/.astylerc`. I use the following options that uses Kernighan & Ritchie (K&R) style. For more supported styles and options, see http://astyle.sourceforge.net/astyle.html.

::

    --style=kr
    --indent=spaces=4
    --indent-preprocessor
    --pad-oper
    --pad-header
    --max-instatement-indent=40
    --align-pointer=name
    --align-reference=name
    --keep-one-line-statements
    --convert-tabs
    --max-code-length=79
    --pad-method-colon=none

Open vim, gVim or MacVim, and after editing some C/C++ files, use the following command to reformat the source code::

    :%!astyle
