import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../service" as Service
import "../Config" as Config
import "../popup" as Popup
import "./Components"

Item {
    id: root
    property ShellScreen screen
    property Config.Settings.SideBar settings: Config.Settings.getLayout(screen).sidebar
    anchors.fill: parent
    implicitWidth: 50
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: ev => {
            Popup.Settings.visible = true;
            Popup.Settings.anchor.item = root;
            Popup.Settings.anchor.rect.y = ev.y - Popup.Settings.height / 2;
            Popup.Settings.anchor.edges = Edges.Right;
        }
    }
    Column {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        spacing: 10
        Repeater {
            model: root.settings.components.top
            Loader {
                id: topLoader
                required property string modelData
                anchors {
                    left: parent.left
                    right: parent.right
                }
                source: Quickshell.shellDir + "/Sidebar/Components/" + modelData + ".qml"
                Binding {
                    target: topLoader.item
                    property: "screen"
                    value: root.screen
                    when: topLoader.item && topLoader.item.hasOwnProperty("screen")
                }
            }
        }
    }
    Column {
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        spacing: 10
        Repeater {
            model: root.settings.components.center
            Loader {
                id: centerLoader
                required property string modelData
                anchors {
                    left: parent.left
                    right: parent.right
                }
                source: Quickshell.shellDir + "/Sidebar/Components/" + modelData + ".qml"
                Binding {
                    target: centerLoader.item
                    property: "screen"
                    value: root.screen
                    when: centerLoader.item && centerLoader.item.hasOwnProperty("screen")
                }
            }
        }
    }
    Column {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        spacing: 10
        Repeater {
            model: root.settings.components.bottom
            Loader {
                id: bottomLoader
                required property string modelData
                anchors {
                    left: parent.left
                    right: parent.right
                }
                source: Quickshell.shellDir + "/Sidebar/Components/" + modelData + ".qml"
                Binding {
                    target: bottomLoader.item
                    property: "screen"
                    value: root.screen
                    when: bottomLoader.item && bottomLoader.item.hasOwnProperty("screen")
                }
            }
        }
    }
}
