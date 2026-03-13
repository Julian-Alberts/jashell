import QtQuick
import QtQuick.Controls
import Quickshell
import "../Config/"
import "./Components"

Pane {
    id: root
    property ShellScreen screen
    property Settings.Layout layout: Settings.getLayout(screen)
    anchors.fill: parent
    Row {
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        height: root.height - 10
        spacing: 20
        Repeater {
            model: root.layout.topbar.components.left
            Loader {
                id: leftLoader
                required property string modelData
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }
                source: Quickshell.shellDir + "/bar/Components/" + modelData + ".qml"
                onLoaded: {
                    if (leftLoader.modelData === "Workspaces") {
                        item.settings.screen = root.screen;
                    }
                }
                Binding {
                    target: leftLoader.item
                    property: "screen"
                    value: root.screen
                    when: leftLoader.item && leftLoader.item.hasOwnProperty("screen")
                }
            }
        }
    }
    Row {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        height: root.height - 10
        spacing: 20
        Repeater {
            model: root.layout.topbar.components.right
            Loader {
                id: rightLoader
                required property string modelData
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }
                source: Quickshell.shellDir + "/bar/Components/" + modelData + ".qml"
                onLoaded: {
                    if (rightLoader.modelData === "Workspaces") {
                        item.settings.screen = root.screen;
                    }
                }
            }
        }
    }
}
