import QtQuick 1.1
import com.nokia.meego 1.0

Sheet {
    id: sheet

    acceptButtonText: "Insert"
    rejectButtonText: "Cancel"

    content: Flickable {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.topMargin: 10
        contentWidth: col2.width
        contentHeight: col2.height
        flickableDirection: Flickable.VerticalFlick
        Column {
            id: col2
            anchors.top: parent.top
            spacing: 10
            Label {
                text: "Insert those values into _details_ table:"
                font.pixelSize: 22
            }
            TextField {
                id: wojewodztwo
                placeholderText: "woj"
                maximumLength: 20
            }
            TextField {
                id: powiat
                placeholderText: "pow"
                maximumLength: 20
            }
            TextField {
                id: miasto
                placeholderText: "miasto"
                maximumLength: 20
            }
        }
    }
    onAccepted: Tables.insertValuesIntoDetails(-1, wojewodztwo.text, powiat.text)
}
