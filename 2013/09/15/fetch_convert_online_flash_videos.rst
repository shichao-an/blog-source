Fetch and convert online flash videos
=====================================

.. highlight:: shell-session

1. Installation of prerequisite utilities:

   * Perl module: WWW::Mechanize
   * `get-flash-videos <https://code.google.com/p/get-flash-videos/wiki/Installation>`_
   * `ffmpeg <http://www.ffmpeg.org/download.html>`_
   
   ::

       $ sudo cpan install WWW::Mechanize
       $ git clone https://github.com/monsieurvideo/get-flash-videos.git /path/to/get-flash-videos
       $ ln -s /usr/local/bin/get_flash_videos /path/to/get-flash-videos/get_flash_videos

   For the installation of ffmpeg, see http://www.ffmpeg.org/download.html.

2. Download flash-video-archiver scripts::

    $ git clone https://github.com/moleculea/flash-video-archiver.git flash-video-archiver

3. Create a file of video link list, e.g. videos.txt::

    $ cat /path/to/videos.txt

    http://example.com/video/4438
    http://example.com/video/4512
    http://example.org/video/hjkl

4. Fetch videos and convert them into MP4::

    $ cd flash-video-archiver
    $ ./fetch.sh /path/to/videos.txt /path/to/output/directory
    $ ./convert.sh /path/to/output/directory


.. author:: default
.. categories:: none
.. tags:: Bash,Perl
.. comments::
