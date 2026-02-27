import QtQuick
import Quickshell
import "../service"

Item {
    implicitWidth: text.implicitWidth
    anchors.verticalCenter: parent.verticalCenter
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    Text {
        id: text
        text: Qt.formatDateTime(clock.date, "yyyy-MM-ddThh:mm")
        color: Config.theme.colors.text
        font.bold: true
    }
}
