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

    ListModel {
        id: decModel

        ListElement { txt: "7"; fn: "value " }
        ListElement { txt: "8"; fn: "value " }
        ListElement { txt: "9"; fn: "value " }
        ListElement { txt: "/"; fn: "symbol" }
        ListElement { txt: "4"; fn: "value " }
        ListElement { txt: "5"; fn: "value " }
        ListElement { txt: "6"; fn: "value " }
        ListElement { txt: "*"; fn: "symbol" }
        ListElement { txt: "1"; fn: "value " }
        ListElement { txt: "2"; fn: "value " }
        ListElement { txt: "3"; fn: "value " }
        ListElement { txt: "-"; fn: "symbol" }
        ListElement { txt: "0"; fn: "value " }
        ListElement { txt: "."; fn: "value " }
        ListElement { txt: "="; fn: "solve " }
        ListElement { txt: "+"; fn: "symbol" }
    }

    ListModel {
        id: hexModel

        ListElement { txt: "d"; fn: "value";  }
        ListElement { txt: "e"; fn: "value";  }
        ListElement { txt: "f"; fn: "value";  }
        ListElement { txt: "a"; fn: "value"; column: 0; row: 1 }
        ListElement { txt: "b"; fn: "value";  }
        ListElement { txt: "c"; fn: "value";  }
        ListElement { txt: "7"; fn: "value"; column: 0; row: 2 }
        ListElement { txt: "8"; fn: "value";  }
        ListElement { txt: "9"; fn: "value";  }
        ListElement { txt: "/"; fn: "symbol"; }
        ListElement { txt: "4"; fn: "value";  }
        ListElement { txt: "5"; fn: "value";  }
        ListElement { txt: "6"; fn: "value";  }
        ListElement { txt: "*"; fn: "symbol"; }
        ListElement { txt: "1"; fn: "value";  }
        ListElement { txt: "2"; fn: "value";  }
        ListElement { txt: "3"; fn: "value";  }
        ListElement { txt: "-"; fn: "symbol"; }
        ListElement { txt: "0"; fn: "value";  }
        ListElement { txt: "."; opacity: .1 }
        ListElement { txt: "="; fn: "solve"; }
        ListElement { txt: "+"; fn: "symbol"; }
    }

    Component {
        id: buttonDelegate
        CalcButton {
            text: model.txt
            onClicked: model.fn ? model.fn === "value" ? value(text) : model.fn === "symbol" ? symbol(text) : solve() : {}
            Layout.column: model.col || {}
            Layout.row: model.row || {}
            opacity: model.opacity || 1
        }
    }

    GridLayout {
        visible: isHEX;

        anchors.fill: parent
        anchors.topMargin: 165
        anchors.margins: 12

        columns: 4
        rowSpacing: 12
        columnSpacing: 12

        Repeater {
            model: hexModel
            delegate: buttonDelegate
        }
    }
    
    GridLayout {
        visible: !isHEX

        anchors.fill: parent
        anchors.topMargin: 165
        anchors.margins: 12

        columns: 4
        rowSpacing: 12
        columnSpacing: 12

        Repeater {
            model: decModel
            delegate: buttonDelegate
        }
    }
}
