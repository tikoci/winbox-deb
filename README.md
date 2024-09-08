# Debian Package for Mikrotik WinBox

## Download and Usage
The Debian Package (`.deb`) is available under "Releases".  The `dpkg` tool, running a "root", can be used to install the package using the downloaded file, for example:
```
sudo dpkg -i ~/Downloads/WinBox-4.0beta4.deb
```
Once installed, WinBox should be available to GNOME or KDE desktops, generally under "Applications" (location will vary depending on disto and window manager).

To remove the package, the package name can be used:
```
sudo dkpg -r WinBox
```


## Implemetation
This project is really just a `Makefile` and GitHub action to run it.  

Inside the Makefile,
  * WinBox is download directly from Mikrotik, either
      * using make variable "VER" e.g. `make all VER=4.0beta4`
      * or, if VER is not provided to `make`, then a Mikrotik URL is used to determine the version
  * `DEBIAN/control` is created that describes the package
  * `WinBox.desktop` is created that is used by KDE and GNOME for Desktop integration
  *  Mikrotik's WinBox icon is converted to 48x48 (from 1024x1024) using `convert` (aka `magick convert`) per [Freedesktop Icon theme Spec](https://specifications.freedesktop.org/icon-theme-spec/latest/)
 
The GitHub CI using a "workflow_dispatch" to manually start a release using a specific versions.  The GitHub workflow action will create a draft release automatically, but publishing the a release is manual process.


> ## Disclaimers
> **This site is not affiliated, associated, authorized, endorsed by, or in any way officially connected with Mikrotik, Debian, or Ubuntu.**
> While the code in this project is released under CC0 (see LICENSE),  **The WinBox application and associated files are subject to Mikrotik's Terms and Conditions**, see [MIKROTIKLS MIKROTIK SOFTWARE END-USER LICENCE AGREEMENT](https://mikrotik.com/downloadterms.html).
> **Any trademarks and/or copyrights remain the property of their respective holders**, unless specifically noted otherwise.
> Use of a term in this document should not be regarded as affecting the validity of any trademark or service mark. Naming of particular products or brands should not be seen as endorsements.
> MikroTik is a trademarks of Mikrotikls SIA.
> UNIX is a registered trademark of The Open Group.
> Ubuntu is a registered trademark of Canonical Limited. 
> Debian is a trademark owned by Software in the Public Interest, Inc.
> **No liability can be accepted.**  No representation or warranty of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, availability, or completeness of any information is offered.  Use the concepts, code, examples and other content at your own risk. There may be errors and inaccuracies, that may of course be damaging to your system. Although this is highly unlikely, you should proceed with caution. The author(s) do not accept any responsibility for any damage incurred.  
