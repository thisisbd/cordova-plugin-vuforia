var VuforiaPlugin = {
  startVuforia: function(options, imageFoundCallback, errorCallback){
    var imageFile = options.databaseXmlFile;
    var imageTargets = options.targetList;
    var overlayCopy = options.overlayMessage;
    var vuforiaLicense = options.vuforiaLicense;
    var showAndroidCloseButton = options.showAndroidCloseButton?true:false;

    cordova.exec(

      // Register the callback handler
      function callback(data) {
        imageFoundCallback(data);
      },
      // Register the error handler
      function errorHandler(err) {
        if(typeof errorCallback !== 'undefined') {
          errorCallback(err);
        }
      },
      // Define what class to route messages to
      'VuforiaPlugin',
      // Execute this method on the above class
      'cordovaStartVuforia',
      // An array containing one String.
      [ imageFile , imageTargets, overlayCopy, vuforiaLicense, showAndroidCloseButton ]
    );
  },

  dismiss: function(success, errorCallback){
    cordova.exec(

      // Register the callback handler
        success,
      // Register the error handler
      function errorHandler(err) {
        if(typeof errorCallback !== 'undefined') {
          errorCallback(err);
        }
      },
      // Define what class to route messages to
      'VuforiaPlugin',
      // Execute this method on the above class
      'cordovaStopVuforia',
      // An array containing one String.
      []
    );
  }
};
module.exports = VuforiaPlugin;
