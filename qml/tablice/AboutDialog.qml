import QtQuick 1.0
import com.nokia.meego 1.0

QueryDialog {
    id: dialog

    titleText: "Tablice " + _APP_VERSION
    icon: "/usr/share/icons/hicolor/80x80/apps/tablice.png"
    message: "Program umożliwia przeglądanie listy najpopularniejszych samochodowych tablic rejestracyjnych w Polsce. <br><br> &copy; Tomasz Pieniążek 2011, 2012<br> Ikony: snejki<br><br>"

    Component.onCompleted: {
        pageLabel.state = "show"
    }

    Label {
        id: pageLabel
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height + 10
        font.pixelSize: _STANDARD_FONT_SIZE
        opacity: 0
        textFormat: Text.RichText
        text: "Strona internetowa: <a href=\"http://www.meegoforum.pl\">meegoforum.pl</a>"
        onLinkActivated: Qt.openUrlExternally("http://www.meegoforum.pl/viewtopic.php?f=56&t=82");
        transitions: Transition {
            from: ""; to: "show"; reversible: false
            ParallelAnimation {
                NumberAnimation { properties: "y, z, opacity"; duration: 3000; easing.type: Easing.InOutQuad }
            }
        }

        states: State {
            name: "show";
            PropertyChanges { target: pageLabel; opacity: 1}
            PropertyChanges { target: pageLabel; y: parent.height - pageLabel.height - 10; z:0}
        }
    }
}
