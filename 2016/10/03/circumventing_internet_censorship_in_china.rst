Circumventing Internet Censorship in China
==========================================

It's been a while since I went back to China in June this year. This post is intended as a summary of my most recent Internet experience using some very useful bypassing techniques.

AT&T Passport Data
------------------

AT&T Passport is the international data roaming plan by AT&T. With this plan enabled, you are able to select available network carriers (such as China Unicom) while in China, but need no further censorship circumvention, as if you were using a non-China network carrier directly. I'm not clear if other mobile network providers behave similarly. However, this method has its limitations of data usage, so you cannot use it freely.

ocserv
------

OpenConnect VPN server (ocserv) works best of all means. It is fast and stable.

To ease the server-side setup, I used `ocserv-docker <https://github.com/wppurking/ocserv-docker>`_ on a DigitalOcean box and a Linode box. By the time I was setting it up, there was some dependency errors, so I forked it into my `own GitHub repo <https://github.com/shichao-an/ocserv-docker>`_, fixed the errors, and built a `Docker image <https://hub.docker.com/r/shichaoan/ocserv-docker/>`_. I ran the following commands on an Ubuntu 14.04 system that uses UFW:

.. highlight:: shell-session

::

    # Add UFW rules
    sudo ufw allow 443/tcp
    sudo ufw allow 443/udp
    sudo service iptables-persistent save
    sudo ufw reload

    # Install Docker image
    mkdir -p ~/ocserv-docker/ocserv
    touch ~/ocserv-docker/ocserv/ocpasswd
    wget https://raw.githubusercontent.com/shichao-an/ocserv-docker/master/ocserv/ocserv.conf -O ~/ocserv-docker/ocserv/ocserv.conf
    sudo docker run --name ocserv -d --privileged -v ~/ocserv-docker/ocserv:/etc/ocserv -p 443:443/tcp shichaoan/ocserv-docker

    # Add user and prompt for password
    sudo docker exec -it ocserv ocpasswd shichao

    # Debug
    sudo docker logs ocserv
    sudo docker exec -ti ocserv /bin/bash


Then, you can install Cisco AnyConnect clients on both your computer and mobile devices and try to connect your server.

Shadowsocks
-----------

`Shadowsocks <https://shadowsocks.org>`_ also works well. It's just that I didn't bother to set it up my mobile devices, that is, iPhone and iPad. I set up the server side with my `Docker image <https://hub.docker.com/r/shichaoan/shadowsocks-libev/>`_, whose source is `shichao-an/docker-shadowsocks-libev <https://github.com/shichao-an/docker-shadowsocks-libev>`_.

ExpressVPN
----------

`ExpressVPN <https://www.expressvpn.com/>`_, one of the best commercial VPNs, is slow and unstable most of the time, which is basically unusable in China.

Pulse Secure
------------

My company provides Pulse Secure SSL VPN. It is usable, but very slow.


.. author:: default
.. categories:: none
.. tags:: Network
.. comments::
