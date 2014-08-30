Configure vsftpd FTP server in active mode on CentOS
====================================================

.. highlight:: shell-session

1. Install vsftpd, configure SELinux context and start the service::

       # yum install vsftpd
       # chkconfig vsftpd on
       # chcon -R -t public_content_t /var/ftp
       # service vsftpd start

2. There are two ways to configure iptables to allow connections

   One way is using system-config-firewall, which is simple::

       # system-config-firewall-tui

   Choose FTP in the "Trusted Service" menu and save the configuration. ``system-config-firewall`` will add rule in the INPUT chain and load ip_conntrack_ftp kernel module, which can be verified using::

       # lsmod | grep ftp
       nf_conntrack_ftp       10475  0
       nf_conntrack           65428  4 nf_conntrack_ftp,nf_conntrack_ipv6,nf_conntrack_ipv4,xt_state

   Another way is do it manually:

   (1) Insert the following rule somewhere before the final “reject-with icmp-host-prohibited” rule, say number 4::

           # iptables -L --line-numbers
           # iptables -I INPUT 4 -p tcp --dport 21 -m state --state NEW -j ACCEPT

   (2) Load ip_conntrack_ftp (alias of nf_conntrack_ftp)::

           # modprobe ip_conntrack_ftp

       Now the FTP directory should be accessible from remote machines.

.. author:: default
.. categories:: none
.. tags:: CentOS,Linux,iptables
.. comments::
