import QtQuick
import "../../Config/"

Rectangle {
    id: root
    property string title
    color: "transparent"
    border.color: Theme.colors.text
    border.width: 1
    radius: 5
    Rectangle {
        color: Theme.colors.background
        radius: 5
        x: 10
        y: -height / 2
        width: titleText.width + 10
        height: titleText.height
        Text {
            id: titleText
            text: root.title
            color: Theme.colors.text
            font.bold: true
            anchors.centerIn: parent
        }
    }
}
