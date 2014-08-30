Set up Selenium Python environment with X virtual framebuffer on Ubuntu server
==============================================================================

.. highlight:: shell-session

1. Install relevant APT packages::

       $ sudo apt-get install xorg
       $ sudo apt-get install xfvd
       $ sudo apt-get install firefox
       $ sudo apt-get install openjdk-7-jre
       $ sudo apt-get install python-pip

2. Download Selenium server and Python bindings::

       $ sudo pip install selenium
       $ wget https://selenium.googlecode.com/files/selenium-server-standalone-2.34.0.jar

3. Start virtual framebuffer X server for server number 1 (for DISPLAY) in the background::

       $ sudo Xvfb :1 &
       $ sudo Xvfb :1 -screen 0 1280x1024x8

4. Start Selenium server in the background (without sudo)::

       $ java -jar selenium-server-standalone-2.34.0.jar &

5. Write sample Python code in sample.py:

   .. code-block:: python

       from selenium import webdriver
       from selenium.webdriver.common.keys import Keys
        
        
       driver = webdriver.Firefox()
       driver.get("http://www.python.org")
       assert "Python" in driver.title
       elem = driver.find_element_by_name("q")
       elem.send_keys("selenium")
       elem.send_keys(Keys.RETURN)
       assert "Google" in driver.title
       driver.close()

6. Run sample.py with environment variable DISPLAY=:1::

       $ DISPLAY=:1 python sample.py

.. author:: default
.. categories:: none
.. tags:: Python,Ubuntu
.. comments::
