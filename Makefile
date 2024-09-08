
.PHONY: all metadata icon desktop bin build clean
.SUFFIXES:
VER ?= $(shell curl -s https://upgrade.mikrotik.com/routeros/winbox/LATEST.4)

all: build 
  
WinBox_Linux.zip:
	echo $(VER) > VERSION
	wget https://download.mikrotik.com/routeros/winbox/$(VER)/WinBox_Linux.zip

WinBox: WinBox_Linux.zip
	unzip -o WinBox_Linux.zip

metadata:
	mkdir -p dist/DEBIAN
	echo Package: WinBox > dist/DEBIAN/control 
	echo Version: $(VER) >> dist/DEBIAN/control 
	echo Section: base >> dist/DEBIAN/control 
	echo Priority: optional >> dist/DEBIAN/control 
	echo Architecture: all >> dist/DEBIAN/control 
	echo 'Maintainer: http://github.com/tikoci/winbox-deb' >> dist/DEBIAN/control 
	echo Description: Mikrotik WinBox for RouterOS >> dist/DEBIAN/control 

icon: WinBox assets/img/winbox.png
	mkdir -p dist/usr/share/icons/hicolor/48x48/apps
	convert assets/img/winbox.png -resize 48x48 dist/usr/share/icons/hicolor/48x48/apps/winbox.png

desktop:
	mkdir -p dist/usr/share/applications
	echo '[Desktop Entry]' > dist/usr/share/applications/WinBox.desktop
	echo 'Name=WinBox' >> dist/usr/share/applications/WinBox.desktop
	echo 'Comment=Mikrotik WinBox for RouterOS' >> dist/usr/share/applications/WinBox.desktop
	echo 'Exec=/usr/local/bin/WinBox' >> dist/usr/share/applications/WinBox.desktop
	echo 'Icon=winbox' >> dist/usr/share/applications/WinBox.desktop
	echo 'Terminal=false' >> dist/usr/share/applications/WinBox.desktop
	echo 'Type=Application' >> dist/usr/share/applications/WinBox.desktop
	echo 'Categories=Utility;Application;' >> dist/usr/share/applications/WinBox.desktop

bin:
	mkdir -p dist/usr/local/bin
	cp WinBox dist/usr/local/bin

build: WinBox bin metadata icon desktop
	dpkg-deb --build dist ./WinBox-$(VER).deb

clean:
	-rm WinBox
	-rm *.zip
	-rm -rf dist
	-rm -rf assets
