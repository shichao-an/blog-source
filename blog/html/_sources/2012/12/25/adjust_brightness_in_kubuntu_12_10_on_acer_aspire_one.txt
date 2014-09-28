Adjust brightness in Kubuntu 12.10 on Acer Aspire One
=====================================================

.. highlight:: shell-session

Fn-Left and Fn-Right do not work to change brightness.

Find the answer here: http://askubuntu.com/questions/112050/acer-aspire-one-d270-can-not-set-brightness

Modify grub config file::

    $ sudo vi /etc/default/grub

Change the line::

    GRUB_CMDLINE_LINUX=""

into::

    GRUB_CMDLINE_LINUX="acpi_osi=Linux"

Then, update grub::

    $ sudo update-grub

Reboot

.. author:: default
.. categories:: none
.. tags:: Ubuntu
.. comments::
