import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: tumbler

    property var firstItem
    property var secondItem
    property int frontItem: 1

    clip: true

    ParallelAnimation {
        id: showSecond

        NumberAnimation {
            target: firstItem
            properties: 'y'
            to: -firstItem.height / 2
            duration: 250
        }

        NumberAnimation {
            target: firstItem
            properties: 'opacity'
            to: 0
            duration: 300
        }

        NumberAnimation {
            target: secondItem
            properties: 'y'
            to: 0
            duration: 250
        }

        NumberAnimation {
            target: secondItem
            properties: 'opacity'
            to: 1
            duration: 300
        }
    }

    ParallelAnimation {
        id: showFirst

        NumberAnimation {
            target: firstItem
            properties: 'y'
            to: 0
            duration: 250
        }

        NumberAnimation {
            target: firstItem
            properties: 'opacity'
            to: 1
            duration: 300
        }

        NumberAnimation {
            target: secondItem
            properties: 'y'
            to: secondItem.height / 2
            duration: 250
        }

        NumberAnimation {
            target: secondItem
            properties: 'opacity'
            to: 0
            duration: 300
        }
    }

    onFrontItemChanged: {
        frontItem == 1 ? showFirst.restart() : showSecond.restart()
    }

    Component.onCompleted: {
        secondItem.y = secondItem.height / 2
        secondItem.opacity = 0
    }
}

