Setup OpenLDAP client server with SSH access on Ubuntu 14.04
============================================================

This post documents how to setup an OpenLDAP client server (Ubuntu 14.04) that can make its OpenSSH server to load authorized keys from a pre-configured OpenLDAP server with ``ldaps://`` available (discussed in the :doc:`previous post <../17/setup_openldap_server_with_openssh_lpk_on_ubuntu>`, please read this first if you haven't). Users are able to SSH access this client server, while their SSH public keys are stored on the OpenLDAP server. The SSH authentication process on the client server is mainly facilitated by `ssh-ldap-pubkey <https://github.com/jirutka/ssh-ldap-pubkey>`_.

Script
~~~~~~

-  `setup-ldap-client.sh <https://gist.github.com/shichao-an/9005314e10e9a8ffa865>`_


Install packages
~~~~~~~~~~~~~~~~

::

    apt-get -y install libpam-ldap nscd ldap-utils
    apt-get -y install python-pip python-ldap
    # https://github.com/jirutka/ssh-ldap-pubkey
    pip install ssh-ldap-pubkey

Configure SSH server
~~~~~~~~~~~~~~~~~~~~

-  Add the following lines to ``/etc/ssh/sshd_config``:

   ::

       AuthorizedKeysCommand /usr/local/bin/ssh-ldap-pubkey-wrapper
       AuthorizedKeysCommandUser nobody

-  Restart SSH server

   ::

       service ssh restart

Configure PAM
~~~~~~~~~~~~~

-  Edit ``/etc/ldap.conf``:

   ::

       uri ldaps://ldap.example.com
       binddn cn=OpenLDAP Client,ou=users,dc=example,dc=com
       bindpw password

-  Edit ``/etc/pam.d/common-auth`` and add the following line:

   ::

       account required    pam_access.so

-  Edit ``/etc/pam.d/common-password`` and remove ``use_authtok``
   parameter
-  Edit ``/etc/pam.d/common-session`` and add the following line:

   ::

       session required    pam_mkhomedir.so skel=/etc/skel umask=0022

Configure NSS, login access control and sudo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Edit ``/etc/nsswitch.conf``:

   ::

       passwd:         compat ldap
       group:          compat ldap
       shadow:         compat ldap

-  Edit ``/etc/security/access.conf``, replace ``ldap-team`` with actual
   group name:

   ::

       - : ALL EXCEPT root (admin) (wheel) (ldap-team): ALL EXCEPT LOCAL

-  Edit ``/etc/sudoers`` using ``visudo`` command and add the following
   lines. Replace ``ldap-team`` with actual group name:

   ::

       %ldap-team ALL=(ALL) ALL

-  Restart nscd

   ::

       service nscd restart


.. author:: default
.. categories:: none
.. tags:: none
.. comments::
