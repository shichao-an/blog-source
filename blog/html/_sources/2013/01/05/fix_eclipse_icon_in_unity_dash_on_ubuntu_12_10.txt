Fix Eclipse icon (not displayed, too big) in Unity Dash on Ubuntu 12.10
=======================================================================

.. highlight:: ini

It seems that the regular methods of merely creating eclipse.desktop (specifying Icon path as icon.xpm in the decompressed folder of Eclipse) which applied to Ubuntu 12.04 does not work on 12.10. The problem is that the icon is too big for Dash to render.

The huge icon can be obviously seen in "Dash Home" search results and ``/usr/share/applications/`` folder.

Someone has already reported this as a bug at https://bugs.launchpad.net/ubuntu/+source/dash/+bug/1068702 .

Found the simplest solution here.

Copy ``icon.xpm`` (from eclipse folder) into ``~/.local/share/icons/eclipse4.xpm``

In your ``eclipse.desktop`` file (which should be in ``~/.local/share/applications`` instead of ``/usr/share/…``), replace ``Icon=/path/to/eclipse/icon.xpm`` by ``Icon=eclipse4``. You don't need to add the .xpm suffix.

The ``eclipse.desktop`` will thus be something like this::

    [Desktop Entry]
    Version=1.0
    Name=Eclipse
    GenericName=Integrated Development Application
    Comment=Eclipse Juno
    Exec=/usr/local/bin/eclipse
    TryExec=/usr/local/bin/eclipse
    Icon=eclipse4
    Terminal=false
    Type=Application
    Categories=Development;IDE;


.. author:: default
.. categories:: none
.. tags:: Eclipse,Ubuntu
.. comments::
