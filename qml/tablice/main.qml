import QtQuick 1.1
import com.nokia.meego 1.0
import "createobject.js" as ObjectCreator

PageStackWindow {
    id: appWindow
    property string _APP_COLOR: "color12"
    property string _ICON_LOCATION: "/usr/share/themes/blanco/meegotouch/icons/"
    property string _IMAGE_LOCATION: "/usr/share/themes/blanco/meegotouch/images/"
    property int _SMALL_FONT_SIZE: 18
    property int _STANDARD_FONT_SIZE: 24
    property int _LARGE_FONT_SIZE: 40

    initialPage: mainPage

    Component.onCompleted: {
        theme.inverted = true
        Tables.openDatabase()
        Tables.createMainTable()
        Tables.createDetailsTable()
        Tables.loadDataToModel()
        Tables.tabliceTymczasowe()
        mainPage.fullModel = Plates
    }

    platformStyle: PageStackWindowStyle {
        background: "image://theme/meegotouch-video-background"
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

    ToolBarLayout {
        id: commonTools
        visible: true

        ToolIcon {
            platformIconId: "toolbar-tag"
            anchors.right: parent.right
            onClicked: showAboutDialog()
        }
    }
}
