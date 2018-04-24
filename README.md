# Mycroft-Installer
## GUI Installer For Installing Mycroft AI and Mycroft Plasmoid on KDE Plasma Desktop 

#### Mycroft Installer Version 1.0
##### Supported Distributions:
- Debian
- Kubuntu 16.04, 17.04, 17.10, 18.04 
- KDE Neon Xenial, Bionic 
- Fedora 25, 26, 27

##### Supports Installation Types:
- Mycroft Core + KDE Plasmoid
- Mycroft Core Only
- KDE Plasmoid Only

### Download The Installer Appimage From: https://github.com/AIIX/mycroft-installer/releases

#### Manual Build Instructions
##### Requirements:
- Depends on QT5.9
- Depends on QMLTermWidget By: https://github.com/Swordfish90/qmltermwidget

#### Build & Installation
- git clone --recursive https://github.com/AIIX/mycroft-installer
- cd mycroft-installer
- qmake && make
- cd qmltermwidget
- sudo make install 
- ../MycroftInstaller
