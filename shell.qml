//@ pragma UseQApplication
import Quickshell.Bluetooth
import Quickshell
import QtQuick
import QtQuick.Controls
import "./bar"
import "./Sidebar/"
import "./service/"
import "./Config/"

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: PanelWindow {
            id: topBar
            property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 30
            Bar {
                palette: Theme.palette
                screen: topBar.modelData
                implicitHeight: topBar.implicitHeight
            }
        }
    }
    Variants {
        model: Quickshell.screens
        delegate: PanelWindow {
            id: sideBar
            property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                bottom: true
            }
            implicitWidth: 50
            color: Config.theme.colors.background
            Sidebar {
                anchors.fill: parent
                screen: sideBar.modelData
            }
        }
    }
}
