import QtQuick
import QtQuick.Controls
import "../../Config"

CheckBox {
    id: root
    contentItem: Label {
        text: parent.text
        color: Theme.colors.text
        leftPadding: 20
    }
}
