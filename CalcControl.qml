import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

Item {
    signal value(string value)
    signal symbol(string value)
    signal command(string value)
    signal typeChange(string value)
    signal solve();

    property alias primaryValue: screen.primaryValue
    property alias secondaryValue: screen.secondaryValue

    property bool isHEX: false

    id: calcBase

    CalcScreen {
        id: screen

        x: 12
        y: 12
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 12
        height: 100
    }

    RowLayout {
        x: 0
        y: 124
        height: 25

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        
        CalcButton { text: "C";  onClicked: command("C"); }
        CalcButton { text: "CE"; onClicked: command("CE"); }
    }

    GridLayout {
        visible: isHEX;

        anchors.fill: parent
        anchors.topMargin: 165
        anchors.margins: 12

        columns: 4
        rowSpacing: 12
        columnSpacing: 12

        CalcButton { text: "d"; onClicked: value(text); }
        CalcButton { text: "e"; onClicked: value(text); }
        CalcButton { text: "f"; onClicked: value(text); }
        CalcButton { text: "a"; onClicked: value(text); Layout.column: 0; Layout.row: 1 }
        CalcButton { text: "b"; onClicked: value(text); }
        CalcButton { text: "c"; onClicked: value(text); }

        CalcButton { text: "7"; onClicked: value(text); Layout.column: 0; Layout.row: 2 }
        CalcButton { text: "8"; onClicked: value(text); }
        CalcButton { text: "9"; onClicked: value(text); }
        CalcButton { text: "/"; onClicked: symbol(text); }
        CalcButton { text: "4"; onClicked: value(text); }
        CalcButton { text: "5"; onClicked: value(text); }
        CalcButton { text: "6"; onClicked: value(text); }
        CalcButton { text: "*"; onClicked: symbol(text); }
        CalcButton { text: "1"; onClicked: value(text); }
        CalcButton { text: "2"; onClicked: value(text); }
        CalcButton { text: "3"; onClicked: value(text); }
        CalcButton { text: "-"; onClicked: symbol(text); }
        CalcButton { text: "0"; onClicked: value(text); }
        CalcButton { text: "."; opacity: .1 }
        CalcButton { text: "="; onClicked: solve(); }
        CalcButton { text: "+"; onClicked: symbol(text); }
    }
    
    GridLayout {
        visible: !isHEX

        anchors.fill: parent
        anchors.topMargin: 165
        anchors.margins: 12

        columns: 4
        rowSpacing: 12
        columnSpacing: 12

        CalcButton { text: "7"; onClicked: value(text); }
        CalcButton { text: "8"; onClicked: value(text); }
        CalcButton { text: "9"; onClicked: value(text); }
        CalcButton { text: "/"; onClicked: symbol(text); }
        CalcButton { text: "4"; onClicked: value(text); }
        CalcButton { text: "5"; onClicked: value(text); }
        CalcButton { text: "6"; onClicked: value(text); }
        CalcButton { text: "*"; onClicked: symbol(text); }
        CalcButton { text: "1"; onClicked: value(text); }
        CalcButton { text: "2"; onClicked: value(text); }
        CalcButton { text: "3"; onClicked: value(text); }
        CalcButton { text: "-"; onClicked: symbol(text); }
        CalcButton { text: "0"; onClicked: value(text); }
        CalcButton { text: "."; onClicked: value(text); }
        CalcButton { text: "="; onClicked: solve(); }
        CalcButton { text: "+"; onClicked: symbol(text); }
    }
}
