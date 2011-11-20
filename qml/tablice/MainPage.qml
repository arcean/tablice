import Qt 4.7
import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    tools: commonTools
    property string filter: ""
    property QtObject filtermodel: EmptyPlates
    property QtObject fullModel
    property variant uniqueChars: undefined

    Image {
        id: header
        visible: parent.height > parent.width
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
            text: "Baza tablic rejestracyjnych"
            color: "white"
            font.pixelSize: 26
        }
    }

    ListView {
        id: listView
        x: 20
        y: searchItem.y + searchItem.height + 10
        width: parent.width - 40
        height: parent.height - y
        model: Plates
        delegate:  MyDelegate {}
    }
    ScrollDecorator {
        flickableItem: listView
    }

    function searchList(query) {
        searchInput.focus = false;
        searchInput.platformCloseSoftwareInputPanel();
        filter = query
        listView.model = fullModel
        Plates.searchFor(query)
        filtermodel = EmptyPlates
        listView.model = filtermodel
        searchInput.focus = false
        listView.focus = true
    }

    function searchClear() {
        listView.model = fullModel
        filter = ""
        searchInput.text = ""
        searchInput.focus = false
        listView.focus = true
    }

    Image {
        x: 0
        y: parent.height > parent.width ? header.x + header.height : 0
        width: parent.width
        height: (searchItem.y + searchItem.height + 10) - y
        source: "images/toolbar-background.png"
        fillMode: Image.Stretch

    }

    Item {
        id: searchItem

        height: searchInput.height
        anchors {
            left: parent.left;
            leftMargin: 20;
            right: parent.right;
            rightMargin: 20;
            top: parent.height > parent.width ? header.bottom : parent.top;
            topMargin: 10
        }

        Behavior on opacity { PropertyAnimation { duration: 300 } }

        MyTextField {
            id: searchInput

            anchors { top: parent.top; left: parent.left; right: parent.right }
            placeholderText: qsTr("Wyszukaj")
            inputMethodHints: Qt.ImhNoPredictiveText
            platformSipAttributes: SipAttributes {
                actionKeyEnabled: searchInput.text != ""
                actionKeyHighlighted: true
                actionKeyLabel: qsTr("Gotowe")
                actionKeyIcon: ""
            }
            Keys.onEnterPressed: searchList(searchInput.text)
            Keys.onReturnPressed: searchList(searchInput.text)
            onTextChanged: filter = ""
        }

        Image {
            anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
            source: filter == "" ? _ICON_LOCATION + "icon-m-toolbar-search.png" : _ICON_LOCATION + "icon-m-input-clear.png"
            opacity: searchMouseArea.pressed ? 0.5 : 1

            MouseArea {
                id: searchMouseArea

                width: 60
                height: 60
                anchors.centerIn: parent
                enabled: searchInput.text != ""
                onClicked: filter == "" ? searchList(searchInput.text) : searchClear()
            }
        }
    }
}
