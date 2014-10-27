var bleno = require('bleno');

var heartrate = new bleno.PrimaryService({
  uuid: '0000' + '180d' + '-0000-1000-8000-00805f9b34fb',
  characteristics: [
    new bleno.Characteristic({
      uuid: '0000' + '2a37' + '-0000-1000-8000-00805f9b34fb',
      properties: ['notify']
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
  uuid: '0000' + 'fff0' + '-0000-1000-8000-00805f9b34fb',
  characteristics: [
    new bleno.Characteristic({
      uuid: '0000' + 'fff1' + '-0000-1000-8000-00805f9b34fb',
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
      uuid: '0000' + 'fff2' + '-0000-1000-8000-00805f9b34fb',
      properties: ['read', 'writeWithoutResponse'],
      onReadRequest: function(offset, callback) {
        callback(this.RESULT_SUCCESS, this.value);
      },
      onWriteRequest: function(data, offset, withoutResponse, callback) {
        this.value = data;
        callback(this.RESULT_SUCCESS);
      }
    })
  ]
});


var services = [
  heartrate,
  command
];


bleno.setServices(services, console.error);

bleno.on('stateChange', function(state) {
  console.log('on -> stateChange: ' + state);

  if (state === 'poweredOn') {
    bleno.startAdvertising('BlePluginSim', [heartrate.uuid, command.uuid]);
  } else {
    bleno.stopAdvertising();
  }
});
