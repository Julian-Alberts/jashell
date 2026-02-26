pragma Singleton
import QtQuick
import QtQuick.Controls
import Quickshell
import "../service"

JaPopupWindow {
    id: root
    property var menu
    implicitHeight: menuLoader.height > 100 ? menuLoader.height + 8 : 100
    implicitWidth: menuLoader.width > 100 ? menuLoader.width + 8 : 100
    anchor {
        rect.x: 20
    }
    Loader {
        id: menuLoader
        x: 4
        y: 4
        active: root.menu !== undefined
        sourceComponent: menuComponent
        Component.onCompleted: {
            console.log("Size: " + menuLoader.width + "x" + menuLoader.height);
        }
    }
    Component {
        id: menuComponent
        Item {
            width: menuList.width
            height: menuList.height
            ListView {
                id: menuList
                width: contentItem.childrenRect.width
                implicitHeight: contentItem.childrenRect.height
                model: menuOpener.children.values.filter(item => !!item)
                onModelChanged: {
                    this.forceLayout();
                }
                spacing: 2
                delegate: Rectangle {
                    implicitWidth: itemLoader.width
                    implicitHeight: itemLoader.height
                    color: "transparent"
                    Loader {
                        id: itemLoader
                        source: {
                            if (modelData.isSeparator) {
                                return "../Components/SystemTray/Menu/Separator.qml";
                            }
                            switch (modelData.buttonType) {
                            case QsMenuButtonType.CheckBox:
                                return "../Components/SystemTray/Menu/CheckBox.qml";
                            case QsMenuButtonType.Radio:
                                return "../Components/SystemTray/Menu/RadioButton.qml";
                            case QsMenuButtonType.None:
                            default:
                                return "../Components/SystemTray/Menu/Button.qml";
                            }
                        }
                        Binding {
                            target: itemLoader.item
                            property: "menuWidth"
                            value: menuList.width
                            when: itemLoader.status == Loader.Ready
                        }
                        Binding {
                            target: itemLoader.item
                            property: "handle"
                            value: modelData
                            when: itemLoader.status == Loader.Ready
                        }
                    }
                }
            }
            onWidthChanged: {}
            QsMenuOpener {
                id: menuOpener
                menu: root.menu
            }
        }
    }
}
