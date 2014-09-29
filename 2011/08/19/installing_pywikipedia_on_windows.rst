Windows下安装Pywikipediabot
===========================

.. highlight:: shell-session

很早就想在MediaWiki上使用bot，但一直没有去关注。MediaWiki上的bot实现有很多途径，.NET，perl，java都有，但是貌似python最容易。于是选择了PyWikipediaBot。网上关于Pywikipedia中文的资料比较少，所以就自己按照meta-wiki上的Pywikipedia的instruction中的步骤进行安装，比较简单。

meta-wiki安装指南：http://meta.wikimedia.org/wiki/Pywikipediabot/Installation （这个有中文版翻译）

安装环境：

Windows 7 Ultimate + Python 2.7 (pywikipedia不支持Python 3.X)

MediaWiki 1.16.2 ，单语言（简体中文）

1.下载Pywikipedia。

手动下载或者TortoiseSVN都可以，后者的好处是升级方便。

手动下载PyWikipediaBot Nightlies：http://toolserver.org/~pywikipedia/nightly/

随便选一个：http://toolserver.org/~pywikipedia/nightly/package/pywikipedia/pywikipedia-nightly.7z

TortoiseSVN：http://svn.wikimedia.org/svnroot/pywikipedia/trunk/pywikipedia/

2. 设置快捷键。

Linux下直接export一个变量就行了：

::

    PYTHONPATH=$PYTHONPATH:~/pywikipedia/
    export PYTHONPATH

Windows下简单的方法就是：为pywikipedia目录创建快捷方式，然后编辑属性，目标写cmd.exe，起始位置写该目录的路径，确定后单击该快捷方式可以直接进入cmd并且在该目录下

3. 配置。

参考http://meta.wikimedia.org/wiki/Pywikipediabot/Use_on_non-Wikimedia_wikis。

按照安装指南，应该先创建family.py，再创建user-config.py。

.. highlight:: python

3.1. 创建yourwiki_family.py，直接在/families中现成的py文件中选择一个，复制并修改即可，我改的就是最简单的“mozilla_family.py”，文件命名为“你wiki的名字_family.py”：

::

    # -*- coding: utf-8  -*-
 
    import family
     
    class Family(family.Family):
     
         def __init__(self):
             family.Family.__init__(self)
             self.name = 'yourwiki' # 设置family名称，就是“你wiki的名字”（文件名下划线前面的部分）
             self.langs = {
                 'en': 'localhost', # 语言和主机名。语言设成en即可（之前一直登录失败就是在这写成了zh-cn，后来改成en后可用了）
             }
     
             self.namespaces[4] = {
                 '_default': u'YourWiki', #  计划页面的命名空间，一般就是LocalSettings.php中的$Sitename的值
             }
     
             self.namespaces[5] = {
                 '_default': u'YourWiki talk', # 计划页面讨论页的命名空间
             }
     
         def version(self, code):
             return "1.16.1"  # MediaWiki版本号，这个貌似不重要
     
         def scriptpath(self, code):
             return '/wiki' # index.php, api.php的脚步相对路径，这个和你wiki所在具体路有关，比如你的MediaWiki在/wiki目录下，那么这里就写“/wiki”

.. more::

3.2 创建user-config.py：这个可以手动创建，也可以通过cmd中执行generate_user_files.py按照提示进行：

::

    # -*- coding: utf-8  -*-
    family = 'yourwiki' #family名称，就是“你wiki的名字”
    mylang = 'en' #语言，一般设成en即可
    usernames['yourwiki']['en'] = u'ExampleBot' #你机器人的用户名，这个是已经在MediaWiki上创建好的机器人账户

没有什么意外的话，配置就完成了。

4.登录。

进入cmd终端pywikipedia目录下，执行login.py（可以附加参数 -v verbose显示详细信息），输入密码即可

.. highlight:: shell-session

::

    C:\pywikipedia&gt;login.py -v -v
    Password for user ExampleBot on yourwiki:en:
    Logging in to yourwiki:en as ExampleBot via API.
    ==== API action:login ====
    lgname: ExampleBot
    lgpassword: 123456
    ----------------
    Requesting API query from yourwiki:en
    ==== API action:login ====
    lgname: ExampleBot
    lgtoken: f1850634f20a6fd0a92a12668ae9b36f
    lgpassword: 123456
    ----------------
    Requesting API query from yourwiki:en
    Should be logged in now

显示“Should be logged in now”说明登录成功了。

5. 使用：登录成功后，bot一般就不会logout了。

然后就可以慢慢参考 http://meta.wikimedia.org/wiki/Pywikipediabot/Scripts 中使用明细进行操作了。

.. highlight:: text

常见的操作有：

::

    add_text.py	Adds text at the top or end of pages
    category.py	Manages categories
    imagecopy.py	Copies images from a wikimedia wiki to Commons
    interwiki.py	Creates Interlanguage links between a project
    redirect.py	Fixes double redirects, and deletes broken redirects
    replace.py	Edits using text replacement
    solve_disambiguation.py	Fixes disambiguation pages
    table2wiki.py	Converts HTML tables to MediaWiki markup
    template.py	Replaces one template with another (easier to use than replace.py)
    upload.py	Uploads images to a wiki
    weblinkchecker.py

执行编辑操作成功后，机器人的编辑将会在最近更改中显示。

.. author:: default
.. categories:: none
.. tags:: Windows,Python
.. comments::
