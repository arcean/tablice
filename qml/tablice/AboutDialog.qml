import QtQuick 1.0
import com.nokia.meego 1.0

QueryDialog {
    id: dialog

    titleText: "Tablice 1.0.0-tp5"
    icon: "/usr/share/icons/hicolor/80x80/apps/tablice.png"
    message: "Program umożliwia przeglądanie listy najpopularniejszych samochodowych tablic rejestracyjnych w Polsce. <br><br> &copy; Tomasz Pieniążek 2011 <br><br>"

    Component.onCompleted: {
        pageLabel.state = "show"
    }

    Label {
        id: pageLabel
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: _STANDARD_FONT_SIZE
        opacity: 0
        textFormat: Text.RichText
        text: "Strona internetowa: <a href=\"http://www.maemo-forum.pl\">maemo-forum.pl</a>"
        onLinkActivated: Qt.openUrlExternally("http://maemo-forum.pl/meego-tablice-vt2066.htm");

        transitions: Transition {
            from: ""; to: "show"; reversible: false
            NumberAnimation { properties: "opacity"; duration: 3000; easing.type: Easing.InOutQuad }
        }

        states: State {
            name: "show";
            PropertyChanges { target: pageLabel; opacity: 1}
        }
    }
}
