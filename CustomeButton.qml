import QtQuick 2.9
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Button {
    id: button

    layer.enabled: enableDropShadow
    layer.effect: DropShadow {
        radius: 20
        samples: radius * 2 + 1
        color: '#4d2364d2'
        horizontalOffset: 3
        verticalOffset: 10
    }

    background: Rectangle {
        implicitWidth: button.width
        implicitHeight: button.height
        radius: 5
        color: '#2364d2'
        visible: false

        Rectangle {
            id: indicator

            property int mx
            property int my

            x: mx - width / 2
            y: my - height / 2
            height: width
            radius: width / 2
            color: Qt.lighter('#2364d2')
        }  
    }

    Rectangle {
        id: mask

        radius: 5
        visible: false
        anchors.fill: parent
    }

    OpacityMask {
        source: background
        maskSource: mask
        anchors.fill: background
    }

    contentItem: Text {
        text: 'Submit'
        color: '#fff'
        font { pixelSize: 22; family: sourceSansProFont.name }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        id: mouseArea

        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
    }

    ParallelAnimation {
        id: anim

        NumberAnimation {
            target: indicator
            property: 'width'
            from: 0
            to: button.width * 2.5
            duration: 500
        }

        NumberAnimation {
            target: indicator;
            property: 'opacity'
            from: 0.5
            to: 0
            duration: 1000
        }
    }

    onPressed: {
        indicator.mx = mouseArea.mouseX
        indicator.my = mouseArea.mouseY
        anim.restart();
    }
}
