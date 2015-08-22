import QtQuick 2.0
import "material"

Item {
  id: card
  implicitWidth: parent.width
  implicitHeight: layout.height + 32

  property string message: '--- DATA ---'
  property int timestamp: 0

  Column {
    id: layout

    anchors {
      top: parent.top
      left: parent.left
      right: parent.right

      margins: 16
    }

    Text {
      anchors.bottomMargin: 12
      text: message
      font.pixelSize: 18
    }
    Text {
      text: new Date(timestamp)
      color: '#999'
      font.pixelSize: 10
    }
  }


}
