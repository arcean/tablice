import QtQuick 1.0
import com.nokia.meego 1.0

QueryDialog {
    id: dialog

    titleText: "<font color=\"" + __ACTIVE_COLOR_TEXT + "\">" + __APP_NAME + " " + APP_VERSION + "</font>"
    icon: "/usr/share/icons/hicolor/80x80/apps/tablice.png"
    message: "Program umożliwia przeglądanie listy najpopularniejszych samochodowych tablic rejestracyjnych w Polsce. <br><br> &copy; Tomasz Pieniążek 2011 - 2014<br> Ikony: snejki<br><br>"

    Component.onCompleted: {
        pageLabel.state = "show";
    }

    onRejected: {
        pageLabel.state = "hide";
    }

    Label {
        id: pageLabel
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height + 10
        font.pixelSize: __SMALL_FONT_SIZE
        opacity: 0
        textFormat: Text.RichText
        text: "Strona internetowa: <a href=\"http://www.openos.pl\">openos.pl</a>"
        onLinkActivated: Qt.openUrlExternally("http://forum.openos.pl/tablice-lista-tablic-rejestrcyjnych-t82.html");
        transitions: Transition {
            ParallelAnimation {
                NumberAnimation { properties: "y, z, opacity"; duration: 400; easing.type: Easing.InOutQuad }
            }
        }

        states: [
            State {
                name: "show";
                PropertyChanges { target: pageLabel; opacity: 1; }
                PropertyChanges { target: pageLabel; y: parent.height - pageLabel.height - 10; }
            },
            State {
                name: "hide";
                PropertyChanges { target: pageLabel; opacity: 0; }
                PropertyChanges { target: pageLabel; y: parent.height + 10; }
            }
        ]
    }
}
