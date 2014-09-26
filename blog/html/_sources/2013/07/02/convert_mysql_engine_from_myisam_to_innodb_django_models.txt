Convert MySQL table's engine from MyISAM to InnoDB for Django models
====================================================================

When I tried using django-activity-stream for my Django project, I cannot use syncdb, so I migrate it using South. When testing something like :

.. highlight:: pycon

::

    >>> from actstream import action
    >>> action.send(foo, verb='tested')

I got the following error:

.. highlight:: shell-session

::

    IntegrityError: (1452, 'Cannot add or update a child row: a
    foreign key constraint fails (`alexadb`.`actstream_action`,
    CONSTRAINT `actor_content_type_id_refs_id_357b994e` FOREIGN
    KEY (`actor_content_type_id`) REFERENCES `django_content_type`
    (`id`))')

It seems the foreign key constraint fail is related to table ``django_content_type``. Therefore, I ran the following MySQL command to check the engine of this table:

.. highlight:: mysql

::

    SHOW TABLE STATUS WHERE name='django_content_type';

The result for column 'Engine' is MyISAM, which is why it does not support foreign key constraint. One solution is to convert it to InnoDB. However, the following MySQL command seems to take a 'very' long time (even if it is not a very large table) that I cannot observe for about 5 minutes.

::

    ALTER TABLE django_content_type ENGINE = InnoDB;

To make the conversion quicker, I have to use another solution, which is recreating the ``django_content_type`` table with its engine being InnoDB.

This requires the following steps:

1. In the project directory, dump the app model data associated with table ``django_content_type``. This app and model name is ``contenttypes.ContentType`` (``django.contrib.contenttypes.models.ContentType``).

   .. highlight:: shell-session
   
   ::

       $ python manage.py dumpdata contenttypes.ContentType > contenttypes.json

2. Drop table ``django_content_type`` in MySQL:

   .. highlight:: mysql

   ::

       DROP TABLE django_content_type;

3. Get SQL statement of model ``contenttypes.ContentType``:

   .. highlight:: shell-session

   ::

       $ python manage.py sqlall contenttypes
       BEGIN;
       CREATE TABLE `django_content_type` (
           `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
           `name` varchar(100) NOT NULL,
           `app_label` varchar(100) NOT NULL,
           `model` varchar(100) NOT NULL,
           UNIQUE (`app_label`, `model`)
       )
       ;
 
       COMMIT;

   Add ``Engine=InnoDB`` to the statement, and run this in MySQL:

   .. highlight:: mysql

   ::

       CREATE TABLE `django_content_type` (
           `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
           `name` varchar(100) NOT NULL,
           `app_label` varchar(100) NOT NULL,
           `model` varchar(100) NOT NULL,
           UNIQUE (`app_label`, `model`)
       ) ENGINE=InnoDB
       ;

4. Load dumped data into database:

   .. highlight:: shell-session

   ::

       $ python manage.py loaddata contenttypes.json

5. Finally, the testing of django-activity-stream should work without errors:

   .. highlight:: pycon

   ::

       >>> from myapp.models import Foo
       >>> f = Foo.objects.get(id=1)
       >>> from actstream import action
       >>> action.send(f, verb='tested')
       [(<function action_handler at 0x1102ff410>, None)]


.. author:: default
.. categories:: none
.. tags:: Python,Django,MySQL
.. comments::
