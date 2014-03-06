Suppressing Fedora NetworkManager's prompt to connect to WPA Enterprise wireless networks
=========================================================================================

This seems to be an unsolved bug (`#982429 <https://bugzilla.redhat.com/show_bug.cgi?id=982429>`_) still under discussion. Many give temporary solutions that modify the corresponding ``ifcfg-*`` file and specify the password, possibly in plaintext form. Some suggest encrypting the password using ``wpa_passphrase ESSID`` command. The problematic network here is "nyu" of the New York University. Every time I turned on my laptop on the campus, it prompts with a dialog (though the password is actually stored) for me to click the "Connect" button, which is annoying. However, the encryption method does not work as far as I am concerned with Fedora 20. So I just followed the plaintext way to produce a temporary fix for that::

    # cd /etc/sysconfig/network-scripts
    # vim ifcfg-nyu

Comment or remove the following line::

    IEEE_8021X_PASSWORD_FLAGS=user

Create a new file named ``keys-nyu`` in this directory with your password::

    IEEE_8021X_PASSWORD='your_password'

Don't forget to make it read-writable by root only::

    # chmod 600 keys-nyu    

Then restart your network interface associated with "nyu"::

    # ifdown nyu
    # ifup nyu

Then, the wireless network should work as expected. Try to logout or reboot to see if it surely works.


.. author:: default
.. categories:: none
.. tags:: Linux,Fedora 
.. comments::
