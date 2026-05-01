import QtQuick
import QtQuick.Controls
import Quickshell
import "../../Config/"
import "../Topbar"
import ".."

Pane {
    id: root
    property ShellScreen screen
    property Settings.Layout layout: Settings.getLayout(screen)
    anchors.fill: parent
    DynCompRow {
        componentNames: root.layout.topbar.components.left
        screen: root.screen
        anchors.left: parent.left
    }
    DynCompRow {
        componentNames: root.layout.topbar.components.right
        screen: root.screen
        anchors.right: parent.right
    }
    component DynCompRow: Row {
        id: root
        required property list<string> componentNames
        required property ShellScreen screen
        anchors {
            verticalCenter: parent.verticalCenter
        }
        height: 20
        spacing: 20
        Repeater {
            model: root.componentNames
            DynComponent {
                id: leftLoader
                required property string modelData
                namespace: "bar"
                name: modelData
                screen: root.screen
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }
                source: Quickshell.shellDir + "/bar/" + modelData + ".qml"
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
                source: Quickshell.shellDir + "/bar/" + modelData + ".qml"
                onLoaded: {
                    if (rightLoader.modelData === "Workspaces") {
                        item.settings.screen = root.screen;
                    }
                }
            }
        }
    }
}
