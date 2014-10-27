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

  document.addEventListener('deviceready', function() {
    loop();
  }, false);

})();
