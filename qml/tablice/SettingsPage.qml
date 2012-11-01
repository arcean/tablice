import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: settingsPage

    ToolBar {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z: 10

        platformStyle: ToolBarStyle {
            inverted: true
            background: Qt.resolvedUrl("images/toolbar-background-transparent.png")
        }
        tools: ToolBarLayout {
            ToolIcon {
                platformIconId: "toolbar-back"
                anchors.left: parent.left
                onClicked: pageStack.pop()
            }
            ToolIcon {
                platformIconId: "toolbar-tag"
                anchors.right: parent.right
                onClicked: appWindow.showAboutDialog()
            }
        }
    }

    Image {
        id: header
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        z: 1
        height: 72
        source: "image://theme/" + appWindow.__ACTIVE_COLOR + "-meegotouch-view-header-fixed"
        Label {
            id: titleLabel
            anchors.verticalCenter: parent.verticalCenter
            x: UI.MARGIN_XLARGE
            text: "Ustawienia"
            color: "white"
            font.pixelSize: 26
        }
    }

    Flickable {
        id: flickable
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: __MARGIN
        anchors.rightMargin: __MARGIN
        contentHeight: parent.height + 1

        LabelSeparator {
            id: titleSeparator
            anchors.top: parent.top
            anchors.topMargin: __MARGIN
            anchors.left: parent.left
            anchors.right: parent.right

            text: "Wyszukuj po"
        }

        Label {
            id: searchByCity
            anchors.left: parent.left
            anchors.top: titleSeparator.bottom
            anchors.topMargin: __MARGIN * 2
            text: "Nazwach miast"
        }

        MySwitch {
            id: searchByCitySwitch
            anchors.verticalCenter: searchByCity.verticalCenter
            anchors.right: parent.right
            checked: Settings.getEnableSearchingByCity()
            onCheckedChanged: {
                Settings.setEnableSearchingByCity(checked)
            }
        }

        Label {
            id: searchByDistrict
            anchors.left: parent.left
            anchors.top: searchByCity.bottom
            anchors.topMargin: __MARGIN
            text: "Nazwach powiatów"
        }

        MySwitch {
            id: searchByDistrictSwitch
            anchors.verticalCenter: searchByDistrict.verticalCenter
            anchors.right: parent.right
            checked: Settings.getEnableSearchingByDistrict()
            onCheckedChanged: {
                Settings.setEnableSearchingByDistrict(checked)
            }
        }

        Label {
            id: searchByDistrictB
            anchors.left: parent.left
            anchors.top: searchByDistrict.bottom
            anchors.topMargin: __MARGIN
            text: "Nazwach województw"
        }

        MySwitch {
            id: searchByDistrictBSwitch
            anchors.verticalCenter: searchByDistrictB.verticalCenter
            anchors.right: parent.right
            checked: Settings.getEnableSearchingByDistrictB()
            onCheckedChanged: {
                Settings.setEnableSearchingByDistrictB(checked)
            }
        }

        LabelSeparator {
            id: title2separator
            anchors.top: searchByDistrictB.bottom
            anchors.topMargin: __MARGIN * 2
            anchors.left: parent.left
            anchors.right: parent.right

            text: "Inne"
        }

        Label {
            id: livesearchLabel
            anchors.left: parent.left
            anchors.top: title2separator.bottom
            anchors.topMargin: __MARGIN * 2
            text: "Wyszukuj na bieżąco"
        }

        MySwitch {
            id: livesearchSwitch
            anchors.verticalCenter: livesearchLabel.verticalCenter
            anchors.right: parent.right
            checked: Settings.getLiveSearch()
            onCheckedChanged: {
                Settings.setLiveSearch(checked)
            }
        }
    }
}
