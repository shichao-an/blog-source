Using Bash arrays and IFS to manipulate filenames
=================================================

.. highlight:: shell-session

Assume we want to work with files in a directory. The most intuitive way is to make use of filename expansion, using globbing. We can use the `for construct` and wildcard ``*`` to handle each file nice and clean, without worrying about those filenames that contain whitespaces (suppose that in all of the following context, the working directory contain three files: "Foo", "Bar", and "Foo Bar")::

    $ for file in *; do echo "$file"; done

We can also create an array from these filenames, using the following command::

    $ files=(*)

Then, we can take a look at both the attributes and the value of `files`::
    
    $ declare -p files
    declare -a files='([0]="Bar" [1]="Foo" [2]="Foo Bar")'

What if we want to create an array with specific orders, say by modification time (`mtime`) of files. We have to use the ``ls`` with the ``-t`` switch.  Now there are several practical scenarios discussed as follows.

1. Get the latest modified filename::
    
    $ filename=$(ls -t | head -1)

2. Create an array of filenames ordered by their `mtime`. Clearly, globbing will not work because it is based on filename pattern matching. We have to use both command substitution and word splitting. Let's try the following first::

    $ filenames=($(ls -t))
    declare -a filenames='([0]="Foo" [1]="Bar" [2]="Bar" [3]="Foo")'

   Clearly this is not the result we want since the whitespace-contained filename is corrupted.
  
   We need to hack a little on IFS variable. Let's try what happens if we disable word splitting by setting IFS to null::

    $ IFS=
    $ filenames=($(ls -t))
    declare -a filenames='([0]="Foo Bar
    Bar
    Foo")'

   It seems it's getting worse this time. Since word splitting is not performed, the result of command substitution becomes an single word.

   We know that the result of ``ls`` command is multiple lines of filenames. As the result of command substitution (i.e. ``$(ls -t)``), the filenames are separated by newlines (``\n``). The default IFS is a sequence of ``\t\n`` (space, tab and newline), which means each of these characters will be used to delimit words. Here we need to suppress the effect of space; just set IFS to newline character (``\n``) (as long as your filenames does not contain newlines), with ANSI C quoting (``$''``)::

    $ IFS=$'\n'
    $ filenames=($(ls -t))
    $ declare -p filenames
    declare -a filenames='([0]="Foo Bar" [1]="Bar" [2]="Foo")'

   In similar ways, we can get `n` most recently modified filenames, just make use of parameter expansion::

    $ echo "${filenames[@]:0:2}"  # Print two most recently modified names


.. author:: default
.. categories:: none
.. tags:: Bash
.. comments::
