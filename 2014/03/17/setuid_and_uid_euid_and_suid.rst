setuid() and uid, euid and suid
===============================

.. highlight:: shell-session


We know that `setuid` bit allows a program to change its effective uid (euid) upon execution. I want to take a look at how `setuid()` system call works through the following experiment.

Open a terminal session and run the ``passwd`` command (a known `setuid` executable) in the background (it will be suspended with a "[stopped]" output because it requires password from stdin) and get its PID (let's assume it's 10401) with ``echo $!``:
::

    $ passwd &
    $ echo $!  # 10401

Then, run ``gdb`` to attach to this process:
::

    $ sudo gdb -p $!

Open another terminal, the run the following command to get the line that represents the current real UID (`uid`), effective UID (`euid`), saved UID (`suid`) and file system UID (`fsuid`) of the previous ``passwd`` process:
::

    $ watch -n 1 grep -i 'uid' /proc/10401/task/10401/status
    Uid:    1000    0       0	0

In the first terminal, you can call `seteuid(1000)` to change its `euid` to 1000:
::

    (gdb) call seteuid(1000)
    $1 = 0

Then the output of the ``watch`` command will become:
::

    Uid:    1000    1000    0	1000

As you see the `euid` is 1000 and the process becomes unprivileged. With the following command, you will notice that the USER field has been changed to the regular user instead of root:
::

    $ ps -u -p 10401

At this time, you can only change its effective UID to either that of the real UID or the saved UID (1000 or 0). You can also use `setresuid(u,e,s)` to change them at the same time. 

To revert the `euid` back to 0, you can use either `setuid(0)` or `seteuid(0)`. This is because when `euid` is not 0, the `setuid(e)` system call will only modify `euid` and `fsuid` to `e` leaving the other two unchanged::

    (gdb) call setuid(0)
    $2 = 0

At this time, when `euid` is 0, if you call `setuid(1000)` it will sets all the four fields to 1000 and the process will be permanently unprivileged. Further calls to `setuid` to change any field to other than 1000 will fail.
::

    (gdb) call setuid(1000)
    $3 = 0
    (gdb) call setuid(0)
    $4 = -1
    (gdb) detach
    Detaching from program: /usr/bin/passwd, process 10401
    (gdb) quit

.. author:: default
.. categories:: none
.. tags:: Linux,GDB 
.. comments::
