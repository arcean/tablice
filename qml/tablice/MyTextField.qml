import QtQuick 1.0
import com.nokia.meego 1.0

TextField {
    platformStyle: TextFieldStyle {
        backgroundSelected: Qt.resolvedUrl("/usr/share/themes/blanco/meegotouch/images/theme/" + appWindow.__ACTIVE_COLOR + "/" + appWindow.__ACTIVE_COLOR + "-meegotouch-textedit-background-selected.png")
        backgroundDisabled: Qt.resolvedUrl("/usr/share/themes/blanco/meegotouch/images/theme/" + appWindow.__ACTIVE_COLOR + "/" + appWindow.__ACTIVE_COLOR + "-meegotouch-textedit-background-disabled.png")
        backgroundError: Qt.resolvedUrl("/usr/share/themes/blanco/meegotouch/images/theme/" + appWindow.__ACTIVE_COLOR + "/" + appWindow.__ACTIVE_COLOR + "-meegotouch-textedit-background-error.png")
    }
}
