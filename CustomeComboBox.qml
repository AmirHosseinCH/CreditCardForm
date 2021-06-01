import QtQuick 2.15
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

ComboBox {
    id: comboBox

    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: 5
        border.color: comboBox.focus | mouseArea.containsMouse ? '#3d9cff' : '#ced6e0'

        layer.enabled: enableDropShadow
        layer.effect: DropShadow {
            radius: 30
            samples: radius * 2 + 1
            color: comboBox.focus ? '#18203875' : 'transparent'
            verticalOffset: 10

            ColorAnimation on color {
                duration: 150
            }
        }

        ColorAnimation on border.color {
            duration: 150
        }

        MouseArea {
            id: mouseArea

            hoverEnabled: true
            acceptedButtons: Qt.NoButton
            anchors.fill: parent
        }
    }

    indicator: Image {
        source: 'images/arrow-down.svg'
        sourceSize: Qt.size(13, 13)
        x: (comboBox.width - width) - 15
        y: (comboBox.height - height) / 2
    }

    popup: Popup {
        width: comboBox.width; height: 300
        y: -height

        contentItem: ListView {
            spacing: 5
            clip: true
            model: comboBox.popup.visible ? comboBox.delegateModel : null
            ScrollIndicator.vertical: ScrollIndicator {}
        }

        background: Rectangle {
            radius: 5
            border.color: '#ced6e0'
        }
    }

    delegate: ItemDelegate {
        width: comboBox.width

        contentItem: Text {
            text: modelData
            color: '#1a3b5d'
            font.family: sourceSansProFont.name
        }

        background: Rectangle {
            width: 115; height: 40
            radius: 5
            color: popUpMouseArea.containsMouse ? Qt.rgba(0, 0, 0, 0.1) : 'transparent'

            MouseArea {
                id: popUpMouseArea

                hoverEnabled: true
                anchors.fill: parent

                onClicked: {
                    comboBox.displayText = modelData
                    comboBox.popup.visible = false
                }
            }
        }
    }

    contentItem: Text {
        text: comboBox.displayText
        color: '#1a3b5d'
        font.family: sourceSansProFont.name
        leftPadding: 15
        verticalAlignment: Text.AlignVCenter
    }
}
