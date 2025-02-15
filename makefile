INCLUDE = -I/usr/local/include
LIBFOLDER = -L/usr/local/lib
LIBS = -lwiringPi -lwiringPiDev -lpthread -lm -lcrypt

SRC = pi-fan-controller.cpp
EXENAME = pi-fan-controller

all: 
	g++ -std=c++11 $(INCLUDE) $(SRC) -o $(EXENAME) $(LIBFOLDER) $(LIBS)

install.upstart:
	cp ./pi-fan-controller /usr/bin -f
	cp ./upstart/pi-fan-controller.conf /etc/init -f	
	initctl start pi-fan-controller
	
uninstall.upstart:
	initctl stop pi-fan-controller
	rm /etc/init/pi-fan-controller.conf
	rm /usr/bin/pi-fan-controller

install.systemd:
	cp ./pi-fan-controller /usr/bin -f
	cp ./systemd/pi-fan-controller.service /etc/systemd/system -f
	cp ./systemd/pi-fan-controller.env /etc -f
	systemctl enable pi-fan-controller.service
	systemctl daemon-reload
	systemctl restart pi-fan-controller.service
	
uninstall.systemd:
	systemctl stop pi-fan-controller.service
	systemctl disable pi-fan-controller.service
	rm /etc/systemd/system/pi-fan-controller.service
	rm /etc/pi-fan-controller.env
	rm /usr/bin/pi-fan-controller
	systemctl daemon-reload
	systemctl reset-failed