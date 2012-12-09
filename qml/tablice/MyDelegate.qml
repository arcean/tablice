import QtQuick 1.1
import com.nokia.meego 1.0
import "UIConstants.js" as UI
import "createobject.js" as ObjectCreator

Item {
    width: parent.width
    height: UI.THUMBNAIL_WRAPPER_SIDE + UI.THUMBNAIL_SPACING

    //property bool vkb_visible: false

    Component.onCompleted: {
        decideMiastoOrPowiat(miasto, powiat, wojewodztwo)
    }

    function showDetailsPage(kod, miasto, powiat, wojewodztwo)
    {
        var detailsPage = ObjectCreator.createObject(Qt.resolvedUrl("DetailsPage.qml"), appWindow.pageStack);
        detailsPage.kod = kod
        detailsPage.miasto = miasto
        detailsPage.powiat = powiat
        detailsPage.wojewodztwo = wojewodztwo
        detailsPage.correctText()
        appWindow.pageStack.push(detailsPage);
    }

    function decideMiastoOrPowiat(miasto, powiat, wojewodztwo)
    {
        if(miasto == "<t_tymcz>") {
            wojewodztwoText.text = "Tablica tymczasowa"
            powiatMiastoText.text = "Województwo: " + wojewodztwo
        }
        else if(miasto == "<army>") {
            wojewodztwoText.text = "Tablica wojskowa"
            powiatMiastoText.text = "Pojazd: " + wojewodztwo
        }
        else if(miasto == "<spec>") {
            wojewodztwoText.text = "Tablica instytucji:"
            powiatMiastoText.text = powiat
        }
        else if(powiat == "") {
            powiatMiastoText.text = "Miasto: " + miasto
        }
        else
            powiatMiastoText.text = "Powiat: " + powiat
    }

    Column {
        id: textColumn

        anchors.left: parent.left
        anchors.leftMargin: UI.LISTDELEGATE_MARGIN
        anchors.rightMargin: UI.LISTDELEGATE_MARGIN
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        spacing: 0
        Text {
            id: title
            text: name + " ..."
            color: UI.LISTDELEGATE_TITLE_COLOR
            width: parent.width
            font.bold: true
            font.pixelSize: 26
            elide: Text.ElideRight
            style: Text.Raised
            styleColor: UI.LISTDELEGATE_STYLE_COLOR
        }
        Item {
            width: parent.width
            height: wojewodztwoText.height + 32
            Text {
                y: 0
                id: wojewodztwoText
                text: "Województwo: " + wojewodztwo
                color: UI.LISTDELEGATE_TEXT_COLOR
                width: parent.width
                font.bold: true
                font.pixelSize: 18
                elide: Text.ElideRight
                style: Text.Raised
                styleColor: UI.LISTDELEGATE_STYLE_COLOR
            }
            Image {
                anchors { right: parent.right; rightMargin: 20; }//top: title.bottom}
                source: theme.inverted ? "images/drilldown-arrow-white.png" : "images/drilldown-arrow.png"
            }
            Text {
                y: wojewodztwoText.y + wojewodztwoText.height
                id: powiatMiastoText
                color: UI.LISTDELEGATE_TEXT_COLOR
                width: parent.width
                font.bold: true
                font.pixelSize: 18
                elide: Text.ElideRight
                style: Text.Raised
                styleColor: UI.LISTDELEGATE_STYLE_COLOR
            }
        }
    }

    Rectangle {
        id: highlight

        anchors.fill: parent
        color: __ACTIVE_COLOR_TEXT
        opacity: 0.3
        visible: mouseArea.pressed
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            //if (!vkb_visible)
                showDetailsPage(name, miasto, powiat, wojewodztwo);
            //else
            //    parent.forceActiveFocus();
        }
    }
}
