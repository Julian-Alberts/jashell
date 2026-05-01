import Quickshell
import "../Components"

RotateScreen {
    outputName: screen.name
    property ShellScreen screen
    iconSize: 30
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    width: height
    height: 30
}
