Get number of bits of a Python integer
======================================

.. highlight:: python

A Python integer is represented as either of 32-bit or 64-bit signed integer type that is platform-specific, without considering it as `an Python object <https://docs.python.org/2.7/c-api/int.html>`_. As indicated in the documentation, whether it is 32-bit or 64-bit can be revealed by checking ``sys.maxsize`` (or ``sys.maxint`` on older CPython implementations such as 2.4), the value of which "is the largest positive integer supported by the platform’s ``Py_ssize_t`` type and is usually ``2**31 - 1`` on a 32-bit platform and ``2**63 - 1`` on a 64-bit platform". `[1] <https://docs.python.org/2/library/sys.html>`_ `[2] <https://docs.python.org/3/library/sys.html#sys.maxsize>`_.

The following function helps determine number of bits of an integer and returns either 64 or 32 by leveraging the variable discussed above::

    import sys
     
     
    def get_int_bits():
        if hasattr(sys, 'maxsize'):
            max_int = getattr(sys, 'maxsize')
        else:
            max_int = getattr(sys, 'maxint')
        if max_int >> 62 == 0:
            return 32
        else:
            return 64

Check out the code on GitHub Gist from `this link <https://gist.github.com/shichao-an/b447d24f0a5381b0fa92>`_.

**Update Jun 10, 2014**

After an exploration of the `built-in types <https://docs.python.org/2/library/stdtypes.html#int.bit_length>`_, it is clear the ``int.bit_length`` can be used more easily than bit manipulation. ::

    import sys
     
     
    def get_int_bits():
        if hasattr(sys, 'maxsize'):
            max_int = getattr(sys, 'maxsize')
        else:
            max_int = getattr(sys, 'maxint')
        return max_int.bit_length() + 1


.. author:: default
.. categories:: none
.. tags:: Python
.. comments::
