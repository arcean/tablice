import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    height: 14
    property alias text: label.text

    Separator {
        id: separator
        anchors.left: parent.left
        anchors.right: label.left
        anchors.rightMargin: __MARGIN
        anchors.verticalCenter: label.verticalCenter
    }

    Label {
        id: label
        anchors.right: parent.right
        anchors.rightMargin: __MARGIN

        font.pixelSize: __SMALL_FONT_SIZE
        color: __DISABLED_COLOR_TEXT
        text: parent.height
    }
}
