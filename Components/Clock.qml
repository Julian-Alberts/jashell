import QtQuick
import QtQuick.Layouts
import Quickshell
import "../Config"
import "../Components/Ui"

Item {
    id: root
    property bool multiLine: true
    property string separator: " "
    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth
    SystemClock {
        id: clock
        precision: Settings.clock.format.includes('ss') ? SystemClock.Seconds : SystemClock.Minutes
    }
    GridLayout {
        id: layout
        columns: root.multiLine ? 1 : -1
        rows: root.multiLine ? -1 : 1
        anchors {
            horizontalCenter: parent.horizontalCenter
        }
        Repeater {
            model: ScriptModel {
                values: Qt.formatDateTime(clock.date, Settings.clock.format).split(root.separator)
            }
            delegate: Label {
                required property string modelData
                Layout.alignment: root.multiLine ? Qt.AlignHCenter : Qt.AlignLeft
                text: modelData
                color: Theme.colors.text
                font.bold: true
            }
        }
    }
}
