
URLVER = https://upgrade.mikrotik.com/routeros/winbox/LATEST.4
URLBASE = https://download.mikrotik.com/routeros/winbox/#{version}/WinBox.dmg
.PHONY: all download unzip build clean
.SUFFIXES:

all:
  
download:
	wget https://download.mikrotik.com/routeros/winbox/`curl -s https://upgrade.mikrotik.com/routeros/winbox/LATEST.4`/WinBox.zip

unzip:

build: DEBIAN/control
	dpkg-deb --build .

clean: