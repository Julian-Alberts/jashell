import Quickshell
import "../../Components"

RotateScreen {
    outputName: screen.name
    property ShellScreen screen
    anchors {
        left: parent.left
        right: parent.right
    }
    height: width
}
