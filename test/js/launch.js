(function() {

  var iterations = 0;

  var loop = function() {
    iterations++;
    mocha.run(function(status) {
      // 0 is success
      if (status === 0) {
        $('#mocha').empty();
        loop();
      }
      else {
        console.error('stopped. made it through ' + iterations + ' iterations.');
      }
    });
  };

  var ready = function() {
    return Promise.all([
      new Promise(function(resolve) {
        window.jQuery(document).ready(function() {
          console.log('document ready');
          resolve();
        });
      }),
      new Promise(function(resolve) {
        if (window.cordova) {
          document.addEventListener('deviceready', function() {
            console.log('device ready');
            resolve();
          }, false);
        }
        else {
          resolve();
        }
      })
    ]);
  };

  ready().then(function() {
    loop();
  });

})();
