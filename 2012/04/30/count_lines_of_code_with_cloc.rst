代码行统计工具 CLOC
===================

.. highlight:: shell-session

Count Lines of Code (CLOC): http://cloc.sourceforge.net/

下载 Perl 脚本 cloc-1.56.pl 即可使用。

::

    $ perl cloc-1.56.pl /var/local/pywikipedia/
         290 text files.
         273 unique files.
          42 files ignored.
     
    http://cloc.sourceforge.net v 1.56  T=2.0 s (124.5 files/s, 50462.5 lines/s)
    --------------------------------------------------------------------------------
    Language                      files          blank        comment           code
    --------------------------------------------------------------------------------
    Python                          245           9139          18658          72906
    XML                               2             16              0            194
    Bourne Again Shell                1              0              5              6
    Bourne Shell                      1              0              0              1
    --------------------------------------------------------------------------------
    SUM:                            249           9155          18663          73107
    --------------------------------------------------------------------------------

.. author:: default
.. categories:: none
.. tags:: Linux,Perl
.. comments::
