Get the inode birth time (crtime or btime) of a file on Mac OS X and BSD descendants
====================================================================================

.. highlight:: shell-session

::

    $ stat -f "%SB %N" filename.txt
    Jul 11 22:27:33 2013 filename.txt

According to the man page, ``-f`` is used to display information using the specified format. ``S`` is an optional output format specifier that represents a string output, and ``B`` is a required field specifier that represent the birth time of the inode. ``N`` represents the file name.

.. author:: default
.. categories:: none
.. tags:: OS X,BSD
.. comments::
