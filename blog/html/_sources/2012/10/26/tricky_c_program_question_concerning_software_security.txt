Tricky C program question concerning software security
======================================================

.. highlight:: c

While the software security exam is coming, I try to review some of the facultative homework. Just post one that seems impossible to figure out for me. May some "Da Niu" try to give a solution when seeing this by chance. The code has been modified a little in case… but without changing the original intention.

::

    #include <stdio.h>
    #include <stdlib.h>
     
    void foo(char s[]){
        scanf("%s",s);
    }
    int main(){
        char S[1];
        foo(S);
        exit(0);
        printf("\nsomething shows up after exit");
    }

The question is to find an input in order that the program will print "something shows up after exit". What the hell is that?

.. author:: default
.. categories:: none
.. tags:: C
.. comments::
