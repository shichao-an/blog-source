Setup virtualenvwrapper with pyenv using pyenv-virtualenvwrapper
================================================================

Typically on OS X, I'm prone to use `pyenv <https://github.com/yyuu/pyenv>`_ to manage multiple Python versions, particularly 2.7 and 3.3. I always keep the 2.7.x Python (system version) that ships with OS X, and install extra versions using pyenv, and develop under virtualenvs. It seems `virtualenv <https://github.com/pypa/virtualenv/>`_ and `virtualenvwrapper <https://bitbucket.org/dhellmann/virtualenvwrapper/>`_ do not natively work well with pyenv's shims when creating new virtualenvs, and it also seems the author of pyenv already gives the solution, `pyenv-virtualenvwrapper <https://github.com/yyuu/pyenv-virtualenvwrapper>`_.

As an essential record, install Python 3.4.1 using pyenv (for installation of pyenv itself, see its `documentation <https://github.com/yyuu/pyenv>`_) and enable it globally, along with the system version.

.. highlight:: shell-session

::

    $ pyenv install 3.4.1
    $ pyenv rehash
    $ pyenv global system 3.4.1

You can verify current available versions using the following command::

    $ pyenv versions
    * system (set by /Users/shichao/.python-version)
    * 3.4.1 (set by /Users/shichao/.python-version)

Make sure you have installed virtualenvwrapper and pyenv-virtualenvwrapper (using brew, of course)::

    $ pip install virtualenvwrapper
    $ brew install pyenv-virtualenvwrapper

.. highlight:: bash

Then, put the following lines somewhere in your ``~/.bash_profile``::

    # pyenv
    eval "$(pyenv init -)"
    # virtualenvwrapper
    export WORKON_HOME=~/envs

Then you can enable virtualenvwrapper with ``pyenv virtualenvwrapper``, and you may set an alias for that.

.. highlight:: shell-session

Now, you can normally create new virtualenvs. 

Create a virtualenv from the system version::

    $ mkvirtualenv -p $(which python)

Similarly, create a virtualenv from 3.4::

    $ mkvirtualenv -p $(which python3.4)


.. author:: default
.. categories:: none
.. tags:: Python,OS X
.. comments::
