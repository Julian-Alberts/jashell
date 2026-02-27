import QtQuick
import QtQuick.Controls
import Quickshell

Item {
    implicitWidth: text.implicitWidth
    anchors.verticalCenter: parent.verticalCenter
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    Label {
        id: text
        text: Qt.formatDateTime(clock.date, "yyyy-MM-ddThh:mm")
        font.bold: true
    }
}
