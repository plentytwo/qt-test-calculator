import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Item {
    id: screenBase

    Layout.fillWidth: true;
    Layout.fillHeight: true;

    property alias primaryValue: primaryText.text
    property alias secondaryValue: secondaryText.text

    function setValues(primary, secondary) {
        primaryText.text = primary
        secondaryText.text = secondary
    }

    Rectangle {
        id: screenRect
        z: 1
        width: parent.width
        height: parent.height
        color: "#c1d797"
        radius: 10
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        z: 2

        Text {
            id: secondaryText
            text: ""
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 22
        }

        Text {
            id: primaryText
            text: ""
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignRight
            font.pixelSize: parent.height/2
        }
    }

}
