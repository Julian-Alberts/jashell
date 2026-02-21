import QtQuick
import "../service/"

Rectangle {
    id: root

    radius: 50

    Component.onCompleted: {}
    implicitHeight: parent.implicitHeight

    Row {
        id: row
        spacing: 8
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: Niri.workspaces

            Item {
                implicitWidth: 10
                implicitHeight: 10

                Rectangle {
                    anchors.fill: parent
                    radius: 5
                    color: model.isActive ? "green" : "yellow"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Niri.focusWorkspaceById(model.id)
                    }

                    Behavior on scale {
                        PropertyAnimation {
                            duration: 150
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 150
                        }
                    }
                }
            }
        }
    }
}
