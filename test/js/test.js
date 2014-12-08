describe('bluetoothle', function() {

  this.timeout(10000);
  this.bail(true);


  before(function(done) {
    var device = sessionStorage.getItem('device');
    if (device) {
      bluetoothle.disconnect(device).then(bluetoothle.stopDiscovery, bluetoothle.stopDiscovery).then(function() { done(); }, function() { done(); });
    }
    setTimeout(done, 5000);
  });


  it('getAdapterState', function() {
    return bluetoothle.getAdapterState().then(function(state) {
      chai.assert.property(state, 'address');
      chai.assert.isString(state.address);
      chai.assert.property(state, 'name');
      chai.assert.isString(state.name);
      chai.assert.property(state, 'enabled');
      chai.assert.isBoolean(state.enabled);
      chai.assert.property(state, 'discovering');
      chai.assert.isBoolean(state.discovering);
      //console.log(state);
    });
  });


  var blueSimDevice = '';

  it('startDiscovery', function() {
    console.log("startDiscovery started");
    bluetoothle.on('deviceAdded', function(device) {
      if (device.name === 'BlePluginSim') {
        blueSimDevice = device;
        console.log('BLUESIM', device);
        bluetoothle.off('deviceAdded');
      }
    });

    return bluetoothle.startDiscovery().then(function(state) {
      console.log("startDiscovery state: "+state);
      console.log(state);
    });
  });


  it('onDeviceAdded', function(done) {
    var interval = setInterval(function() {
      if (blueSimDevice) {
        clearInterval(interval);

        chai.assert.property(blueSimDevice, 'address');
        chai.assert.property(blueSimDevice, 'name');
        chai.assert.property(blueSimDevice, 'rssi');
        //chai.assert.property(blueSimDevice, 'connected');
        chai.assert.property(blueSimDevice, 'uuids');
        chai.assert.isString(blueSimDevice.address);
        chai.assert.isString(blueSimDevice.name);
        chai.assert.isNumber(blueSimDevice.rssi);
        //chai.assert.isBoolean(blueSimDevice.connected);
        chai.assert.isArray(blueSimDevice.uuids);

        done();
      }
    }, 50);
  });


  it('stopDiscovery', function() {
    return bluetoothle.stopDiscovery();
  });


  it('connect', function() {
    sessionStorage.setItem('device', blueSimDevice.address);
    return bluetoothle.connect(blueSimDevice.address);
  });


  var services;
  var assertIsService = function(service) {
    chai.assert.property(service, 'uuid');
    chai.assert.property(service, 'isPrimary');
    chai.assert.property(service, 'instanceId');
    chai.assert.property(service, 'deviceAddress');
    chai.assert.isString(service.uuid);
    chai.assert.isBoolean(service.isPrimary);
    chai.assert.isString(service.instanceId);
    chai.assert.isString(service.deviceAddress);
  };


  var assertIsCharacteristic = function(characteristic) {
    chai.assert.property(characteristic, 'uuid');
    chai.assert.isString(characteristic.uuid);
    chai.assert.property(characteristic, 'service');
    chai.assert.isString(characteristic.service);
    chai.assert.property(characteristic, 'properties');
    chai.assert.isArray(characteristic.properties);
    chai.assert.property(characteristic, 'value');
    chai.assert((characteristic.value.toString().indexOf('ArrayBuffer') !== -1), 'characteristic value is not an ArrayBuffer');
  };


  it('getServices', function() {
    return bluetoothle.getServices(blueSimDevice.address).then(function(result) {
      console.log(result);
      services = result;
      chai.assert.isArray(result);
      result.forEach(function(service) {
        assertIsService(service);
      });
    });
  });


  it('getService', function() {
    return bluetoothle.getService(blueSimDevice.address, '180d').then(function(result) {
      console.log(result);
      assertIsService(result);
    });
  });


  var characteristics;


  it('getCharacteristics', function() {
    return bluetoothle.getCharacteristics(blueSimDevice.address, '180d').then(function(result) {
      console.log(result);
      characteristics = result;
      chai.assert.isArray(result);
      result.forEach(function(characteristic) {
        assertIsCharacteristic(characteristic);
      });
    });
  });


  it('getCharacteristic', function() {
    return bluetoothle.getCharacteristic(blueSimDevice.address, '180d', '2a37').then(function(result) {
      console.log(result);
      assertIsCharacteristic(result);
    });
  });


  var writeValue = 1;


  it('writeCharacteristicValue', function() {
    var buffer = new ArrayBuffer(1);
    var view = new DataView(buffer);
    view.setUint8(0, writeValue);
    return bluetoothle.writeCharacteristicValue(blueSimDevice.address, 'fff0', 'fff1', buffer);
  });


  it('readCharacteristicValue', function() {
    return bluetoothle.readCharacteristicValue(blueSimDevice.address, 'fff0', 'fff1').then(function(result) {
      var view = new DataView(result);
      var val = view.getUint8(0);
      chai.assert.strictEqual(val, writeValue);
      console.log('read', new Uint8Array(result));
    });
  });


  it('writeCharacteristicValue (without response)', function() {
    var buffer = new ArrayBuffer(1);
    var view = new DataView(buffer);
    view.setUint8(0, writeValue);
    return bluetoothle.writeCharacteristicValue(blueSimDevice.address, 'fff0', 'fff2', buffer);
  });


  it('readCharacteristicValue (written without response)', function() {
    return bluetoothle.readCharacteristicValue(blueSimDevice.address, 'fff0', 'fff2').then(function(result) {
      var view = new DataView(result);
      var val = view.getUint8(0);
      chai.assert.strictEqual(val, writeValue);
      console.log('read', new Uint8Array(result));
    });
  });


  it('startCharacteristicNotifications', function() {
    return bluetoothle.startCharacteristicNotifications(blueSimDevice.address, '180d', '2a37');
  });


  it('onCharacteristicValueChanged', function(done) {
    bluetoothle.on('characteristicValueChanged', function(characteristic) {
      bluetoothle.off('characteristicValueChanged');
      //console.log('characteristicValueChanged', characteristic);
      try {
        assertIsCharacteristic(characteristic);
      }
      catch(e) {
        done(e);
      }
      done();
    });
  });


  it('stopCharacteristicNotifications', function() {
    return bluetoothle.stopCharacteristicNotifications(blueSimDevice.address, '180d', '2a37');
  });


  it('on deviceDropped', function(done) {
    this.timeout(60000);

    bluetoothle.on('deviceDropped', function(device) {
      bluetoothle.off('deviceDropped');
      console.log('dropped', device);
      done();
    });

    var args = [blueSimDevice.address, 'fff0', 'fff3', ''];
    cordova.exec(function() {}, function() {}, 'BluetoothLePlugin', 'writeCharacteristicValue', args);
  });


  it('connect', function() {
    sessionStorage.setItem('device', blueSimDevice.address);
    return bluetoothle.connect(blueSimDevice.address);
  });


  it('disconnect', function() {
    return bluetoothle.disconnect(blueSimDevice.address);
  });


  //it('disconnect twice in a row', function() {
    //return bluetoothle.disconnect(blueSimDevice.address);
  //});


  describe('should clear the command queue on disconnect', function(done) {
    var count = 0;

    it('connect', function() {
      return bluetoothle.connect(blueSimDevice.address);
    });


    it('flood the command queue with writeCharacteristicValue commands', function() {
      // flood the queue with a lot of commands
      for (var i = 0; i < 10; i++) {
        var buffer = new ArrayBuffer(1);
        var view = new DataView(buffer);
        view.setUint8(0, i);
        bluetoothle.writeCharacteristicValue(blueSimDevice.address, 'fff0', 'fff1', buffer).then(function() {
          count++;
        });
      }
    });


    it ('disconnect before queue can finish', function() {
      return bluetoothle.disconnect(blueSimDevice.address);
    });


    it('connect again', function() {
      console.log('wrote ' + count + ' characteristics before disconnect');
      return bluetoothle.connect(blueSimDevice.address);
    });


    it('execute a command: getCharacteristic', function() {
      // if the queue was not emptied during the disconnect() above, this
      // will deadlock waiting on the writeCharacteristicValue commands which
      // will never complete.
      return bluetoothle.getCharacteristic(blueSimDevice.address, 'fff0', 'fff1');
    });

  });

});
