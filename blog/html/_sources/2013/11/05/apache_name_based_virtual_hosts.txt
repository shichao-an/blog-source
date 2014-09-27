Apache name-based virtual hosts and reverse DNS
===============================================

On some operating systems such as Ubuntu, you can setup virtual hosts quite easily with the default Apache server (installed with APT). The global configuration file /etc/apache2/apache2.conf contains the following line as the last line by default:

.. code-block:: apache

    Include sites-enabled/

This means all virtual hosts configurations are loaded from the /etc/apache2/sites-enabled directory in alphabetical order. If you list this directory, you will find there is already a symbolic link 000-default that points to /etc/apache2/sites-available/default. This default virtual host configuration file does not contain a ``ServerName`` directive, and neither does the global configuration file (/etc/apache2/apache2.conf) by default. The default port.conf contains the following line:

.. code-block:: apache

    NameVirtualHost *:80

This means all the following name-virtual hosts will follow this ``NameVirtualHost`` directive, which receives requests on all interfaces on the server. :sup:`[1]`

Basically, you can place your own virtual host configuration file in /etc/apache2/sites-available directory and use the a2ensite command to enable this configuration (by creating a symbolic link at /etc/apache2/sites-enabled that Apache will load). If you owns a domain example.com and a subdomain wiki.example.com that both points to the IP address of this server, you can create a virtual host with ``ServerName wiki.example.com`` (the argument to ``<VirtualHost>`` is \*:80 in this case). If the configuration filename is wiki, you can use a2ensite wiki command to enable it.

Given these, let’s see how Apache handles requests for virtual hosts. When a request arrives, the server will find the best (most specific) matching ``<VirtualHost>`` argument based on the IP address and port used by the request. If there is more than one virtual host containing this best-match address and port combination, Apache will further compare the ``ServerName`` and ``ServerAlias`` directives to the server name present in the request. :sup:`[2]`

If you try to visit wiki.example.com you actually request the IP of this server. The Apache server will handle this request by comparing active virtual host configurations. It first checks 000-default, but detects no ``ServerName`` directive (neither does the global configuration as mentioned before). As a result, it performs a reverse DNS lookup to find the ``ServerName``. :sup:`[3]` If you have not setup a reverse DNS for this IP to wiki.example.com, the match will fail and Apache continues to match the next virtual host, wiki, which does have a ``ServerName``, wiki.example.com, and this is a match. Apache will respond with this virtual host.

However, if you have recently setup a reverse DNS for IP of your server to wiki.example.com, a different result will come out. When you access wiki.example.com, Apache first checks 000-default, and performs a reverse DNS resolution only to find wiki.example.com as the result for ``ServerName``, and this is a match. Apache will respond with 000-default instead of wiki and you will browse Web page for 000-default rather than wiki. To solve this problem, you can either set a global ``ServerName`` with example.com at /etc/apache2/apache2.conf or specify a ``ServerName`` for 000-default. In this way, the Apache will match the right ``ServerName`` with your request even if you setup a reverse DNS for one of the virtual hosts.

Reference
---------

1. http://httpd.apache.org/docs/2.2/mod/core.html#namevirtualhost
2. http://httpd.apache.org/docs/current/vhosts/name-based.html
3. http://httpd.apache.org/docs/current/dns-caveats.html


.. author:: default
.. categories:: none
.. tags:: Apache,Network,DNS
.. comments::
