Bash double brackets, test contructs and word splitting
=======================================================

We know that the double brackets constructs can be used in place of the ``test`` builtin (``[``) commonly used as single brackets to evaluate conditional expression. The double brackets are preferred in terms of writing less error-prone scripts, though it is not POSIX-compliant (not portable to many other shells).

The primary difference of double brackets from test builtin is that word splitting and filename expansion are not performed within them. It is easier to understand filename expansion difference in this case, let's take a look at the difference of word splitting.

1. First, the following command fails because in test constructs the world splitting is performed after parameter expansion (and variable expansion, if any)::

    $ bash -xc 'foobar="hello world"; [ $foobar = "hello world" ] && echo "yes"'
    + '[' hello world = 'hello world' ']'
    bash: line 0: [: too many arguments

2. In the double brackes, the error will not occur because word splitting is not performed, like the following::

    $ bash -xc 'foobar="hello world"; [[ $foobar = "hello world" ]] && echo "yes"'
    + foobar='hello world'
    + [[ hello world = \h\e\l\l\o\ \w\o\r\l\d ]]
    + echo yes
    yes

3. We can supress word splitting in the ``test`` construct by setting IFS to null. This time, this command will succeed::

    $ bash -xc 'IFS=""; foobar="hello world"; [ $foobar = "hello world" ] && echo "yes"'
    + IFS=
    + foobar='hello world'
    + '[' 'hello world' = 'hello world' ']'
    + echo yes
    yes

4. Another feature to note is that double brackets treat unset variables and null variable (variable whose value is a null string, i.e. '')  differently from the ``test`` construct. For example::
    $ bash -xc 'IFS=""; foobar=""; [ $foobar = "hello world" ] && echo "yes"'
    + IFS=
    + foobar=
    + '[' = 'hello world' ']'
    $ bash -xc 'IFS=""; foobar=""; [[ $foobar = "hello world" ]] && echo "yes"'
    + IFS=
    + foobar=
    + [[ '' = \h\e\l\l\o\ \w\o\r\l\d ]]

The unset or null variable is converted to null argument ('') as a result in double brackets, while in test constructs it is removed.

5. You may notice in the second step above that the xtrace output of the conditional expression to the right of the operator is "\h\e\l\l\o\ \w\o\r\l\d". This is because when using operators ``==``, ``!=`` and the POSIX version ``=``, the string to the right is considered a pattern and pattern matching will be performed. The backslash indicates the each character is literal instead of pattern, because "hello world" is quoted. The following example makes the right string as pattern::

    $ bash -xc 'IFS=""; foobar="hello world"; [[ $foobar = hello* ]] && echo "yes"'
    + IFS=
    + foobar='hello world'
    + [[ hello world = hello* ]]
    + echo yes
    yes


.. author:: default
.. categories:: none
.. tags:: Bash 
.. comments::
