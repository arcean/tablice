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
        source: "image://theme/" + appWindow._APP_COLOR + "-meegotouch-view-header-fixed"
        Label {
            id: titleLabel
            anchors.verticalCenter: parent.verticalCenter
            x: (parent.width / 2) - titleLabel.width/2
            text: "Ustawienia"
            color: "white"
            font.pixelSize: 26
        }
    }

    Flickable {
        anchors.fill: parent
        anchors.leftMargin: UI.LISTDELEGATE_MARGIN
        anchors.rightMargin: UI.LISTDELEGATE_MARGIN
        contentHeight: parent.height + 1

        Label {
            id: title
            y: header.y + header.height + 20
            text: "Wyszukuj po:  "
            color: UI.LISTDELEGATE_TEXT_COLOR
        }

        Separator {
            anchors.verticalCenter: title.verticalCenter
            anchors.left: title.right
            anchors.right: parent.right
        }

        Label {
            id: searchByCity
            y: title.y + title.height + 20
            x: 2 * UI.LISTDELEGATE_MARGIN
            text: "nazwach miast"
        }

        MySwitch {
            id: searchByCitySwitch
            anchors.verticalCenter: searchByCity.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: UI.LISTDELEGATE_MARGIN
            checked: Settings.getEnableSearchingByCity()
            onCheckedChanged: {
                Settings.setEnableSearchingByCity(checked)
            }
        }

        Label {
            id: searchByDistrict
            y: searchByCity.y + searchByCity.height + 20
            x: 2 * UI.LISTDELEGATE_MARGIN
            text: "nazwach powiatów"
        }

        MySwitch {
            id: searchByDistrictSwitch
            anchors.verticalCenter: searchByDistrict.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: UI.LISTDELEGATE_MARGIN
            checked: Settings.getEnableSearchingByDistrict()
            onCheckedChanged: {
                Settings.setEnableSearchingByDistrict(checked)
            }
        }

        Label {
            id: searchByDistrictB
            y: searchByDistrict.y + searchByDistrict.height + 20
            x: 2 * UI.LISTDELEGATE_MARGIN
            text: "nazwach województw"
        }

        MySwitch {
            id: searchByDistrictBSwitch
            anchors.verticalCenter: searchByDistrictB.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: UI.LISTDELEGATE_MARGIN
            checked: Settings.getEnableSearchingByDistrictB()
            onCheckedChanged: {
                Settings.setEnableSearchingByDistrictB(checked)
            }
        }

        Label {
            id: title2
            y: searchByDistrictB.y + searchByDistrictB.height + 32
            text: "Inne:  "
            color: UI.LISTDELEGATE_TEXT_COLOR
        }

        Separator {
            anchors.verticalCenter: title2.verticalCenter
            anchors.left: title2.right
            anchors.right: parent.right
        }

        Label {
            id: livesearchLabel
            y: title2.y + title2.height + 20
            x: 2 * UI.LISTDELEGATE_MARGIN
            text: "wyszukuj na bieżąco"
        }

        MySwitch {
            id: livesearchSwitch
            anchors.verticalCenter: livesearchLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: UI.LISTDELEGATE_MARGIN
            checked: Settings.getLiveSearch()
            onCheckedChanged: {
                Settings.setLiveSearch(checked)
            }
        }
    }
}
