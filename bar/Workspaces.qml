import QtQuick
import "../service/"

Item {
    id: root
    property string output

    Component.onCompleted: {}
    implicitHeight: 30
    implicitWidth: row.implicitWidth

    Row {
        id: row
        spacing: 8
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: root.output
            color: Config.textColor
        }

        Repeater {
            model: Niri.workspaces
            delegate: Item {
                implicitWidth: 10
                implicitHeight: 10
                visible: model.output == root.output
                Component.onCompleted: {
                    console.debug(model.output);
                }

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
