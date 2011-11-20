import QtQuick 1.0
import com.nokia.meego 1.0
import "UIConstants.js" as UI

Page {
    id: detailsPage
    property string wojewodztwo: ""
    property string powiat: ""
    property string miasto: ""
    property string kod: ""

    tools: ToolBarLayout {
        ToolIcon {
            platformIconId: "toolbar-back"
            onClicked: appWindow.pageStack.pop()
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
            text: "Szczegóły"
            color: "white"
            font.pixelSize: 26
        }
    }

    Flickable {
        width: parent.width
        height: parent.height
        contentHeight: height + 1

        Label {
            id: codeLabel
            y: header.y + header.height + 20
            anchors.left: parent.left
            anchors.margins: UI.MARGIN_XLARGE
            text: "Kod tablicy: "
            font.pixelSize: _STANDARD_FONT_SIZE
        }
        Label {
            id: codeLabelDetails
            y: codeLabel.y + 28
            x: parent.width > 480 ? parent.width / 2 : 90
            text: kod
            font.pixelSize: _STANDARD_FONT_SIZE
            color: UI.LISTDELEGATE_TEXT_COLOR
        }
        Label {
            id: wojewodztwoLabel
            y: codeLabelDetails.y + codeLabelDetails.height + 20
            anchors.left: parent.left
            anchors.margins: UI.MARGIN_XLARGE
            text: "Województwo: "
            font.pixelSize: _STANDARD_FONT_SIZE
        }
        Label {
            id: wojewodztwoLabelDetails
            y: wojewodztwoLabel.y + 28
            x: parent.width > 480 ? parent.width / 2 : 90
            text: wojewodztwo
            font.pixelSize: _STANDARD_FONT_SIZE
            color: UI.LISTDELEGATE_TEXT_COLOR
        }
        Label {
            id: powiatLabel
            y: wojewodztwoLabelDetails.y + wojewodztwoLabelDetails.height + 20
            anchors.left: parent.left
            anchors.margins: UI.MARGIN_XLARGE
            text: "Powiat: "
            font.pixelSize: _STANDARD_FONT_SIZE
        }
        Label {
            id: powiatLabelDetails
            y: powiatLabel.y + 28
            x: parent.width > 480 ? parent.width / 2 : 90
            text: powiat
            font.pixelSize: _STANDARD_FONT_SIZE
            color: UI.LISTDELEGATE_TEXT_COLOR
        }
        Label {
            id: miastoLabel
            y: powiatLabelDetails.y + powiatLabelDetails.height + 20
            anchors.left: parent.left
            anchors.margins: UI.MARGIN_XLARGE
            text: "Miasto: "
            font.pixelSize: _STANDARD_FONT_SIZE
        }
        Label {
            id: miastoLabelDetails
            y: miastoLabel.y + 28
            x: parent.width > 480 ? parent.width / 2 : 90
            text: miasto
            font.pixelSize: _STANDARD_FONT_SIZE
            color: UI.LISTDELEGATE_TEXT_COLOR
        }
     }
 }
