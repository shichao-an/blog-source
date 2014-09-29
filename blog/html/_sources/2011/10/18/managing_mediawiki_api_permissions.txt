管理MediaWiki API使用权限
=========================

.. highlight:: php

MediaWiki提供API接口用于外部程序访问和修改网站的数据库。一般来说，最常用的外部工具就是 pywikipediabot 机器人，用于半自动地处理大量繁琐编辑工作，或者自动地执行脚本，达到维护网站的目的。

然而，默认状态下，API 是对所有用户组群开放的（参见：http://www.mediawiki.org/wiki/Manual:User_rights#Default_rights），因为 ``$wgEnableWriteAPI`` 这个变量是隐式的 true，从而使得所有用户具有 writeapi 的默认权限。这将会对网站的安全带来隐患，尤其对于通过 API 对网站内容进行恶意破坏的机器人是毫无防御。通过简单的设置可以避免这类破坏，当然也仅仅是这类破坏，不能防止通过页面元素提交的破坏。

在 ``LocalSettings.php`` 中添加如下代码

::

    $wgGroupPermissions['*']['writeapi'] = false; // forbid all anonymous writing api
    $wgGroupPermissions['user']['writeapi'] = false; // forbid all users (including autoconfirmed) writing api
    $wgGroupPermissions['bot']['writeapi'] = true; // allow those with bot flag to write api

当然，anti-spam 需要的不仅仅是这一项。如果网站频遭人类或 bot 的 spam 或 vandalism，各类强大的插件比如：AbuseFilter、ConfirmEdit是可以使用的工具。不过前者主要用于 Wikipedia 这类大型 wiki；对于小型网站的话，后者的 Captcha 模块在需要的时候就会具有比较中肯的用处。

.. author:: default
.. categories:: none
.. tags:: PHP
.. comments::
