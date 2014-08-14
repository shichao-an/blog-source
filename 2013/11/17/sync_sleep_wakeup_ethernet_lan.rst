Synchronize sleep and wakeup of machines on Ethernet LAN from Mac using SleepWatcher
====================================================================================

The :doc:`previous post </2013/11/10/wake_suspend_machines_local_ethernet>` discusses remote suspend (sleep) and wakeup of machines on Ethernet LAN using pm-utils, GNU Screen and Wake-on-LAN (LAN). This post will discuss the synchronization of such behaviors of local and remote machines.

Suppose you are regularly working at home on a Mac (either MacBook or Mac mini or something else), and you have a spare PC running as an alternative to NAS or workstation on the same Ethernet LAN. If the spare PC is Linux, you may have set up netatalk on it to enable AFP file sharing or use it as a Time Capsule. However, since it is probably a netbook and may work only when your Mac is up, you don't want it to run all days without doing anything. You can thus synchronize sleep and wakeup of your Mac with that PC.

You can download and install SleepWatcher to monitor sleep and wakeup on Mac and write some scripts upon these events.

1. Download `SleepWatcher <http://www.bernhard-baehr.de/sleepwatcher_2.2.tgz>`_ (version 2.2 as of writing)
2. Install it following the ReadMe.rtf instructions
3. After the SleepWatcher LaunchAgent or LaunchDaemon is loaded, run the following commands to add sleep and wakeup scripts::

    $ echo "/path/to/your/sleep_script.sh" > ~/.sleep
    $ echo "sleep 5; /path/to/your/wakeup_script.sh" > ~/.wakeup
    $ chmod +x ~/.sleep ~/.wakeup

``/path/to/your/sleep_script.sh`` and ``/path/to/your/wakeup_script.sh`` are scripts to suspend and wakeup the remote machine (reference the previous post). ``sleep 5`` performs a delay to make sure the network is up to avoid "send : No route to host" error.
4. Test the setup by sleeping and waking up your Mac and check whether the remote machine does the same


.. author:: default
.. categories:: none
.. tags:: OS X,Network
.. comments::
