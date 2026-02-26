import QtQuick
import "." as Menu

Menu.Base {
    id: root
    width: buttonText.width
    height: buttonText.height
    Text {
        id: buttonText
        text: root.handle.text
        color: root.currentTextColor
        font.pixelSize: 14
    }
}
