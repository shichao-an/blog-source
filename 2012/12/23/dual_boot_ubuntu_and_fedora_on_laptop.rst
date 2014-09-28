Dual boot Ubuntu and Fedora on laptop
=====================================

.. highlight:: shell-session

Install Ubuntu 12.10 first and then Fedora 17 on the laptop using USB media.

1. Install Ubuntu 12.10 with some free space unallocated
2. Install Fedora 17 in a new partition in the free space
3. Restart and boot Ubuntu, install lvm for Fedora and update grub::

       $ sudo apt-get install lvm2
       $ sudo mount /dev/sdaN /mnt
       $ sudo update-grub

   (/dev/sdaN is the partition for Fedora for the only mount point /)

4. Reboot

.. author:: default
.. categories:: none
.. tags:: Ubuntu,Fedora
.. comments::
