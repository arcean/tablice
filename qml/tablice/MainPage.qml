import Qt 4.7
import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: page
    property string filter: ""
    property QtObject filtermodel: EmptyPlates
    property QtObject fullModel
    property bool firstSearch: true
    property int textLength: 0

    Component.onCompleted: {
        Tables.openDatabase();
        Tables.createMainTable();
        Tables.createDetailsTable();
        Tables.loadDataToModel();
        Tables.tabliceTymczasowe();
        mainPage.fullModel = Plates;
    }

    Connections {
        /* Connect to signals from C++ object ListModel */

        target: Plates
        onEmptyList: noResultsText.visible = isEmpty;
    }

    ToolBar {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z: 10
        visible: appWindow.inPortrait ? (page.height < 700 ? false : true) : (page.height < 360 ? false : true)

        platformStyle: ToolBarStyle {
            inverted: true
            background: Qt.resolvedUrl("images/toolbar-background-transparent.png")
        }
        tools: ToolBarLayout {
            ToolIcon {
                platformIconId: "toolbar-settings"
                anchors.right: parent.right
                onClicked: showSettingsPage()
            }
        }
    }

    Image {
        id: header
        visible: appWindow.inPortrait
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
            text: "Lista tablic rejestracyjnych"
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
        delegate: MyDelegate {
            //vkb_visible: searchItem.focus
        }
        onMovementStarted: {
            listView.focus = true;
        }
    }
    ScrollDecorator {
        flickableItem: listView
    }

    function searchList(query)
    {
        // Abort when searchInput text is empty
        if(searchInput.text == "" && !Settings.getLiveSearch())
            return;

        if(searchInput.text.length < textLength || !Settings.getLiveSearch())
            firstSearch = true;
        textLength = searchInput.text.length
        filter = query
        listView.model = fullModel
        Plates.searchFor(query, firstSearch)
        filtermodel = EmptyPlates
        listView.model = filtermodel
        firstSearch = false;
    }

    function searchClear()
    {
        noResultsText.visible = false;
        filter = ""
        searchInput.text = ""
        searchInput.focus = false
        listView.focus = true
        firstSearch = true;
        textLength = 0;
        listView.model = fullModel
    }

    Image {
        x: 0
        y: parent.height > parent.width ? header.x + header.height : 0
        width: parent.width
        height: (searchItem.y + searchItem.height + 10) - y
        source: "images/toolbar-background.png"
        fillMode: Image.Stretch
    }

    Label {
        id: noResultsText

        anchors.centerIn: parent
        font.pixelSize: __LARGE_FONT_SIZE
        font.bold: true
        color: "#4d4d4d"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: appWindow.inPortrait ? "Nie znaleziono \npasujących tablic" : "Nie znaleziono pasujących tablic"
        visible: false
    }

    Item {
        id: searchItem

        height: searchInput.height
        anchors {
            left: parent.left;
            leftMargin: 20;
            right: parent.right;
            rightMargin: 20;
            top: appWindow.inPortrait ? header.bottom : parent.top;
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
            Keys.onEnterPressed: {
                searchInput.platformCloseSoftwareInputPanel();
                searchList(searchInput.text)
                searchInput.focus = false
                listView.focus = true
            }
            Keys.onReturnPressed: {
                searchInput.platformCloseSoftwareInputPanel();
                searchList(searchInput.text)
                searchInput.focus = false
                listView.focus = true
            }
            onTextChanged: {            
                if (Settings.getLiveSearch())
                    searchList(searchInput.text)
            }
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
                onClicked: filter == "" ? searchList(searchInput.text) : searchClear()
            }
        }
    }
}
