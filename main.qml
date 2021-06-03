import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: window

    //set this property to false if you have performance issue
    property bool enableDropShadow: true

    width: 1170; height: 860
    visible: true
    title: 'Credit Card Form'
    color: '#ddeefc'

    FontLoader {
        id: sourceSansProFont

        source: 'fonts/SourceSansPro-Regular.ttf'
        name: 'SourceSansPro'
    }

    FontLoader {
        id: sourceCodeProFont

        source: 'fonts/SourceCodePro-Medium.ttf'
        name: 'SourceCodePro'
    }

    Item {
        id: container

        anchors.fill: parent

        Rectangle {
            id: inputRect

            width: 580; height: 550
            radius: 10
            color: '#fff'
            anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 230 }

            layer.enabled: enableDropShadow
            layer.effect: DropShadow {
                radius: 60
                samples: radius * 2 + 1
                color: '#555a7494'
                verticalOffset: 20
            }

            GridLayout {
                columns: 3
                rows: 7
                columnSpacing: 12
                rowSpacing: 20
                anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 30 }

                Text {
                    text: 'Card Number'
                    color: '#1a3b5d'
                    font { pixelSize: 14; family: sourceSansProFont.name }
                    Layout.columnSpan: 3
                }

                CustomeTextField {
                    id: cardNumberTextField

                    width: 500; height: 50
                    maximumLength: 16
                    selectByMouse: true
                    selectionColor: '#3d9cff'
                    validator: RegularExpressionValidator { regularExpression: /\d{4}\d{4}\d{4}\d{4}/ }
                    Layout.columnSpan: 3
                    Layout.topMargin: -15

                    onFocusChanged: {
                        if (focus)
                            frontCard.focusRect.state = 'cardNumber'
                    }

                    onTextChanged: {
                        if (text.match('^4') != null) {
                            frontCard.cardTypeTumbler.frontItem = 1
                        }
                        else if (text.match('^5[1-5]') != null) {
                            frontCard.cardTypeTumbler.secondItem.source = 'images/mastercard.png'
                            frontCard.cardTypeTumbler.frontItem = 2
                        }
                        else if (text.match('^6011') != null) {
                            frontCard.cardTypeTumbler.secondItem.source = 'images/discover.png'
                            frontCard.cardTypeTumbler.frontItem = 2
                        }
                        else if (text.match('^9792') != null) {
                            frontCard.cardTypeTumbler.secondItem.source = 'images/troy.png'
                            frontCard.cardTypeTumbler.frontItem = 2
                        }
                        else {
                            frontCard.cardTypeTumbler.frontItem = 1
                        }
                    }
                }

                Text {
                    text: 'Card Holder'
                    color: '#1a3b5d'
                    font { pixelSize: 14; family: sourceSansProFont.name }
                    Layout.columnSpan: 3
                }

                CustomeTextField {
                    id: cardHolderTextField

                    property int lastLength: 0

                    width: 500; height: 50
                    maximumLength: 24
                    selectByMouse: true
                    selectionColor: '#3d9cff'
                    Layout.columnSpan: 3
                    Layout.topMargin: -15

                    onFocusChanged: {
                        if (focus)
                            frontCard.focusRect.state = 'cardHolder'
                    }

                    onTextChanged: {
                        if (length > lastLength) {
                            if (length - lastLength == 1)
                                frontCard.cardHolderName.insert(cursorPosition - 1, {'letter':  text[cursorPosition - 1]})
                            else
                                for (let i = length - lastLength; i > 0; i--)
                                    frontCard.cardHolderName.insert(cursorPosition - i, {'letter':  text[cursorPosition - i]})
                        }
                        else
                            frontCard.cardHolderName.remove(cursorPosition, lastLength - length)

                        lastLength = length
                    }
                }

                Text {
                    text: 'Expiration Date'
                    color: '#1a3b5d'
                    font { pixelSize: 14; family: sourceSansProFont.name }
                    Layout.columnSpan: 2
                }

                Text {
                    text: 'CVV'
                    color: '#1a3b5d'
                    font { pixelSize: 14; family: sourceSansProFont.name }
                    Layout.leftMargin: 25
                }

                CustomeComboBox {
                    id: monthComboBox

                    width: 150; height: 50
                    displayText: 'Month'
                    model: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
                    Layout.topMargin: -15

                    onFocusChanged: {
                        if (focus)
                            frontCard.focusRect.state = 'expireDate'
                    }
                }

                CustomeComboBox {
                    id: yearComboBox

                    width: 150; height: 50
                    displayText: 'Year'
                    model: ['2020', '2021', '2022', '2023', '2024', '2025', '2026', '2027', '2028',
                        '2029', '2030']
                    Layout.topMargin: -15

                    onFocusChanged: {
                        if (focus)
                            frontCard.focusRect.state = 'expireDate'
                    }
                }

                CustomeTextField {
                    id: cvvTextField

                    width: 150; height: 50
                    maximumLength: 4
                    selectByMouse: true
                    selectionColor: '#3d9cff'
                    validator: RegularExpressionValidator { regularExpression: /\d{4}/ }
                    Layout.topMargin: -15
                    Layout.leftMargin: 25

                    onFocusChanged: {
                        if (focus) {
                            frontCard.focusRect.state = 'hidden'
                        }
                        card.flipped = !card.flipped
                    }
                }

                CustomeButton {
                    id: submitButton

                    width: 500; height: 55
                    Layout.columnSpan: 3
                    Layout.topMargin: 25

                    onClicked: {
                        frontCard.focusRect.state = 'hidden'
                    }
                }
            }
        }

        Flipable {
            id: card

            property bool flipped: false
            property string backGroundNumber: Math.floor(Math.random() * 25 + 1)

            width: 440; height: 270
            anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 85 }

            layer.enabled: enableDropShadow
            layer.effect: DropShadow {
                radius: 60
                samples: radius * 2 + 1
                color: '#7c0e2a5a'
                verticalOffset: 15
            }

            front: FrontCard { id: frontCard }

            back: BackCard { id: backCard }

            transform: Rotation {
                id: rotation
                origin.x: card.width / 2
                origin.y: card.height / 2
                axis.x: 0; axis.y: 1; axis.z: 0
                angle: 0
            }

            states: State {
                name: 'back'
                when: card.flipped

                PropertyChanges { target: rotation; angle: 180 }
            }

            transitions: Transition {
                NumberAnimation {
                    target: rotation
                    property: 'angle'
                    duration: 750
                    easing.type: Easing.InCubic
                }
            }
        }
    }
}
