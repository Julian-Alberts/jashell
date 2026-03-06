import QtQuick
import QtQuick.Controls
import Quickshell
import "../../Config"

Item {
    implicitWidth: text.implicitWidth
    anchors.verticalCenter: parent.verticalCenter
    SystemClock {
        id: clock
        precision: Settings.clock.format.includes('ss') ? SystemClock.Seconds : SystemClock.Minutes
    }
    Label {
        id: text
        text: Qt.formatDateTime(clock.date, Settings.clock.format)
        font.bold: true
    }
}
