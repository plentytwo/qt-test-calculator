import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

Item {
    signal clicked()
    property alias text: btnLabel.text;

    Layout.fillWidth: true;
    Layout.fillHeight: true;

    id: btnBase

    Rectangle {
        id: btnRect
        z: 1
        width: parent.width
        height: parent.height
        color: "#f3f3f3"
        radius: 3
    }

    Text {
        id: btnLabel
        z: 2
        anchors.centerIn: btnRect
        font.pixelSize: parent.height/2.5
        text: "1"
    }

    MouseArea {
        anchors.fill: btnRect
        z: 3
        onPressed: {
            btnShadow.horizontalOffset = 1
            btnShadow.verticalOffset = 1
            btnShadow.radius = 3
            btnRect.color = "#cdcdcd"
            btnLabel.font.pixelSize = btnBase.height / 2.6

            btnBase.clicked()
        }
        onReleased: {
            btnShadow.horizontalOffset = 3
            btnShadow.verticalOffset = 3
            btnShadow.radius = 6
            btnRect.color = "#f3f3f3"
            btnLabel.font.pixelSize = btnBase.height / 2.5
        }
    }

    DropShadow {
        id: btnShadow
        anchors.fill: btnRect
        horizontalOffset: 3
        verticalOffset: 3
        radius: 6
        samples: 10
        color: "#88000000"
        source: btnRect
    }
}
