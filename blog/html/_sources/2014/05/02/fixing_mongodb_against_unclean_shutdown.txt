Fixing MongoDB against unclean shutdown
=======================================

.. highlight:: shell-session

It's been a while since I maintained one of my servers that host an old project. After I got an HTTP 500 in an occasional case, I logged in to check what happend, only to find MongoDB is down. Running ``service mongod restart`` does not work. The MongoDB log indicates "Unclean shutdown detected."

After a search on Google, here's what I did to fix that::

    # grep dbpath /etc/mongod.conf
    dbpath=/var/lib/mongo
    # rm /var/lib/mongo/mongod.lock
    # mongod --repair --dbpath /var/lib/mongo

At this point, you will see that MongoDB is running the repair process. If you immediately start MongoDB server after that, it still fails, because some permissions in /var/lib/mongo have been changed. You have to recover owner and group of those files back to "mongod" and then start the service::

    # chown -R mongod:mongod /var/lib/mongo
    # service mongod restart

Finally note that this is an CentOS server. If you use MongoDB on Ubuntu, some namings may be different.


.. author:: default
.. categories:: none
.. tags:: MongoDB, Linux, CentOS
.. comments::
