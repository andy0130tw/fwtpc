import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import "material"

ApplicationWindow {
  visible: true
  minimumWidth: 480
  minimumHeight: 600
  title: 'Hello World'

  property var loginValidate: function(instance) {
    // do ajax request
    root.state = 'main';
  }

  Rectangle {
    id: root
    color: 'white'

    width: parent.width
    height: parent.height
    anchors.left: parent.left
    anchors.top: parent.top

    states: [
      State {
        name: 'main'
        AnchorChanges {
          target: loginView
          anchors.right: parent.left
        }
      }
    ]

    // state
    state: 'main'

    Rectangle {
      id: loginView
      width: parent.width
      height: parent.height
      anchors.left: parent.left
      anchors.top: parent.top

      Label {
        text: 'FeiWen Transport Chain'
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 60
        anchors.bottom: txtAccount.top
        font.pixelSize: 36
      }

      Label {
        text: 'Enter your authentication code...'
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 12
        anchors.bottom: txtAccount.top
      }

      TextField {
        id: txtAccount
        anchors.centerIn: parent
        font.pixelSize: 24
        font.family: 'Consolas'
        width: parent.width * .8
        onAccepted: {
          loginValidate(txtAccount);
        }
      }
    }

    Rectangle {
      id: mainView
      width: parent.width
      height: parent.height
      anchors.left: loginView.right
      anchors.top: parent.top

      Rectangle {
        id: navbar
        color: '#ddd'
        height: 56
        z: 2
        width: root.width
        
        Button {
          id: btnAddNewPost

          anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: 8
            topMargin: 8
            bottomMargin: 8
          }

          text: 'New...'
          width: root.width * .24
          style: ButtonStyle {
            label: Text {
              renderType: Text.NativeRendering
              verticalAlignment: Text.AlignVCenter
              horizontalAlignment: Text.AlignHCenter
              font.pixelSize: 28
              text: control.text
            }
          }
        }
      }
      
      ListView {
        id: postList
        width: root.width
        anchors.fill: parent
        anchors.topMargin: navbar.height

        model: 20
        topMargin: 8
        bottomMargin: 8
        leftMargin: 8
        rightMargin: 8
        spacing: 8

        delegate: Component {
          Card {
            id: _postCard
            width: parent.width - 16
            height: _postInnerPayout.height
            PostLayout {
              id: _postInnerPayout
              message: index
            }
          }
        }
      }
      
    }
  }
}
