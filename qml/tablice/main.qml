import QtQuick 1.1
import com.nokia.meego 1.0
import "createobject.js" as ObjectCreator

PageStackWindow {
    id: appWindow
    property string __APP_NAME: "Tablice"
    property string __APP_VERSION: "1.2.3"
    property string _ICON_LOCATION: "/usr/share/themes/blanco/meegotouch/icons/"
    property string _IMAGE_LOCATION: "/usr/share/themes/blanco/meegotouch/images/"
    // Theme:
    property string __TEXT_COLOR: theme.inverted ? "white" : "black"
    property string __ACTIVE_COLOR: "color17"
    property string __ACTIVE_COLOR_TEXT: "#FF8F16"
    property string __DISABLED_COLOR_TEXT: "#797979"
    // Font size:
    property int __SMALL_FONT_SIZE: 18
    property int __STANDARD_FONT_SIZE: 24
    property int __HEADER_FONT_SIZE: 28
    property int __LARGE_FONT_SIZE: 40
    // Margins:
    property int __MARGIN: 16

    initialPage: mainPage
    showStatusBar: appWindow.inPortrait

    Component.onCompleted: {
        theme.inverted = true
    }

    platformStyle: PageStackWindowStyle {
        background: "image://theme/meegotouch-pin-background"
        backgroundFillMode: Image.Stretch
    }

    MainPage {
        id: mainPage
    }

    function showAboutDialog()
    {
        var aboutDialog = ObjectCreator.createObject(Qt.resolvedUrl("AboutDialog.qml"), appWindow.pageStack);
        aboutDialog.open();
    }

    function showSettingsPage()
    {
        var settingsPage = ObjectCreator.createObject(Qt.resolvedUrl("SettingsPage.qml"), appWindow.pageStack);
        pageStack.push(settingsPage)
    }

    function openInsertToDetails()
    {
        var inserSheet = ObjectCreator.createObject(Qt.resolvedUrl("InsertDetailsSheet.qml"), appWindow.pageStack);
        inserSheet.open();
    }

    function openInsertToMain()
    {
        var inserSheet = ObjectCreator.createObject(Qt.resolvedUrl("InsertMainSheet.qml"), appWindow.pageStack);
        inserSheet.open();
    }
}
