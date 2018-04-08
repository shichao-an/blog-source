Relationships among nice, priority and weight in Linux kernel
=============================================================

nice value
----------

On Linux, the nice value ranges from -20 to 19.

nice and weight
---------------

In the Linux's Completely Fair Scheduler (CFS), mapping of nice to weight of a process is critical to calculating the virtual runtime (``vruntime``) of its scheduler entity structure (``struct sched_entity``). In Linux 2.6.34, this is defined in ``prio_to_weight`` (`kernel/sched.c#L1356 <https://github.com/torvalds/linux/blob/v2.6.34/kernel/sched.c#L1356>`_). The weight is roughly equivalent to ``1024/(1.25)^(nice)``:

.. highlight:: c

::

    static const int prio_to_weight[40] = {
     /* -20 */     88761,     71755,     56483,     46273,     36291,
     /* -15 */     29154,     23254,     18705,     14949,     11916,
     /* -10 */      9548,      7620,      6100,      4904,      3906,
     /*  -5 */      3121,      2501,      1991,      1586,      1277,
     /*   0 */      1024,       820,       655,       526,       423,
     /*   5 */       335,       272,       215,       172,       137,
     /*  10 */       110,        87,        70,        56,        45,
     /*  15 */        36,        29,        23,        18,        15,
    };

nice and priority
-----------------

The conversion between nice and static priority (priority for ``SCHED_NORMAL``, or non-"real-time" tasks) is defined by the ``NICE_TO_PRIO`` and ``PRIO_TO_NICE`` macros. Before Linux 3.15, for example, 2.6.34, this is defined in `kernel/sched.c <https://github.com/torvalds/linux/blob/v2.6.34/kernel/sched.c#L89>`_; since Linux 3.15, it is defined in `include/linux/sched/prio.h <https://github.com/torvalds/linux/blob/v4.1/include/linux/sched/prio.h#L32>`_. The relation is literally ``prio = nice + 120``, so the priority ranges from 100 to 139.

The following is the macro definition from the 2.6.34 source code

::

    #define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
    #define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)

nice value and rlimit style value
---------------------------------

In the recent man page on `setpriority(2) <http://man7.org/linux/man-pages/man2/setpriority.2.html>`_, there is a formula ``unice = 20 - knice`` that converts "user" nice values (-20..19) to "kernel" nice values (40..1), which is said to be handled by glibc wrapper functions for ``setpriority()`` and ``getpriority()`` system calls. This seems vague in definition.

`Since Linux 3.16 <http://lxr.free-electrons.com/ident?v=3.16;i=nice_to_rlimit>`_, a new `nice_to_rlimit` function is added to ``include/linux/sched/prio.h``, which seems to match the above description. This function converts nice value [19,-20] to rlimit style value [1,40]. The formula is equivalent to that on the man page. The ``rlimit_to_nice`` does the reverse operation.

::

    static inline long nice_to_rlimit(long nice)
    {
        return (MAX_NICE - nice + 1);
    }

Here, ``MAX_NICE`` is defined to be 19, so it is essentially ``rlimit = 20 - nice``.

Note that the rlimit style value is not to be confused with "user priority" (`include/linux/sched/prio.h#L40 <https://github.com/torvalds/linux/blob/v4.1/include/linux/sched/prio.h#L40>`_), which has a range of 0 to 39.



.. author:: default
.. categories:: none
.. tags:: Linux
.. comments::
