# pi-fan-controller
A simple daemon to control a 5v fan. Made in collaboration with Björn Eiríksson (www.einhugur.com).

This daemon controls a 5v fan based on the current cpu temperature. This was developed using an orange pi PC 
running Armbian Debian GNU/Linux 8 (jessie). The daemon controls the fan speed via a circuit design by Björn
and the whole process can be seen here on his blog here:

https://einhugur.com/blog/index.php/big-projects/build-fan-controller-for-orange-pi-pc/

**NOTE:** You'll need to put the circuit board together as described in the Einhugur blog post for this to work.

Implements a makefile modified by milyovski https://github.com/milyovski

## Dependencies
This daemon depends on WiringOP being installed. You can get it from here:

https://github.com/zhaolei/WiringOP

## Building and installing
1. Clone the repo and run:
```
make
```

2. For distros with upstart:
```
sudo make install.upstart
```

3. For distros with systemd:
```
sudo make install.systemd
```

This compiles and copies the executable and config files for the appropriate init system. This also enables and starts the daemon for both upstart and systemd.

For upstart the config file goes here:
```
/etc/init/pi-fan-controller.conf
```

For systemd the unit- and environment file:
```
/etc/systemd/system/pi-fan-controller.service
/etc/pi-fan-controller.env
```

## Configuring and starting
For both upstart and systemd the daemon is started when you run the install.upstart/install.systemd targets. 

For upstart, edit this file:
```
/etc/init/pi-fan-controller.conf
```

For systemd, edit this file:
```
/etc/pi-fan-controller.env
```

You can configure the following parameters in upstart/systemd files:
* The cpu temperature levels at which to start the fan and increase the fan speed.
* The interval in seconds to check the cpu temperature.
* The log level. This daemon logs into /var/log/syslog
* The time in seconds the fan should keep spinning after the cpu temperature drops below the lowest temperature level

## Uninstalling
The makefile has uninstall targets for both upstart and systemd. Bot targets stop the daemons and remove the associated files (binaries and config files).

For upstart:
```
sudo make uninstall.upstart
```

For systemd:
```
sudo make uninstall.systemd
```
