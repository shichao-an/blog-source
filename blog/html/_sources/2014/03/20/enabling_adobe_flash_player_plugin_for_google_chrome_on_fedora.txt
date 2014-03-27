Enabling Adobe Flash Player plugin for Google Chrome on Fedora
==============================================================

.. highlight:: shell-session

The Google Chrome browser I use was installed from the third-party repository by Google. The default Pepper Flash Player plugin (version 12.0) does not support some websites (such as `www.bilibili.tv <http://www.bilibili.tv>`_). I have to install the Adobe Flash Player plugin and enable it for Google Chrome.

1. Install the repository from Adobe (assuming 64-bit):
::

    # yum install http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
    # rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux

2. Install the flash-plugin package:
::

    # yum install flash-plugin 

3. Create symbolic link at Google Chrome's default directory:
::

    # ln -s /usr/lib64/mozilla/plugins/libflashplayer.so /opt/google/chrome/libflashplayer.so

4. Restart Google Chrome, go to "about:plugins" page, toggle "Details" switch at upper right corner, disable PepperFlash plugin and enable the Adobe Flash Player plugin with location "/usr/lib64/flash-plugin/libflashplayer.so"


.. author:: default
.. categories:: none
.. tags:: Linux,Fedora 
.. comments::

