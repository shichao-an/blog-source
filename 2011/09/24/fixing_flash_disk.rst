U盘量产导致USB接口错误的解决方法
================================

上周用一个4G的爱国者U盘做了一个系统启动盘。系统装完后，第二天刚好要去复印室打印一个重要的东西去去找老师，发现我竟然没有多余的优盘。

没时间找了，再加上这个启动盘暂时没用了，于是打算格式化一下。但是突然发现无法格式化。想了很多方法，最终从网上下了一款U盘量产工具AlcorMP，把U盘修复了一下，大概20分钟，修复完毕后，U盘可以正常格式化了。第二天一早去打印了。

中午回来后，发现鼠标和外接的键盘都无反应了。打开Windows 7下的设备管理器，发现USB控制器下的一个Intel(R) 5 Series/3400 Series Chipset Family USB Enhanced Host Controller – 3B34出现了问题：该设备未能启动。手动禁用后再重启，鼠标和键盘都恢复了。可是重启后该问题依然继续。总不能让我以后每次一开机都要先进行“禁用-启用”操作后才能正常使用电脑吧？为了解决它，使用了很多方法，比如更新驱动，都没有用。

最后，在这个帖子 http://www.fanren8.com/read-htm-tid-31956.html 里找到了解决办法。其实只要删除注册表几个键值就可以，记录下解决方法： 开始——运行——regedit— —来到键值[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\处找到USB接口控制键值Universal Serial Bus controllers，保留默认键值以及Class，IconPath，NoInstallClass。重启后，一切正常！

问题是量产软件修改了注册表导致的

.. author:: default
.. categories:: none
.. tags:: Windows
.. comments::
