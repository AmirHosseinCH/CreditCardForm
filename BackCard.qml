import QtQuick 2.9
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Item {
    id: backCard

    width: 440; height: 270

    Image {
        id: backCardImage

        source: 'images/' + card.backGroundNumber + '.jpeg'
        mirror: true
        anchors.fill: parent

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }

        Rectangle {
            id: mask

            radius: 15
            visible: false
            anchors.fill: parent
        }

        Rectangle {
            id: colorOverLay

            radius: 15
            color: '#06021d'
            opacity: 0.4
            anchors.fill: parent
        }

        Rectangle {
            id: blackBar

            width: parent.width; height: 50
            color: '#000013'
            opacity: 0.8
            anchors { top: parent.top; topMargin: 30 }
        }

        Rectangle {
            id: cvvBar

            width: parent.width - 30; height: 45
            radius: 5
            color: '#fff'
            anchors.centerIn: parent

            layer.enabled: enableDropShadow
            layer.effect: DropShadow {
                radius: 20
                samples: radius * 2 + 1
                color: Qt.rgba(0.10, 0.10, 0.10, 0.2)
                verticalOffset: 8
            }

            Text {
                text: 'CVV'
                color: '#fff'
                font { pixelSize: 15; family: sourceSansProFont.name }
                anchors { bottom: parent.top; right: parent.right; bottomMargin: 3 }
            }

            Text {
                id: cvvText

                text: '*'.repeat(cvvTextField.length)
                color: '#1a3b5d'
                rightPadding: 6
                font { pixelSize: 18; family: sourceSansProFont.name }
                anchors.fill: parent
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
            }
        }

        Image {
            width: 90; height: 45
            source: 'images/visa.png'
            sourceSize: Qt.size(width, height)
            opacity: 0.7
            anchors { bottom: parent.bottom; right: parent.right; margins: 23 }
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                cvvTextField.focus = false
                card.flipped = false
            }
        }
    }
}
