import QtQuick
import Quickshell

Item {
    property Settings settings: Settings {}
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    component Settings: QtObject {
        property ShellScreen screen
    }
}
