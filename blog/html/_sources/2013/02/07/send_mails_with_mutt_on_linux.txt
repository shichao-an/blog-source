Send mails with mutt on Linux
=============================

.. highlight:: shell-session

Given that the sendmail MTA is in use on Linux.

Install mutt::

    # yum install mutt
    # vi ~/.muttrc

.. highlight:: text

Append the following into ``.muttrc``::

    set sendmail="/usr/sbin/sendmail"
    set use_from=yes
    set realname="webmaster"
    set from=no-replay@example.com
    set envelope_from=yes

.. highlight:: shell-session

Send email::

    # echo "CONTENT" | mutt -s "SUBJECT" -a /path/to/attachment.zip receiver@example.com

.. author:: default
.. categories:: none
.. tags:: Linux
.. comments::
