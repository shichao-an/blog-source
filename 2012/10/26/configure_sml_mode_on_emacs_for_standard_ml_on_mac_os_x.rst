Configure SML mode on Emacs for Standard ML on Mac OS X
=======================================================

.. highlight:: common-lisp

.. |s1| image:: Screen-Shot-2012-10-26-at-1.52.20-AM.png
   :width: 450px
.. |s2| image:: Emacs_SML_up.png
   :width: 450px

Before start, we have to make sure the Emacs For Mac OS X has been installed, which can be retrieved at `emacsformacosx.com <http://emacsformacosx.com/>`_.

1. Download the lastest distribution (110.75 as of posting date) of SML .dmg file from `this working site <http://smlnj.cs.uchicago.edu/dist/working/110.75/index.html>`_, and then install it.

2. Download the latest Emacs Lisp package for SML mode from `this site <http://www.iro.umontreal.ca/~monnier/elisp/>`_, which should be sml-mode-5.0.tar.gz at the time. Double-click the downloaded file and make it folder, and place the folder anywhere you like.

3. Open terminal, create a file named ``.emacs`` at your user folder. Add the following lines of Lisp in the file::

       (setq load-path (cons "/path/to/sml-mode-5.0" load-path))
       (load "sml-mode-startup")

   ``/path/to/sml-mode-5.0`` indicates the path to SML mode package downloaded in Step 2.

   As the installation in Step 1 makes binary file of SML/NJ compiler placed at ``/usr/local/smlnj-110.75/bin``, then you have to append the following lines into ``.emacs``::

       (setenv "PATH" (concat "/usr/local/smlnj-110.75/bin:" (getenv "PATH")))
       (setq exec-path (cons "/usr/local/smlnj-110.75/bin"  exec-path))

4. Configuration done.

   Open Emacs, type *M-x* run-sml, a buffer should appear with "Standard ML of New Jersey" compiler info listed. You can now input and run ML code.
   
   |s1|

   To edit a file in SML, create a new file using *C-x C-f* with .sml extension, or create a file with whatever extension and type *M-x* sml-mode. Then the minibuffer region will become SML rather than Fundamental, and the syntax will be highlighted.

   |s2|

.. author:: default
.. categories:: none
.. tags:: SML,Emacs
.. comments::
