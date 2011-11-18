import QtQuick 1.1
import com.nokia.meego 1.0

Sheet {
    id: sheet

    acceptButtonText: Tables.getIdsNumber()
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
                text: "Insert those values into _main table:"
                font.pixelSize: 22
            }
            TextField {
                id: idCount
                placeholderText: acceptButtonText
                maximumLength: 20
                enableSoftwareInputPanel: false
                onFocusChanged: closeSoftwareInputPanel()
                onTextChanged: closeSoftwareInputPanel()
                onCustomSoftwareInputPanelChanged: closeSoftwareInputPanel()
                onActiveFocusChanged: closeSoftwareInputPanel()
            }
            TextField {
                id: tableCode
                placeholderText: ""
                maximumLength: 20
                enableSoftwareInputPanel: false
                onFocusChanged: closeSoftwareInputPanel()
                onTextChanged: closeSoftwareInputPanel()
                onCustomSoftwareInputPanelChanged: closeSoftwareInputPanel()
                onActiveFocusChanged: closeSoftwareInputPanel()
            }
            TextField {
                id: wojewodztwo
                placeholderText: "woj"
                maximumLength: 20
                enableSoftwareInputPanel: false
                onFocusChanged: closeSoftwareInputPanel()
                onTextChanged: closeSoftwareInputPanel()
                onCustomSoftwareInputPanelChanged: closeSoftwareInputPanel()
                onActiveFocusChanged: closeSoftwareInputPanel()
            }
            TextField {
                id: powiat
                placeholderText: "pow"
                maximumLength: 30
                enableSoftwareInputPanel: false
                onFocusChanged: closeSoftwareInputPanel()
                onTextChanged: closeSoftwareInputPanel()
                onCustomSoftwareInputPanelChanged: closeSoftwareInputPanel()
                onActiveFocusChanged: closeSoftwareInputPanel()
            }
            TextField {
                id: miasto
                placeholderText: "miasto"
                maximumLength: 20
                onFocusChanged: closeSoftwareInputPanel()
                onTextChanged: closeSoftwareInputPanel()
                onCustomSoftwareInputPanelChanged: closeSoftwareInputPanel()
                onActiveFocusChanged: closeSoftwareInputPanel()
            }
        }
    }
    onAccepted: {
        Tables.insertValuesIntoMain(acceptButtonText, tableCode.text)
        Tables.insertValuesIntoDetails(acceptButtonText, wojewodztwo.text, powiat.text, miasto.text)
    }
}
