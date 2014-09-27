su, sudo, and environment
=========================

1. **sudo -i**

   ``sudo -i [command]``
   If command is omitted, it spawns a login shell of the target user (usually root) modifying the environment. Otherwise, the command is passed to the shell for execution.

2. **sudo -s**

   ``sudo -s [command]``

   If command is omitted, it spawns spawns a login shell of the target user (usually root) without modifying the environment. Otherwise, the command is passed to the shell for execution.

   This command is useful if you want to keep the environment variables (such as ``HISTFILE`` for history) when executing sudo. Use ``env`` or ``declare`` to see the environment.

   Note that if ``always_set_home`` is enabled in ``/etc/sudoers`` (with a line ``Defaults always_set_home``), after you execute ``sudo -s``, the ``HOME`` will be changed to the homedir of the target user, as if you execute ``sudo -sH``.

3. **sudo bash -c**

   ``sudo bash -c 'command string'``

   As a regular user, the following command will fail:

   ``sudo ls > /root/ls.txt``

   Because although the shell that sudo spawns executes ls with root privileges, the non-privileged shell that the user is running redirects the output.

   As a solution, use the following command:

   ``sudo bash -c 'ls > /root/ls.txt'``

   ``bash -c`` spawns a shell that executes the string following the option and then terminates. The sudo utility runs the spawned shell with root privileges (without modifying environment).

4. **su -c**

   ``su -c 'command string'``

   Similar to the previous one, ``su -c`` runs a command with root privileges and returna to original shell after execution.

   For example,

   ``su -c 'ls > /root/ls.txt'``

   In conclusion, 1, 2 and 3 uses sudo utility to execute single commands and have the advantage of not requiring root password.

Reference:

Mark G. Sobell. A Practical Guide to Ubuntu Linux, Third Edition. 2010

.. author:: default
.. categories:: none
.. tags:: Unix,Linux
.. comments::
