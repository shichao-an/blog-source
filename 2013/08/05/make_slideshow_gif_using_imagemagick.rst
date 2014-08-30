Make slideshow GIF from a batch of images using ImageMagick
===========================================================

.. highlight:: shell-session

1. Download and install ImageMagick Mac OS X Binary Release at ImageMagick official site.
   ::

       $ tar xvfz ImageMagick-x86_64-apple-darwin12.4.0.tar.gz
       $ export MAGICK_HOME="/YOUR/PATH/TO/ImageMagick-6.8.6"
       $ export PATH="$MAGICK_HOME/bin:$PATH"
       $ export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

   See this for installation on Linux.

2. Enter the directory where original images are stored (assuming all files are in .jpg format), use the following command::

       $ convert -delay 100 -loop 0 -resize 300x225 -quality 90 *.jpg image.gif

   ``-deplay`` represents interval between slides, ``-loop`` indicates number of loops for slide show (0 for infinite loops); other options are intuitive. Note that \*.jpg will expand to images ordered alphabetically by filename. Use the following command to re-order the images by last modified time::

       $ convert -delay 100 -loop 0 -resize 300x225 -quality 90 `ls -t *.jpg` image.gif


.. author:: default
.. categories:: none
.. tags:: Bash
.. comments::
