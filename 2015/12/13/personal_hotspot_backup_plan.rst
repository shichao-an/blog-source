Personal Hotspot Backup Plan
============================

Although I have bought two ISPs for Internet access at home and have set up a dual WAN router to use them, it often sucks at busy nights when both ISPs churn me up with an over 80% packet loss for several hours due to a range of crappy outbound nodes of AT&T. These can be easily observed with ``mtr`` and ``ping``. In short, I simply cannot use the Internet with a normal mood.

Therefore, I decided to make use of the LTE network of my iPhone via personal hotspot. The problem is to connect to the hotspot from my primary MacBook Pro (named ASC-MBP) while maintaining access to existing home network (named TOKI-MASTER), since I need accessing the NAS. The obvious way is to hack the routing table, so I wrote the following two scripts, along with a backup plan.

* `switch-default-route <https://gist.github.com/shichao-an/5be6baa2c6ebc2191ad7#file-switch-default-route>`_
* `restore-default-route <https://gist.github.com/shichao-an/5be6baa2c6ebc2191ad7#file-restore-default-route>`_

When Internet (both ISP) are down or unstable, do the following:

On ASC-MBP, where Ethernet is plugged to TOKI-MASTER (10.0.1.1):

1. On iPhone 6, turn on Personal Hotspot
2. On ASC-MBP, turn on Wi-Fi, and connect to ASC-IPHONE6
3. On ASC-MBP, run command "switch-default-route"
4. If Internet is back up, turn off Wi-Fi, run command "restore-default-route"

By default, the iPhone Hotspot's gateway address is 172.20.10.1, which is why it is in the script.

.. author:: default
.. categories:: none
.. tags:: OS X,Network
.. comments::
