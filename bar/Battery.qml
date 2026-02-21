import QtQuick
import QtQuick.Controls
import Quickshell.Services.UPower

Rectangle {
    id: root
    color: "gray"
    radius: 3
    implicitHeight: 20
    implicitWidth: 75
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 5
    ProgressBar {
        id: progressBar
        anchors.centerIn: parent
        implicitHeight: parent.implicitHeight - 10
        implicitWidth: parent.implicitWidth - 10
        from: 0
        to: 1
        value: UPower.displayDevice?.percentage ?? 1
        background: Rectangle {
            color: "white"
            radius: 4
        }
        contentItem: Item {
            implicitWidth: root.width - 10
            implicitHeight: root.height - 10
            Rectangle {
                implicitWidth: progressBar.visualPosition * parent.implicitWidth
                implicitHeight: parent.implicitHeight
                radius: progressBar.background.radius
                color: {
                    if (progressBar.value > .5)
                        return "#17a81a";
                    else if (progressBar.value > .3)
                        return "yellow";
                    else
                        return "red";
                }
            }
        }
    }
    Rectangle {
        color: parent.color
        width: 5
        height: 10
        topRightRadius: 3
        bottomRightRadius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors {
            left: parent.right
        }
    }

    Text {
        text: {
            const val = Math.floor(progressBar.value * 100);
            console.log(val);
            return val;
        }
        anchors.centerIn: progressBar
    }
    visible: UPower.displayDevice?.isLaptopBattery ?? false
}
