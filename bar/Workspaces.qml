import QtQuick
import Qt.labs.qmlmodels 1.0
import "../service/"

Item {
    id: root
    property string output
    property bool multiple: false
    property string displayName

    Component.onCompleted: {}
    implicitHeight: 20
    implicitWidth: row.implicitWidth
    anchors.verticalCenter: parent.verticalCenter

    Row {
        id: row
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: root.displayName || root.output
            color: Config.textColor
            visible: root.multiple
            font.bold: true
        }

        SortFilterProxyModel {
            id: filteredWorkspaces
            model: Niri.workspaces

            filters: ValueFilter {
                roleName: "output"
                value: root.output
            }
        }

        Repeater {
            model: filteredWorkspaces
            delegate: Item {
                implicitWidth: 15
                implicitHeight: 15
                Component.onCompleted: {
                    console.debug(model.output);
                }

                Rectangle {
                    anchors.fill: parent
                    color: model.isActive ? "#c0caf5" : "#565f89"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Niri.focusWorkspaceById(model.id)
                    }

                    Text {
                        text: model.id
                        anchors.centerIn: parent
                        font.bold: true
                    }
                }
            }
        }
    }
}
