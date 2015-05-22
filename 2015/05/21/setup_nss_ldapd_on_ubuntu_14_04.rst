Setup nss-ldapd on Ubuntu 14.04
===============================

The last few posts discussed `setting up an OpenLDAP server <../../04/17/setup_openldap_server_with_openssh_lpk_on_ubuntu>`_ and `configuring basic client server <../../04/19/setup_openldap_client_server_with_ssh_access_on_ubuntu>`_. However, that client server uses `nss-ldap <http://packages.ubuntu.com/trusty/libnss-ldap>`_ with some known issues `as presented here <https://wiki.debian.org/LDAP/NSS#Configuring_LDAP_Authentication>`_.  With this old and seemingly buggy setup, I simply can't make `nss_initgroups_ignoreuses` option work to bypass querying the LDAP server when authenticating local or system users on the server, and have no idea what ``nssldap-update-ignoreusers`` command actually does. When the LDAP server is down or there is network issues connecting the LDAP server, the default configuration will simply block local users from logging in the server (at least for a long time until the query is considered timed out). Also, as I found after checking ``/var/log/auth.log``, it queries the LDAP server even when doing a Bash completion, because it was very slow when I pressed the TAB key after a path name. Setting `bind_policy` option to soft and  `timelimit` and `bind_timelimit` to smaller values may just alleviate the symptom but does not solve the problem.

So I decide to use nss-ldapd that comes with the ``libnss-ldapd`` package.

::

    apt-get install libpam-ldap nscd ldap-utils libnss-ldapd


Running the above command will automatically remove the ``libnss-ldap`` package and prompts an interacive post-install steps for you to setup the LDAP parameters. You can disable this interactive behavior and directly place your config in ``/etc/nslcd.conf`` with the following command:


::

    export DEBIAN_FRONTEND=noninteractive
    apt-get -y install libpam-ldap nscd ldap-utils libnss-ldapd

Then, put your config in ``/etc/nslcd.conf``:

::

    uid nslcd
    gid nslcd
    uri ldaps://ldap.example.com
    base dc=example,dc=com
    binddn cn=OpenLDAP Client,ou=users,dc=example,dc=com
    bindpw password
    tls_reqcert never
    nss_initgroups_ignoreusers ALLLOCAL
 
The last line ``nss_initgroups_ignoreusers ALLLOCAL`` prevents group membership lookups through LDAP for all local users.

The other settings for PAM, sudoers and access.conf are essentially the same as the old nss-ldap setup. Just make sure to restart the LDAP nameservice daemon, nslcd, after making changes to ``/etc/nslcd.conf``.

::

    service nslcd restart

If nscd cache daemon is also enabled and you make some changes to the user from the LDAP, you may want to clear the cache:

::

    nscd --invalidate=passwd
    nscd --invalidate=group

The nslcd daemon also has the advantage that it can be easily stopped in order to temporarily disable the LDAP lookup. This makes the management of LDAP access more easy.

Finally, here is the setup script:

* `setup-nss-ldapd.sh <https://gist.github.com/shichao-an/0e7fe33cc540797e3ee0>`_

.. author:: default
.. categories:: none
.. tags:: OpenLDAP,Ubuntu
.. comments::
