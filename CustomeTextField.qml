import QtQuick 2.15
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

TextField {
    id: textField

    color: '#1a3b5d'
    leftPadding: 15
    font { pixelSize: 17; family: sourceSansProFont.name }

    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: 5
        border.color: textField.focus | mouseArea.containsMouse ? '#3d9cff' : '#ced6e0'

        layer.enabled: enableDropShadow
        layer.effect: DropShadow {
            radius: 30
            samples: radius * 2 + 1
            color: textField.focus ? '#18203875' : 'transparent'
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
            cursorShape: Qt.IBeamCursor
            anchors.fill: parent
        }
    }
}
