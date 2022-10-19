import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import com.qt.calculatorbrains 1.0
import com.qt.texttranslator 1.0

Window {
    visible: true

    id: wnd
    title: qsTr("Calculator") + textTranslator.emptyString

    width: 400
    height: 480

    property bool sidebarOpened: false

    minimumHeight: height
    maximumHeight: height

    minimumWidth: width
    maximumWidth: width

    CalculatorBrains {
        id: calculatorBrains
    }

    TextTranslator {
        id: textTranslator
    }

    CalcControl {
        id: calculatorInterface

        width: 370
        height: parent.height

        primaryValue: calculatorBrains.primaryValue
        secondaryValue: calculatorBrains.secondaryValue

        onValue: function (key) {
            console.log("inputting...", key)
            calculatorBrains.pushValue(key)
        }

        onSymbol: function (sym) {
            console.log("symbol input is", sym)
            calculatorBrains.pushSymbol(sym)
        }

        onCommand: function (cmd) {
            console.log("command input is", cmd)
            calculatorBrains.pushCommand(cmd)
        }

        onSolve: function () {
            console.log("solving")
            calculatorBrains.solve();
        }
    }

    Rectangle {
        id: sidebar

        x: 370
        y: 0
        width: 200
        height: parent.height
        color: "purple"

        Text {
            id: sidebarArrow
            text: sidebarOpened ? "<" : ">"
            color: "#fff"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            leftPadding: 5

            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pixelSize: 20
        }

        Item {
            id: sidebarContent

            x: 30
            y: 0
            width: 170
            height: parent.height
            opacity: 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }

            GroupBox {
                title: qsTr("Calculator Mode") + textTranslator.emptyString

                x: 10
                y: 20
                width: 150
                height: 100

                ExclusiveGroup {
                    id: baseRadioGroup
                }

                ColumnLayout {
                    RadioButton {
                        checked: true
                        exclusiveGroup: baseRadioGroup
                        onClicked: { calculatorBrains.pushTypeChange("DEC"); calculatorInterface.isHEX = false; }

                        text: "<font color='#fff'>DEC</font>"
                    }
                    RadioButton {
                        exclusiveGroup: baseRadioGroup
                        onClicked: { calculatorBrains.pushTypeChange("HEX"); calculatorInterface.isHEX = true; }

                        text: "<font color='#fff'>HEX</font>"
                    }
                }
            }
            GroupBox {
                title: qsTr("Language") + textTranslator.emptyString

                x: 10
                y: 120
                width: 150
                height: 100

                ExclusiveGroup {
                    id: localeRadioGroup
                }

                ColumnLayout {
                    RadioButton {
                        checked: true
                        exclusiveGroup: localeRadioGroup
                        onClicked: { textTranslator.selectLanguage("en") }

                        text: "<font color='#fff'>EN</font>"
                    }
                    RadioButton {
                        exclusiveGroup: localeRadioGroup
                        onClicked: { textTranslator.selectLanguage("de") }

                        text: "<font color='#fff'>DE</font>"
                    }
                    RadioButton {
                        exclusiveGroup: localeRadioGroup
                        onClicked: { textTranslator.selectLanguage("fr") }

                        text: "<font color='#fff'>FR</font>"
                    }
                }
            }
        }

        MouseArea {
            x: 0
            y: 0
            width: 30
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            onClicked: {
                sidebarOpened = !sidebarOpened

                wndAnimation.to = sidebarOpened ? 570 : 400
                wndAnimation.running = true
            }

        }

        NumberAnimation {
            id: wndAnimation
            target: wnd
            property: "width"
            duration: 300
            easing.type: Easing.OutExpo

            onRunningChanged: {
                if (!running && sidebarOpened) {
                    sidebarContent.opacity = 1;
                } else {
                    sidebarContent.opacity = 0;
                }
            }
        }
    }
}
