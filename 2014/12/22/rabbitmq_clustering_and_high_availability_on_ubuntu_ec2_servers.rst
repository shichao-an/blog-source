RabbitMQ clustering and high availability on Ubuntu EC2 servers
===============================================================

.. highlight:: shell-session

Sample
------
The following setup and configurations were performed on the production servers listed below:

* mq-node1.example.com
* mq-node2.example.com
* mq-node3.example.com

Installation
------------

::

    # apt-get install rabbitmq-server

Hostname and /etc/hosts
-----------------------

On each server, the first priority of setup is hostname and ``/etc/hosts`` for internal IP addresses, which are used by RabbitMQ (Erlang) nodes. Use this script (`set-hostname.sh <https://gist.github.com/shichao-an/7c43e22c21c666f384ef>`_) to set the hostname for the corresponding server with the command:

.. highlight:: text

::

    # ./set-hostname.sh -s mq-nodeN.example.com

Then, modify ``/etc/hosts`` so that it looks like this (e.g. on mq-node1.example.com):

::

    127.0.1.1 mq-node1.example.com mq-node1
    10.0.1.101 mq-node2
    10.0.1.102 mq-node3

Ports
-----

Make sure port 5672 (AMQP) and 45000 (we'll use this later) are open on each server.

Config files
------------

On each server, do the following:

Edit ``/etc/rabbitmq/rabbitmq-env.conf`` and add the following (port configuration):

::

    SERVER_START_ARGS="-kernel inet_dist_listen_min 45000 -kernel inet_dist_listen_max 45000"

Edit ``/etc/rabbitmq/rabbitmq.config`` and add the following (clustering configuration):

::

    [{rabbit,
    [{cluster_nodes, {['rabbit@mq-node1', 'rabbit@mq-node2', 'rabbit@mq-node3'], disc}}]}].

Edit ``/var/lib/rabbitmq/.erlang.cookie`` and make sure they are the same on each server.

Reset and start nodes
---------------------

The RabbitMQ nodes may be already in running state. To put new configuration in effect, we have to reset and restart:
First, we reset and stop each node:

.. highlight:: shell-session

::

    # rabbitmqctl stop_app; rabbitmqctl reset;  rabbitmqctl stop

Then, start each node in turn. Remember, do this IN TURN, not simultaneously:

::

    # service rabbitmq start

Check status
------------

Until then, the nodes should be up and running. Check whether the cluster has been successfully created:

::

    # rabbitmqctl cluster_status

You should get the following result:

.. highlight:: text

::

    Cluster status of node 'rabbit@mq-node1' ...
    [{nodes,[{disc,['rabbit@mq-node1','rabbit@mq-node2',
                    'rabbit@mq-node3']}]},
     {running_nodes,['rabbit@mq-node3','rabbit@mq-node2',
                     'rabbit@mq-node1']},
     {partitions,[]}]
    ...done.
 
If you don't get this result, you may have to troubleshoot by checking logs at (``/var/log/rabbitmq``) inspecting each of the previous steps, and reset and start again.

Setup high availability (mirrored queues)
-----------------------------------------

Now it's time to setup mirrored queues. Run the following command:

.. highlight:: shell-session

::

    # rabbitmqctl set_policy ha-all ".*" '{"ha-mode":"all"}'

Then, you can check policies:

::

    # rabbitmqctl list_policies
    # rabbitmqctl list_queues name policy

Enable plugins
--------------

::

    # rabbitmq-plugins enable amqp_client
    # rabbitmq-plugins enable mochiweb
    # rabbitmq-plugins enable rabbitmq_management
    # rabbitmq-plugins enable rabbitmq_management_agent
    # rabbitmq-plugins enable webmachine
    # rabbitmq-plugins enable rabbitmq_web_dispatch
    # service rabbitmq-server restart

Enable rabbitmqadmin
--------------------

`rabbitmqadmin <https://www.rabbitmq.com/management-cli.html>`_ is an administration command for user and queue management. After rabbitmq_management plugin is enabled, it is present on the server. You can find it and create a symbolic link to it.

::

    # updatedb
    # locate rabbitmqadmin
    # ln -s $(locate rabbitmqadmin) /usr/sbin/rabbitmqadmin

User management
---------------

.. highlight:: shell

::

    # Add privileged user
    rabbitmqctl add_user 'root' 'your_password'
    rabbitmqctl set_user_tags root administrator
    rabbitmqctl set_permissions root ".*" ".*" ".*"
    # mq-read
    rabbitmqctl add_user 'mq-read' 'your_password'
    rabbitmqctl set_user_tags mq-read administrator
    rabbitmqctl set_permissions mq-read '^$' '^$' ".*"
    # worker
    rabbitmqctl add_user worker 'your_password'
    rabbitmqctl add_vhost /
    rabbitmqctl set_permissions -p / worker ".*" ".*" ".*"


Purge queues
------------

.. highlight:: shell-session

::

    # rabbitmqadmin -u root -p 'your_password' purge queue name=QUEUE_NAME


Useful rabbitmqctl commands
---------------------------

.. highlight:: shell

::

    # Check queues
    rabbitmqctl list_queues
     
    # Check master node
    rabbitmqctl list_queues pid
     
    # Check slaves
    rabbitmqctl list_queues slave_pids
    rabbitmqctl list_queues synchronised_slave_pids

References
----------

* http://www.rabbitmq.com/clustering.html
* http://www.rabbitmq.com/ha.html
* https://www.rabbitmq.com/management-cli.html
* http://www.rabbitmq.com/man/rabbitmqctl.1.man.html


.. author:: default
.. categories:: AWS,Ubuntu,RabbitMQ
.. tags:: none
.. comments::
