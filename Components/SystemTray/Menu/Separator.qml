import QtQuick
import "." as Menu
import "../../../service"

Menu.Base {
    id: root
    width: menuWidth
    height: 2
    Rectangle {
        anchors.fill: parent
        color: Config.theme.colors.text
    }
}
