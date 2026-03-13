import QtQuick
import Quickshell

Loader {
    id: root
    required property string name
    property ShellScreen screen
    required property string namespace
    source: Quickshell.shellDir + "/" + namespace + "/Components/" + root.name + ".qml"
    Binding {
        target: root.item
        property: "screen"
        value: root.screen
        when: root.item && root.item.hasOwnProperty("screen")
    }
}
