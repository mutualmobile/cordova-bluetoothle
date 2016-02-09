var bleno = require('bleno');
var child = require('child_process');


var longUuid = function(uuid) {
  return '0000' + uuid + '-0000-1000-8000-00805f9b34fb';
};

var shortUuid = function(uuid) {
  return uuid.slice(4, 8);
};


var heartrate = new bleno.PrimaryService({
  uuid: longUuid('180D'),
  characteristics: [
    new bleno.Characteristic({
      uuid: longUuid('2A37'),
      properties: ['notify'],
      onSubscribe: function(maxValueSize, updateValueCallback) {
        this.updateValueCallback = updateValueCallback;
      },
      onUnsubscribe: function() {
        this.updateValueCallback = null;
      }
    })
  ]
});

function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

setInterval(function() {
  if (heartrate.characteristics[0].updateValueCallback) {
    var buffer = new Buffer([0,0,0,0,0,0,0,0]);
    buffer.writeUInt8(getRandomInt(60, 180), 1);
    heartrate.characteristics[0].updateValueCallback(buffer);
  }
}, 500);


var command = new bleno.PrimaryService({
  uuid: longUuid('FFF0'),
  characteristics: [
    new bleno.Characteristic({
      uuid: longUuid('FFF1'),
      properties: ['read', 'write'],
      onReadRequest: function(offset, callback) {
        callback(this.RESULT_SUCCESS, this.value);
      },
      onWriteRequest: function(data, offset, withoutResponse, callback) {
        this.value = data;
        callback(this.RESULT_SUCCESS);
      }
    }),
    new bleno.Characteristic({
      uuid: longUuid('FFF2'),
      properties: ['read', 'writeWithoutResponse'],
      onReadRequest: function(offset, callback) {
        callback(this.RESULT_SUCCESS, this.value);
      },
      onWriteRequest: function(data, offset, withoutResponse, callback) {
        this.value = data;
        callback(this.RESULT_SUCCESS);
      }
    }),
    new bleno.Characteristic({
      uuid: longUuid('FFF3'),
      properties: ['read', 'write'],
      onReadRequest: function(offset, callback) {
        callback(this.RESULT_SUCCESS, this.value);
      },
      onWriteRequest: function(data, offset, withoutResponse, callback) {
        this.value = data;
        var self = this;
        callback(self.RESULT_SUCCESS);
        /*
         *setTimeout(function() {
         *  callback(self.RESULT_SUCCESS);
         *}, 1000);
         */
        child.exec('blueutil power 0');
        setTimeout(function() {
          child.exec('blueutil power 1');
        }, 1000);
      }
    })
  ]
});


bleno.on('stateChange', function(state) {
  console.log('on -> stateChange: ' + state);

  if (state === 'poweredOn') {
    bleno.startAdvertising('BlePluginSim', [shortUuid(command.uuid), shortUuid(heartrate.uuid)]);
  } else {
    bleno.stopAdvertising();
  }
});


bleno.on('advertisingStart', function(error) {
  console.log('on -> advertisingStart: ' + (error ? 'error ' + error : 'success'));

  if (!error) {
    bleno.setServices([command, heartrate], function(error){
      console.log('setServices: '  + (error ? 'error ' + error : 'success'));
    });
  }
});
