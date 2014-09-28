Create a personal website with Sphinx
=====================================

Sphinx is a documentation generator which converts reStructuredText files into HTML websites and other formats e.g. LaTeX (PDF) and man pages. It's also a good idea to create simple static website with Sphinx, for example, a personal profile site.

However, as the default purpose of Sphinx is to create documentation, it requires some customization regarding template structure and style. The following steps help create a simple profile site based on the built-in themes of Sphinx.

.. highlight:: shell-session

1. Download `Sphinx <http://sphinx-doc.org/index.html>`_, create a base directory and quick-start Sphinx. It'll be helpful to answer "yes" to "Create Makefile?" during sphinx-quickstart::

       $ easy_install -U sphinx
       $ mkdir base_dir
       $ cd base_dir
       $ sphinx-quickstart

2. Change site title.

   .. highlight:: python

   Edit ``conf.py`` in the source directory and make the following modifications::

       html_title = "YOUR SITE TITLE"
       #version = '0.0.1'
       #release = '0.0.1'

   Comment version and release to prevent this version number from being displayed in titles.

3. Customize the content structure based on "basic" theme or its derivatives ("default" and "nature"). We take "nature" as an example here.

   First, edit ``conf.py`` and make the following modifications::

       html_theme = 'nature'
       html_sidebars = {'**':['localtoc.html','searchbox.html']}

   ``html_sidebars`` determines the built-in templates to be displayed in the sidebar. For other built-in templates and detailed information, see ``html_sidebars``.

   Second, make sure the settings of the following variables::

       templates_path = ['_templates']
       html_static_path = ['_static']

   ``_templates`` directory stores template files; _static directory stores static files such as CSS and images. These two directories reside in source directory.

   Third, create your own template ``layout.html`` inheriting from the default theme::

       $ cd source/_template
       $ vi layout.html

   .. highlight:: jinja

   Edit layout.html::

       {% extends "!layout.html" %}
       {%- set rellinks = [] %}
       {% block rootrellink %}</pre>
       <ul>
           <li><a href="index.html">Home</a> |</li>
           <li><a href="resume.html">Resume</a> |</li>
           <li><a href="projects.html">Projects</a> |</li>
           <li><a href="interest.html">Interest</a> |</li>
           <li><a href="contact.html">Contact</a></li>
           <li>{% endblock %}
       {% block relbar2 %}
       {% endblock %}
       The template above creates a header navigation bar of different entries of your sites.

       {%- set rellinks = [] %} disables related links (i.e. prev, next and index).

4. Create reStructuredText (.rst) source files for your entries (``index.html``, ``resume.html``, ``projects.html``, ``interest.html``, ``contact.html``):

   .. highlight:: shell-session

   ::

       $ cd source
       $ vi index.rst

   Use the following format, which also applies to other .rst files, such as ``resume.rst``, ``projects.rst``, ``interest.html`` and ``contact.html``.

   .. highlight:: rst

   ::

       Welcome
       *******
       Welcome to my site!
        
       About me
       ========
       I am Blah Blah ...
        
       More info
       =========
       Blah...
        
       .. toctree::
          :maxdepth: 2

.. more::

5. Add a logo for your site.

   First, copy your logo image to the ``source/_static`` directory.

   .. highlight:: python

   Then, edit ``conf.py``::

       html_logo = "logo.jpg"

6. Modify style sheets.

   First, edit ``conf.py`` and specify your CSS file name::

       html_style = "mystyle.css"

   Second, create your CSS file the ``source/_static`` directory:

   .. highlight:: shell-session

   ::

       $ cd source/_static
       $ vi mystyle.css

   Then, edit your CSS file by inheriting default theme CSS, ``nature.css`` in our example.

   .. highlight:: css

   ::

       @import url("nature.css");
        
       body {
         font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
         font-size: 14px;
         font-weight: 300;
         background-color:#333;
        
       }
        
       div.sphinxsidebar {
         font-size: 0.9em;
         line-height: 1.5em;
       }
        
       div.sphinxsidebarwrapper{
         margin-left:10px;
         padding: 5px 0 10px 0;
       }
        
       div.related {
         background-color:#5F95CE;
         font-size: 1em;
       }

7. Build your source files from ``base_dir``.

   .. highlight:: shell-session

   ::

       $ make html
       $ sphinx-build -b html -d build/doctrees source build/html

   Use the following commands if your modification to CSS files does not take effect
   
   ::

       $ sphinx-build -a -b html -d build/doctrees source build/html

8. Finish. HTML files are generated in ``build/html``, and your site is ready to be visited.
 
.. author:: default
.. categories:: none
.. tags:: Sphinx
.. comments::
