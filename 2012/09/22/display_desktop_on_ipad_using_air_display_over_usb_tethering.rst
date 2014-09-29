Display desktop on iPad using Air Display over USB tethering
============================================================

I was recently exploring remote desktop apps (VNC/RDP things)  for iOS. Then, plenty of them show up, like iDisplay, Splashtop, PocketCloud, Air Display, Displaylink, 2x, etc (all available at App Store). These apps are able to mirror or sustain remote desktop control over computers through Wi-Fi or Bluetooth. Among them, Splashtop seems to have versatility on control and Air Display is fast in streaming.

While the idea of implementation via USB rather than Wi-Fi sounds easy, it doesn't really work. The blog of Air Display support says: "In order for iOS apps like Air Display to access the USB bus via the 30-pin dock connector, its developer must be part of Apple's Made for iPod/iPhone/iPad (MFi) program". Nevertheless, they propose another solution, USB tethering.

According to this `nifty workaround <http://hijinksinc.com/2010/06/01/use-air-display-over-a-usb-cable/>`_ (for Mac, but same for Windows), what we need is a jailbroken iOS device, then download and install MyWi 5 from Cydia on it. When turning on Air Display on both iOS and Windows, enable USB tethering using MyWi. With the network established, the Air Display on Windows will recognize the device. Then, by clicking on the option for this device, the mirror or remote desktop just work. The trial takes place under the same wireless LAN.

.. author:: default
.. categories:: none
.. tags:: OS X,iOS
.. comments::
