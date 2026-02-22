import QtQuick
import Quickshell
import "../service/Config.qml"

Item {
    implicitWidth: text.implicitWidth
    implicitHeight: text.implicitHeight
    anchors.verticalCenter: parent.verticalCenter
    SystemClock {
        id: clock
        precision: SystemClock.minutes
    }
    Text {
        id: text
        text: Qt.formatDateTime(clock.date, "hh:mm")
        color: "#a9b1d6"
        font.weight: 800
    }
}
