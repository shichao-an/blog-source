Wake and suspend machines on local Ethernet LAN
===============================================

.. highlight:: shell-session

Suppose you have a spare PC (say A) that supports Wake-on-LAN, you can first enable it by following `this guide <http://www.cyberciti.biz/tips/linux-send-wake-on-lan-wol-magic-packets.html>`_. Then you can hack on some scripts on other local machines connected through Ethernet to remotely control A to make it suspend/hibernate and wake up as you want.

Wake
----

To wake up A is simple. Suppose A's MAC address is 11:aa:22:bb:33:cc and the hostname is "machine-a", and you want to wake it up from other machines (e.g. Machine B) on LAN, first install the wakeonlan utility (on Machine B).


On Debian/Ubuntu::

    $ sudo apt-get install etherwake

or::

    $ sudo apt-get install wakeonlan


On Fedora/RHEL::

    $ sudo apt-get install net-tools

On OS X::

    $ brew install wakeonlan

To send magic Wake-on-LAN packets to A::

    $ etherwake 11:aa:22:bb:33:cc

or::

    $ ether-wake 11:aa:22:bb:33:cc

or::

    $ wakeonlan 11:aa:22:bb:33:cc

Suspend/hibernate
-----------------

.. more::

1. Configure static IP for Machine A, for example 192.168.0.201.
2. Edit /etc/hosts on Machine B by adding the following line::

    192.168.0.201   machine-a

3. Setup SSH server on Machine A.
4. Create a user account (say "yourname") on Machine A for SSH login
5. Configure public and private keys for SSH login without password
6. Install pm-utils on Machine A.
7. Edit /etc/sudoers on Machine A to add the following line::

    yourname ALL=(root)      PASSWD:ALL, NOPASSWD: /usr/sbin/pm-suspend

6. Install GNU Screen on A.

Then, you can use the following script suspend_machine_a.sh on Machine B to remote suspend Machine A:

.. code-block:: shell

    #!/bin/bash
     
     
    session_name="suspend"
    ssh yourname@machine-a "if screen -list | grep -E '\<[0-9]+\.$session_name\>' >/dev/null;
    then echo -n ''; else screen -dmS $session_name; fi"
    ssh -t yourname@machine-a "screen -S $session_name -p 0 -X stuff 'sudo pm-suspend
    '
    "

To use hibernate, substitute ``pm-hibernate`` for ``pm-suspend``.

Finally, you can make some shortcut aliases so that suspend/wake of Machine A can be done by a single command.


.. author:: default
.. categories:: none
.. tags:: OS X,Linux,Network
.. comments::
