Loop statements in Perl
=======================

.. highlight:: perl

Loop statement in Perl seems to conform to the TMTOWTDI or "There's more than one way to do it" philosophy.

The contents below is copied from Chinese Wikipedia article.

Define an array group and we have the following loop statements which perform the same thing::

    @group = 1 .. 10;
    for (@group) {
        print "$_\n";
    }
    print "$_\n" for @group;
    foreach (@group) {
        print "$_\n";
    }

for, which is borrowed from C::

    for ($i = 0; $i < 10; $i++) {
        print "$group[$i]\n";
    }

while::

    $i=0;
    while ($i < 10) {
        print "$group[$i]\n";
        $i++;
    }

do…while::

    $i = 0;
    do {
        print "$group[$i]\n";
        $i++;
    } while ($i < 10);

until::

    $i = 0;
    until ($i == 10) {
        print "$group[$i]\n";
        $i++;
    }

do…until, borrowed from PASCAL::

    $i = 0;
    do {
        print "$group[$i]\n";
        $i++;
    } until ($i == 10);

map, some kind of functional::

    map { print "$_\n" } @group;

.. author:: default
.. categories:: none
.. tags:: Perl
.. comments::
