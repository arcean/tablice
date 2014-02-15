import QtQuick 1.0
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: detailsPage
    property string wojewodztwo: ""
    property string powiat: ""
    property string miasto: ""
    property string kod: ""

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
                onClicked: appWindow.pageStack.pop()
            }
        }
    }

    function correctText()
    {
        if(miasto == "<t_tymcz>") {
            wojewodztwoLabel.text = "Tablica tymczasowa"
            wojewodztwoLabelDetails.text = ""
            powiatLabel.text = "Województwo: "
            powiatLabelDetails.text = wojewodztwo
            miastoLabel.text = ""
            miastoLabelDetails.text = ""
        }
        else if(miasto == "<army>") {
            wojewodztwoLabel.text = "Tablica wojskowa"
            wojewodztwoLabelDetails.text = ""
            powiatLabel.text = "Pojazd: "
            powiatLabelDetails.text = wojewodztwo
            miastoLabel.text = ""
            miastoLabelDetails.text = ""
        }
        else if(miasto == "<spec>") {
            wojewodztwoLabel.text = "Tablica instytucji"
            wojewodztwoLabelDetails.text = ""
            powiatLabel.text = "Instytucja: "
            powiatLabelDetails.text = powiat
            miastoLabel.text = ""
            miastoLabelDetails.text = ""
        }
        else if (powiat == "" && miasto != "") {
            powiatLabel.text = "Miasto: "
            powiatLabelDetails.text = miasto
            miastoLabel.text = ""
            miastoLabelDetails.text = ""
        }
        else if (powiat != "" && miasto != "") {
            miastoLabel.text = "Stolica regionu: "
        }
        else if (powiat != "" && miasto == "") {
            miastoLabel.text = ""
        }
    }

    PageHeader {
        id: header
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        title: "Szczegóły"
    }

    Flickable {
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        contentHeight: height + 1

    /*    Label {
            id: codeLabel
            y: header.y + header.height + 20
            anchors.left: parent.left
            anchors.margins: __MARGIN
            text: "Kod tablicy: "
            font.pixelSize: __STANDARD_FONT_SIZE
        }
        Label {
            id: codeLabelDetails
            y: codeLabel.y + 28
            x: parent.width > 480 ? parent.width / 2 : 90
            text: kod
            font.pixelSize: __STANDARD_FONT_SIZE
            color: UI.LISTDELEGATE_TEXT_COLOR
        }*/
        Label {
            id: codeLabelDetails
            anchors.top: parent.top
            anchors.topMargin:  parent.width > 480 ? 0 : __MARGIN
            anchors.horizontalCenter: parent.horizontalCenter
            text: kod + " ..."
            font.pixelSize: 72
            color: UI.LISTDELEGATE_TEXT_COLOR
        }

        Label {
            id: wojewodztwoLabel
            anchors.top: codeLabelDetails.bottom
            anchors.topMargin: parent.width > 480 ? __MARGIN : __MARGIN * 2
            anchors.left: parent.left
            anchors.leftMargin: __MARGIN
            text: "Województwo: "
            font.pixelSize: __STANDARD_FONT_SIZE
        }

        Label {
            id: wojewodztwoLabelDetails
            anchors.top: wojewodztwoLabel.bottom
            x: parent.width > 480 ? parent.width / 2 : 90
            text: wojewodztwo
            font.pixelSize: __STANDARD_FONT_SIZE
            color: UI.LISTDELEGATE_TEXT_COLOR
        }
/*
        Label {
            id: wojewodztwoLabel
            y: codeLabelDetails.y + codeLabelDetails.height + 20
            anchors.left: parent.left
            anchors.margins: __MARGIN
            text: "Województwo: "
            font.pixelSize: __STANDARD_FONT_SIZE
        }
        Label {
            id: wojewodztwoLabelDetails
            y: wojewodztwoLabel.y + 28
            x: parent.width > 480 ? parent.width / 2 : 90
            text: wojewodztwo
            font.pixelSize: __STANDARD_FONT_SIZE
            color: UI.LISTDELEGATE_TEXT_COLOR
        }*/
        Label {
            id: powiatLabel
            anchors.top: wojewodztwoLabelDetails.bottom
            anchors.topMargin: __MARGIN * 2
            anchors.left: parent.left
            anchors.leftMargin: __MARGIN
            text: "Powiat: "
            font.pixelSize: __STANDARD_FONT_SIZE
        }
        Label {
            id: powiatLabelDetails
            anchors.top: powiatLabel.bottom
            x: parent.width > 480 ? parent.width / 2 : 90
            text: powiat
            font.pixelSize: __STANDARD_FONT_SIZE
            color: UI.LISTDELEGATE_TEXT_COLOR
        }
        Label {
            id: miastoLabel
            anchors.top: powiatLabelDetails.bottom
            anchors.topMargin: __MARGIN * 2
            anchors.left: parent.left
            anchors.leftMargin: __MARGIN
            text: "Miasto: "
            font.pixelSize: __STANDARD_FONT_SIZE
        }
        Label {
            id: miastoLabelDetails
            anchors.top: miastoLabel.bottom
            x: parent.width > 480 ? parent.width / 2 : 90
            text: miasto
            font.pixelSize: __STANDARD_FONT_SIZE
            color: UI.LISTDELEGATE_TEXT_COLOR
        }
     }
 }
