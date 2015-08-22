import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import "material"

ApplicationWindow {
  visible: true
  minimumWidth: 480
  minimumHeight: 600
  title: 'FeiWen Transport Chain'

  property string url: 'http://192.168.3.98:8000/'
  property string session
  property var postCollection: []

  property var loginValidate: function(instance) {
    // do ajax request regardless what input user made
    // url + 'auth?str=' + instance.text
    loginRequestEmitter.send(url + 'get?str=' + instance.text, 'GET', function(err, resp, xhr) {
      instance.enabled = true;
      if (err) {
        txtAccountErr.text = 'Oh, an error occurred: ' + err +'. Please check your internet connection.';
        txtAccountErr.visible = true;
      } else {
        txtAccountErr.text = '';
        txtAccountErr.visible = false;

        var l = [];
        JSON.parse(resp).list.forEach(function(v, i) {
          l.push(v);
        });

        postCollection = l;

        //console.log(resp);

        //session = xhr;
        //console.log(JSON.stringify(xhr.getAllResponseHeaders()));
        root.state = 'main';

      }
    });
    instance.enabled = false;
  }

  HttpRequestHelper {
    id: loginRequestEmitter
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
    // state: 'main'

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

      Label {
        id: txtAccountErr
        text: ''
        color: 'red'
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 12
        anchors.top: txtAccount.bottom
        anchors.topMargin: 20
      }
    }

    Rectangle {
      id: mainView
      width: parent.width
      height: parent.height
      anchors.left: loginView.right
      anchors.top: parent.top

      color: '#f3f3f3'

      Rectangle {
        id: navbar
        color: '#ddd'
        height: 56
        z: 20
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

      PaperShadow {
        z: 10
        source: navbar
        depth: 2
        cached: true
      }

      ListView {
        id: postList
        width: root.width
        anchors.fill: parent
        anchors.topMargin: navbar.height

        model: postCollection
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
              message: '#' + (index + 1) + '<br/>' + modelData.context
              timestamp: new Date(modelData.date)
            }
          }
        }
      }
      
    }

    Rectangle {
      id: messageModalOverlay
      anchors.fill: parent
      z: 100
//      visible: false
      color: '#aa000000'

      Rectangle {
        id: messageModal
        anchors.centerIn: parent
        width: parent.width - 20
        height: Math.min(parent.height * .6, 300)
        color: '#eee'
        z: 120
        radius: 4

        TextField {
          id: messageModalArea
          font.pixelSize: 28
          verticalAlignment: Text.AlignTop
          placeholderText: '發廢文囉！'
          anchors {
            fill: parent
            topMargin: 16
            leftMargin: 16
            rightMargin: 16
            bottomMargin: 56
          }
        }

        Button {
          id: messageSend
          anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 20
            bottomMargin: 20
          }
          text: '送出！'
          onClicked: {
            HttpRequestHelper.send(url + 'send?text=' + messageModalArea.text, 'POST', function(err, resp, xhr) {
              // ......
            });
          }
        }
      }
    }
  }
}
