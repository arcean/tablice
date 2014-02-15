# Add more folders to ship with the application, here
folder_01.source = qml/tablice
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

VERSION = 1.3.0
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE3E149D5

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

QT += sql opengl

# enable booster
CONFIG += qt-boostable qdeclarative-boostable meegotouch

DEFINES += QT_USE_FAST_CONCATENATION QT_USE_FAST_OPERATOR_PLUS

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    tables.cpp \
    listmodel.cpp \
    plateitem.cpp \
    settings.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES +=

HEADERS += \
    tables.h \
    listmodel.h \
    plateitem.h \
    settings.h

INCLUDEPATH += /usr/include/applauncherd

contains(MEEGO_EDITION,harmattan) {
    baza.path = /opt/tablice/data/
    baza.files = data/tablice.db.sqlite
    desktopfile.files = data/$${TARGET}.desktop
    desktopfile.path = /usr/share/applications
    icon.files = data/tablice.png
    icon.path = /usr/share/icons/hicolor/80x80/apps
    splashes.files = data/landscape.png data/portrait.png
    splashes.path = /opt/tablice/data/
    INSTALLS += baza desktopfile icon splashes
}











