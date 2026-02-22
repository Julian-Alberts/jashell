import Quickshell.Bluetooth
import Quickshell
import QtQuick
import "./bar"
import "./service/"

PanelWindow {
    id: topBar
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 30
    color: Config.background
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
