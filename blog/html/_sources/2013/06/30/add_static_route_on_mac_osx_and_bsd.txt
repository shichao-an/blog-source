Add static routes on Mac OS X and BSD descendants
=================================================

.. highlight:: shell-session

Add a static route::

    # route -n add -net 192.168.122.0/24  192.168.0.117

This is equivalent to the Linux command::

    # route add -net 192.168.122.0 netmask 255.255.255.0 gw 192.168.0.117

List routing tables::

    # netstat -r

.. author:: default
.. categories:: none
.. tags:: OS X,BSD,Network
.. comments::
