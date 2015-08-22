import QtQuick 2.0

QtObject {

    signal success(string data)
    signal error

    function send(url, method, callback) {

      method = method || 'GET';
      callback = callback || function(){};

      var xhr = new XMLHttpRequest();

      xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
          if (xhr.status >= 400) {
            error(xhr.status, xhr);
            callback(xhr.status, null, xhr);
          } else {
            success(xhr.responseText, xhr);
            callback(null, xhr.responseText, xhr);
          }
        }
      }

      xhr.open(method, url);
      xhr.send();
    }

}
