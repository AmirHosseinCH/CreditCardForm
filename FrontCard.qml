import QtQuick 2.9
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Image {
    id: frontCard

    property alias cardHolderName: cardHolderName
    property alias focusRect: focusRect
    property alias cardTypeTumbler: cardTypeTumbler

    width: 440; height: 270
    source: 'images/' + card.backGroundNumber + '.jpeg'

    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: mask
    }

    Rectangle {
        id: mask

        width: frontCard.width; height: frontCard.height
        radius: 15
        visible: false
    }

    Rectangle {
        id: colorOverlay
        width: frontCard.width; height: frontCard.height
        radius: 15
        color: '#06021d'
        opacity: 0.4
    }

    Image {
        width: 65; height: 55
        source: 'images/chip.png'
        anchors { top: parent.top; left: parent.left; margins: 23 }
    }

    ItemTumbler {
        id: cardTypeTumbler
        width: 90; height: 45
        item1: visaCard
        item2: anotherCard
        frontItem: 1
        anchors { top: parent.top; right: parent.right; margins: 23 }

        Image {
            id: visaCard
            sourceSize: Qt.size(90, 45)
            source: 'images/visa.png'
        }

        Image {
            id: anotherCard
            sourceSize: Qt.size(90, 45)
            source: 'images/visa.png'
            y: height
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Row {
        id: rowNumber

        property int count: 0

        spacing: 28
        z: 1
        anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 30 }

        Repeater {
            model: 4

            Row {
                spacing: 0

                Repeater {
                    model: 4

                    delegate: ItemTumbler {
                        id: number

                        property int numberIndex

                        width: 17; height: 32
                        item1: numberPlaceHolder
                        item2: digit
                        frontItem: cardNumberTextField.text[numberIndex] === undefined ? 1 : 2

                        Text {
                            id: numberPlaceHolder

                            text: '#'
                            color: '#fff'
                            font { pixelSize: 28; family: sourceCodeProFont.name }
                        }

                        Text {
                            id: digit

                            function toProperFormat(letter, index) {
                                if (index >= 4 && index <= 11 )
                                    return '*'
                                else
                                    return letter
                            }

                            text: cardNumberTextField.text[numberIndex] !== undefined ?
                                      toProperFormat(cardNumberTextField.text[numberIndex], numberIndex) : null
                            color: '#fff'
                            font { pixelSize: 28; family: sourceCodeProFont.name }
                        }

                        Component.onCompleted: {
                            numberIndex = rowNumber.count++
                        }
                    }
                }
            }
        }
    }

    Column {
        id: cardHolderColumn

        spacing: 7
        z: 1
        anchors { left: parent.left; bottom: parent.bottom; leftMargin: 30; bottomMargin: 23 }

        Text {
            height: 10
            text: 'Card Holder'
            color: '#fff'
            opacity: 0.7
            font { pixelSize: 15; family: sourceSansProFont.name }
        }

        ItemTumbler {
            id: cardHolderTumbler

            width: 300; height: 25
            item1: nameplaceHolder
            item2: cardHolder
            frontItem: cardHolderTextField.length == 0 ? 1 : 2

            Text {
                id: nameplaceHolder

                text: 'FULL NAME'
                color: '#fff'
                font { pixelSize: 19; capitalization: Font.AllUppercase; family: sourceCodeProFont.name }
            }

            ListView {
                id: cardHolder

                width: 300; height: 25
                orientation: ListView.Horizontal
                interactive: false

                model: ListModel { id: cardHolderName }

                delegate: Text {
                    color: '#fff'
                    text: letter
                    transformOrigin: Item.BottomLeft
                    font { pixelSize: 19; capitalization: Font.AllUppercase; family: sourceCodeProFont.name }
                }

                add: Transition {
                    NumberAnimation { property: 'opacity'; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { property: 'rotation'; from: 65; to: 0; duration: 400 }
                }

                remove: Transition {
                    NumberAnimation { property: 'opacity'; from: 1.0; to: 0; duration: 400 }
                    NumberAnimation { property: 'rotation'; from: 0; to: 65; duration: 400 }
                }
            }
        }
    }

    Column {
        id: expireDateColumn

        spacing: 7
        z: 1
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 30; bottomMargin: 23 }

        Text {
            height: 10
            text: 'Expires'
            color: '#fff'
            opacity: 0.7
            font { pixelSize: 15; family: sourceCodeProFont.name }
        }

        Row {
            spacing: 0

            ItemTumbler {
                id: monthTumbler

                width: 23; height: 25
                item1: monthPlaceHolder
                item2: month
                frontItem: monthComboBox.displayText == 'Month' ? 1 : 2

                Text {
                    id: monthPlaceHolder

                    text: 'MM'
                    color: '#fff'
                    font { pixelSize: 19; family: sourceCodeProFont.name }
                }

                Text {
                    id: month

                    text: monthComboBox.displayText
                    color: '#fff'
                    opacity: 0
                    font { pixelSize: 19; family: sourceCodeProFont.name }
                }
            }

            Text {
                text: '/'
                color: '#fff'
                font { pixelSize: 19; family: sourceCodeProFont.name }
            }

            ItemTumbler {
                id: yearTumbler

                width: 23; height: 25
                item1: yearPlaceHolder
                item2: year
                frontItem: yearComboBox.displayText == 'Year' ? 1 : 2

                Text {
                    id: yearPlaceHolder

                    text: 'YY'
                    color: '#fff'
                    font { pixelSize: 19; family: sourceCodeProFont.name }
                }

                Text {
                    id: year

                    text: yearComboBox.displayText.substring(2, 4)
                    color: '#fff'
                    opacity: 0
                    font { pixelSize: 19; family: sourceCodeProFont.name }
                }
            }
        }
    }

    Rectangle {
        id: focusRect

        width: parent.width - 10
        height: parent.height - 10
        radius: 5
        color: '#08142f'
        opacity: 0
        border { width: 2; color: Qt.rgba(1, 1, 1, 0.65) }
        z: 0

        states: [
            State {
                name: 'cardNumber'
                PropertyChanges {
                    target: focusRect
                    opacity: 0.5
                    width: rowNumber.width + 30
                    height: rowNumber.height + 15
                    x: rowNumber.x - 15
                    y: rowNumber.y - 6
                }
            },
            State {
                name: 'cardHolder'
                PropertyChanges {
                    target: focusRect
                    opacity: 0.5
                    width: cardHolderColumn.width + 20
                    height: cardHolderColumn.height + 10
                    x: cardHolderColumn.x - 15
                    y: cardHolderColumn.y - 5
                }
            },
            State {
                name: 'expireDate'
                PropertyChanges {
                    target: focusRect
                    opacity: 0.5
                    width: expireDateColumn.width + 30
                    height: expireDateColumn.height + 10
                    x: expireDateColumn.x - 15
                    y: expireDateColumn.y - 5
                }
            },
            State {
                name: 'hidden'
                PropertyChanges {
                    target: focusRect
                    opacity: 0.0
                    width: card.width
                    height: card.width
                }
            }
        ]
        transitions: [
            Transition {
                from: '*'
                to: '*'
                NumberAnimation {
                    properties: 'opacity,width,height,x,y'
                    duration: 400
                    easing.type: Easing.InCubic
                }
            }
        ]
    }
}
