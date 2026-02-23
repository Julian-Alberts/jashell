import QtQuick
import "../service"
Item {
    id: root
    implicitHeight: parent.implicitHeight
    implicitWidth: tickerText.implicitWidth > maxWidth ? maxWidth : tickerText.implicitWidth
    clip: true
    property string message: ""
    property var textStyle: {return {color: Config.textColor, bold: true}}
    property int speed: 40
    property int maxWidth: 300
    onMessageChanged: {
        tickerAnimation.restart()
    }

    Row {
        id: tickerRow
        spacing: 50
        x: 0
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: tickerText
            text: root.message
            color: root.textStyle.color
            font.bold: root.textStyle.bold
        }
        Text {
            text: root.message
            color: root.textStyle.color
            font.bold: root.textStyle.bold
        }
        SequentialAnimation {
            id: tickerAnimation
            loops: Animation.Infinite
            running: tickerText.implicitWidth > root.implicitWidth

            NumberAnimation {
                target: tickerRow
                property: "x"
                from: 0
                to: -(tickerText.width + tickerRow.spacing)
                duration: (tickerText.width + tickerRow.spacing) / root.speed * 1000
                easing.type: Easing.Linear
            }

            // Optional pause before restarting
            PauseAnimation { duration: 0 }
        }
    }
    visible: message !== ""
}
