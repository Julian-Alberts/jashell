import Quickshell.Bluetooth
import Quickshell
import QtQuick
import "./bar"
import "./service/"

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: PanelWindow {
            property var modelData
            screen: modelData
            id: topBar
            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 30
            color: Config.background
            Bar {
                screen: modelData
                implicitHeight: topBar.implicitHeight
            }
        }
    }
    Variants {
        model: Quickshell.screens
        delegate: 
            PanelWindow {
            property var modelData
            screen: modelData
                anchors {
                    top: true
                    left: true
                    bottom: true
                }
                implicitWidth: 50
                color: Config.theme.colors.background
            }
    }
}
