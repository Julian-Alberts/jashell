import Quickshell.Bluetooth
import Quickshell
import QtQuick
import "./service"
import "./bar"

PanelWindow {
    id: topBar
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 30
    color: "#1a1b26"
    Bar {
        implicitHeight: topBar.implicitHeight
    }
    PanelWindow {
        anchors {
            top: true
            left: true
            bottom: true
        }
        implicitWidth: 50
        color: topBar.color
    }
}
