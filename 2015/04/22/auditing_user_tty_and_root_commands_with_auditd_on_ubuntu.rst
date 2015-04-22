Auditing user TTY and root commands with auditd on Ubuntu
=========================================================

``auditd`` can be used to track user commands executed in a TTY. If the system is a server and the user logins through SSH, the ``pam_tty_audit`` PAM module must be enabled in the PAM configuration for sshd (the following line must appear in ``/etc/pam.d/sshd``):

::

    session required pam_tty_audit.so enable=*

Then, the audit report can be reviewed using the ``aureport`` command, e.g. tty keystrokes:

.. highlight:: shell-session

::

    # aureport --tty


However, the above setup cannot audit users that switch to root using the ``sudo su -`` command. In order to audit all commands run by root, `as referenced here <http://serverfault.com/questions/470755/log-all-commands-run-by-admins-on-production-servers>`_, the following two lines must be added to ``/etc/audit/audit.rules``:


.. highlight:: text

::

    -a exit,always -F arch=b64 -F euid=0 -S execve
    -a exit,always -F arch=b32 -F euid=0 -S execve

And also make sure ``pam_loginuid.so`` is enabled in ``/etc/pam.d/sshd`` (default in Ubuntu 14.04).

In this way, all processes with euid 0 will be audited and their auid (audit user id, which represents the real user before ``su``) will be preserved in the log. To check the audit log, for example about a user with uid 1000, the following command can be used:

::

    ausearch -ua 1000


The ``audit.log`` file is located at ``/var/log/audit``.

Note that before auditing takes effect, the system needs reboot after either installing the ``auditd`` package or editing these configuration files. All above were tested on Ubuntu 14.04. Here is a script that can set all these up:

* `setup-audit.sh <https://gist.github.com/shichao-an/f019f7b9ab51c271ad49>`_


.. author:: default
.. categories:: none
.. tags:: Ubuntu,auditd
.. comments::
