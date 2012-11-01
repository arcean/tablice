import QtQuick 1.1
import com.nokia.meego 1.0

Switch {
    platformStyle: SwitchStyle {
        switchOn: "image://theme/" + appWindow.__ACTIVE_COLOR + "-meegotouch-switch-on"+__invertedString
    }
}
