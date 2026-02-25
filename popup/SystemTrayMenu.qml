pragma Singleton
import QtQuick
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
                model: menuOpener.children.values
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
                        sourceComponent: {
                            if (modelData.isSeparator) {
                                return menuSeparator;
                            }
                            switch (modelData.buttonType) {
                            case QsMenuButtonType.CheckBox:
                                return menuCheckBox;
                            case QsMenuButtonType.Radio:
                                return menuRadioButton;
                            case QsMenuButtonType.None:
                                return menuButton;
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
    Component {
        id: menuSeparator
        Rectangle {
            property QsMenuHandle handle
            property real menuWidth
            onMenuWidthChanged: {
                console.log("Menu width changed: " + menuWidth);
            }
            height: 2
            width: menuWidth
            anchors {
                margins: 5
            }
            color: Config.theme.colors.text
        }
    }
    Component {
        id: menuCheckBox
        Text {
            property QsMenuHandle handle
            property real menuWidth
            text: "Unimplemented checkbox"
            color: Config.theme.colors.red
        }
    }
    Component {
        id: menuRadioButton
        Text {
            property QsMenuHandle handle
            property real menuWidth
            text: "Unimplemented radio"
            color: Config.theme.colors.red
        }
    }
    Component {
        id: menuButton
        Rectangle {
            property QsMenuHandle handle
            property real menuWidth
            width: buttonText.implicitWidth
            height: buttonText.implicitHeight
            color: hoverHandler.hovered ? Config.theme.colors.text : Config.theme.colors.background
            Text {
                id: buttonText
                text: parent.handle.text
                color: hoverHandler.hovered ? Config.theme.colors.background : Config.theme.colors.text
                font.pixelSize: 14
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    handle.triggered();
                }
                cursorShape: Qt.PointingHandCursor
            }
            HoverHandler {
                id: hoverHandler
            }
        }
    }
}
