import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: tumbler

    property var item1
    property var item2
    property int frontItem: 1

    clip: true

    ParallelAnimation {
        id: anim1

        NumberAnimation {
            target: item1
            properties: 'y'
            to: -item1.height / 2
            duration: 200
        }

        NumberAnimation {
            target: item1
            properties: 'opacity'
            to: 0
            duration: 200
        }

        NumberAnimation {
            target: item2
            properties: 'y'
            to: 0
            duration: 200
        }

        NumberAnimation {
            target: item2
            properties: 'opacity'
            to: 1
            duration: 200
        }
    }

    ParallelAnimation {
        id: anim2

        NumberAnimation {
            target: item1
            properties: 'y'
            to: 0
            duration: 250
        }

        NumberAnimation {
            target: item1
            properties: 'opacity'
            to: 1
            duration: 300
        }

        NumberAnimation {
            target: item2
            properties: 'y'
            to: item2.height / 2
            duration: 250
        }

        NumberAnimation {
            target: item2
            properties: 'opacity'
            to: 0
            duration: 300
        }
    }

    onFrontItemChanged: {
        frontItem == 1 ? anim2.restart() : anim1.restart()
    }
}
