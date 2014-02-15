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
    property bool isFastScrollActive: false
    state: "hideSearchField"

    Component.onCompleted: {
        Tables.openDatabase();
        Tables.createMainTable();
        Tables.createDetailsTable();
        Tables.loadDataToModel();
        Tables.tabliceTymczasowe();
        mainPage.fullModel = Plates;
        fastScroll.listView = listViewMain;
    }

    states: [
        State {
            name: "hideSearchField"
            PropertyChanges { target: searchBackground; opacity: 0; }
            PropertyChanges { target: searchItem; opacity: 0; }
            AnchorChanges { target: searchBackground; anchors.top: undefined; anchors.bottom: header.bottom; }
            AnchorChanges { target: searchItem; anchors.top: undefined; anchors.bottom: header.bottom; }
        },
        State {
            name: "showSearchField"
            PropertyChanges { target: searchBackground; opacity: 1; }
            PropertyChanges { target: searchItem; opacity: 1; }
            AnchorChanges { target: searchBackground; anchors.bottom: undefined; anchors.top: header.bottom; }
            AnchorChanges { target: searchItem; anchors.bottom: undefined; anchors.top: header.bottom; }
        }
    ]

    transitions: Transition {
        AnchorAnimation { duration: 150; }
    }

    Connections {
        /* Connect to signals from C++ object ListModel */

        target: Plates
        onEmptyList: noResultsText.visible = isEmpty;
    }

    ToolBar {
        id: toolbar
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

    PageHeader {
        id: header
       //visible: appWindow.inPortrait
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        title: "Lista tablic rejestracyjnych"
    }

    Component {
           id: sectionHeading

           Rectangle {
               width: parent.width
               height: 50
               color: "transparent"

                Rectangle {
                    id: divline
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 16
                    anchors.left: parent.left
                    anchors.rightMargin: 16
                    anchors.right: sectionLabel.left
                    height: 1
                    color: "gray"
                    opacity: 0.6
                }

                Text {
                    id: sectionLabel
                    text: section
                    font.pointSize: 18
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 16
                    color: "gray"
                }
           }
       }

    ListView {
        id: listViewMain
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: searchBackground.bottom
        anchors.bottom: toolbar.top

        section.property: "category"
        section.criteria: ViewSection.FullString
        section.delegate: sectionHeading

        model: Plates
        delegate: MyDelegate {
            //vkb_visible: searchItem.focus
        }

        onMovementStarted: {
            listViewMain.focus = true;
        }

        onContentYChanged: {
            if (visibleArea.yPosition < -0.001 && !searchTimer.shouldBeHidden
                    && !isFastScrollActive) {
                page.state = "showSearchField";
                searchTimer.shouldBeHidden = true;
                searchTimer.start();
            }
        }

        FastScroll {
            id: fastScroll
            // Assign later, the listViewMain model has not been loaded yet.
            //listView: listViewMain
            onFastScrollPressed: {
                isFastScrollActive = isActive;
            }
        }
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
        listViewMain.model = fullModel
        Plates.searchFor(query, firstSearch)
        filtermodel = EmptyPlates
        listViewMain.model = filtermodel
        firstSearch = false;
    }

    function searchClear()
    {
        noResultsText.visible = false;
        filter = ""
        searchInput.text = ""
        searchInput.focus = false
        listViewMain.focus = true
        firstSearch = true;
        textLength = 0;
        listViewMain.model = fullModel
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

    Timer {
        id: searchTimer
        interval: 5000
        running: false
        repeat: false

        property bool shouldBeHidden: false

        onTriggered: {
            page.state = "hideSearchField";
            shouldBeHidden = false;
            searchClear();
        }
    }

    Image {
        id: searchBackground
        anchors.top: undefined
        anchors.bottom: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 72 // 52 + 2 * 10 (margins)
        smooth: true
        source: "images/toolbar-background.png"
        fillMode: Image.Stretch

        Behavior on opacity { PropertyAnimation { duration: 250 } }
    }

    Item {
        id: searchItem

        height: 52
        anchors {
            left: parent.left;
            leftMargin: 20;
            right: parent.right;
            rightMargin: 20;
            top: undefined;//appWindow.inPortrait ? header.bottom : parent.top;
            topMargin: 10
            bottom: header.bottom
        }

        Behavior on opacity { PropertyAnimation { duration: 250 } }

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
                listViewMain.focus = true
            }
            Keys.onReturnPressed: {
                searchInput.platformCloseSoftwareInputPanel();
                searchList(searchInput.text)
                searchInput.focus = false
                listViewMain.focus = true
            }
            onTextChanged: {
                if (Settings.getLiveSearch())
                    searchList(searchInput.text)

                if (searchTimer.shouldBeHidden && searchInput.text != "")
                    searchTimer.stop();
                else if (searchTimer.shouldBeHidden)
                    searchTimer.start();
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
