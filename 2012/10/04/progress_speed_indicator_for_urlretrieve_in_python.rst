Progress/speed indicator for urlretrieve() in Python
====================================================


.. |s1| image:: Screen-Shot-2012-10-26-at-2.56.57-AM.png

.. highlight:: python


A simple ``reporthook()`` function for :py:func:`urllib.urlretrieve`'s reporthook argument::

    import sys
    import time
    import urllib
     
     
    def reporthook(count, block_size, total_size):
        global start_time
        if count == 0:
            start_time = time.time()
            return
        duration = time.time() - start_time
        progress_size = int(count * block_size)
        speed = int(progress_size / (1024 * duration))
        percent = int(count * block_size * 100 / total_size)
        sys.stdout.write("\r...%d%%, %d MB, %d KB/s, %d seconds passed" %
                        (percent, progress_size / (1024 * 1024), speed, duration))
        sys.stdout.flush()
     
    def save(url, filename):
        urllib.urlretrieve(url, filename, reporthook)

After writing ``__main__`` and designating url as well as filename for the sample file ``urlre.py``, we can run it and see the effect.

|s1|

**UPDATE**

As suggested by Naquada, to avoid thing like "106%" and so on, percent should be defined as ``percent = min(int(count*blockSize*100/totalSize),100)``.

.. author:: default
.. categories:: none
.. tags:: Python
.. comments::
