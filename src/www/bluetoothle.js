cordova.define("com.mutualmobile.cordova.bluetoothle.BluetoothLe", function(require, exports, module) {

  var PLUGIN_NAME = 'BluetoothLePlugin';
  var base64 = require('cordova/base64');

  var queue = [];
  var taskIsRunning = false;
  var processTimeout;

  // Queue all operations
  // https://stackoverflow.com/questions/18011816/has-native-android-ble-gatt-implementation-synchronous-nature
  // https://stackoverflow.com/questions/17870189/android-4-3-bluetooth-low-energy-unstable
  var processTasks = function() {
    if (!queue.length) {
      return;
    }

    if (taskIsRunning) {
      return;
    }

    taskIsRunning = true;
    var currentItem = queue.shift();

    var cancelTimeout = setTimeout(function() {
      taskIsRunning = false;
      currentItem.errback(new Error('bluetoothle.' + currentItem.name + '(' + JSON.stringify(currentItem.args) + '): did not receive a response from the native side within 5000 ms'));
      processTasks();
    }, 5000);

    processTimeout = setTimeout(function() {
      currentItem.task(
        function success() {
          clearTimeout(cancelTimeout);
          taskIsRunning = false;
          currentItem.callback.apply(this, arguments);
          processTasks();
        },
        function failure() {
          clearTimeout(cancelTimeout);
          taskIsRunning = false;
          currentItem.errback.apply(this, arguments);
          processTasks();
        }
      );
    }, 16);
  };


  var exec = function(name, args) {
    args = args || [];
    return new Promise(function(resolve, reject) {
      cordova.exec(resolve, reject, PLUGIN_NAME, name, args);
    });
  };

  var enqueue = function(name, device, args) {
    args = args || [];
    return new Promise(function(resolve, reject) {
      var task = function(callback, errback) {
        cordova.exec(callback, errback, PLUGIN_NAME, name, args);
      };

      queue.push({
        name: name,
        device: device,
        args: args,
        task: task,
        callback: resolve,
        errback: reject
      });
      processTasks();
    });
  };


  var clearQueue = function(device) {
    queue = queue.filter(function(item) {
      return item.device !== device;
    });
    taskIsRunning = false;
    if (processTimeout) {
      clearTimeout(processTimeout);
    }
    processTasks();
  };


  // iOS expects arguments as an Object (NSDictionary on the iOS side) due to
  // fitting into Objective C paradigms better (and also time constraints)
  var isIos = (navigator.userAgent.search('iPhone') !== -1) || (navigator.userAgent.search('iPad') !== -1);
  var isAndroid = (navigator.userAgent.search('Android') !== -1);


  var bluetoothle = {
    getAdapterState: function() {
      return enqueue('getAdapterState');
    },
    startDiscovery: function() {
      return exec('startDiscovery');
    },
    stopDiscovery: function() {
      return exec('stopDiscovery');
    },
    connect: function(address) {
      var args;
      if (isIos) {
        args = [{
          address: address
        }];
      }
      else {
        args = [address];
      }
      return exec('connect', args);
    },
    disconnect: function(address) {
      var args;
      if (isIos) {
        args = [{
          address: address
        }];
      }
      else {
        args = [address];
      }
      clearQueue(address);
      return exec('disconnect', args);
    },
    isConnected: function(address) {
      var args;
      if (isIos) {
        args = [{
          address: address
        }];
      }
      else {
        args = [address];
      }
      return exec('isConnected', args).then(function(result) {
        return result.isConnected;
      });
    },
    getService: function(address, serviceId) {
      var args;
      if (isIos) {
        args = [{
          address: address,
          serviceUuid: serviceId
        }];
      }
      else {
        args = [address, serviceId];
      }
      return enqueue('getService', address, args).then(function(result) {
        return Service.fromNative(result);
      });
    },
    getServices: function(address) {
      var args;
      if (isIos) {
        args = [{
          address: address
        }];
      }
      else {
        args = [address];
      }
      return enqueue('getServices', address, args).then(function(result) {
        return result.map(function(s) {
          return Service.fromNative(s);
        });
      });
    },
    getCharacteristic: function(address, serviceId, characteristicId) {
      var args;
      if (isIos) {
        args = [{
          address: address,
          serviceUuid: serviceId,
          characteristicUuid: characteristicId
        }];
      }
      else {
        args = [address, serviceId, characteristicId];
      }
      return enqueue('getCharacteristic', address, args).then(function(result) {
        return Characteristic.fromNative(result);
      });
    },
    getCharacteristics: function(address, serviceId) {
      var args;
      if (isIos) {
        args = [{
          address: address,
          serviceUuid: serviceId
        }];
      }
      else {
        args = [address, serviceId];
      }
      return enqueue('getCharacteristics', address, args).then(function(result) {
        return result.map(function(c) {
          return Characteristic.fromNative(c);
        });
      });
    },
    getDescriptor: function() {
      return enqueue('getDescriptor').then(function(result) {
        return Descriptor.fromNative(result);
      });
    },
    getDescriptors: function() {
      return enqueue('getDescriptors').then(function(result) {
        return result.map(function(d) {
          return Descriptor.fromNative(d);
        });
      });
    },
    readCharacteristicValue: function(address, serviceId, characteristicId) {
      var args;
      if (isIos) {
        args = [{
          address: address,
          serviceUuid: serviceId,
          characteristicUuid: characteristicId
        }];
      }
      else {
        args = [address, serviceId, characteristicId];
      }
      return enqueue('readCharacteristicValue', address, args).then(function(result) {
        return base64.toArrayBuffer(result);
      });
    },
    writeCharacteristicValue: function(address, serviceId, characteristicId, value) {
      var args;
      if (isIos) {
        args = [{
          address: address,
          serviceUuid: serviceId,
          characteristicUuid: characteristicId,
          value: base64.fromArrayBuffer(value)
        }];
      }
      else {
        args = [address, serviceId, characteristicId, value];
      }
      return enqueue('writeCharacteristicValue', address, args);
    },
    startCharacteristicNotifications: function(address, serviceId, characteristicId) {
      var args;
      if (isIos) {
        args = [{
          address: address,
          serviceUuid: serviceId,
          characteristicUuid: characteristicId
        }];
      }
      else {
        args = [address, serviceId, characteristicId];
      }
      return enqueue('startCharacteristicNotifications', address, args);
    },
    stopCharacteristicNotifications: function(address, serviceId, characteristicId) {
      var args;
      if (isIos) {
        args = [{
          address: address,
          serviceUuid: serviceId,
          characteristicUuid: characteristicId
        }];
      }
      else {
        args = [address, serviceId, characteristicId];
      }
      return enqueue('stopCharacteristicNotifications', address, args);
    },
    readDescriptorValue: function() {
      return enqueue('readDescriptorValue').then(function(result) {
        return Descriptor.fromNative(result);
      });
    },
    writeDescriptorValue: function() {
      return enqueue('writeDescriptorValue');
    },

    on: function(type, callback) {
      bluetoothle.callbacks[type] = bluetoothle.callbacks[type] || [];
      bluetoothle.callbacks[type].push(callback);
    },

    off: function(type, callback) {
      if (arguments.length === 0) {
        bluetoothle.callbacks = {};
      }
      else if (arguments.length === 1) {
        bluetoothle.callbacks[type] = [];
      }
      else {
        bluetoothle.callbacks[type] = bluetoothle.callbacks[type] || [];
        bluetoothle.callbacks[type] = bluetoothle.callbacks[type].filter(function(c) {
          return c !== callback;
        });
      }
    },

    trigger: function(type, args) {
      bluetoothle.callbacks[type] = bluetoothle.callbacks[type] || [];
      for (var i = 0; i < bluetoothle.callbacks[type].length; i++) {
        bluetoothle.callbacks[type][i].apply(this, args);
      }
    }
  };

  var onDeviceDropped = function(device) {
    clearQueue(device.address);
    bluetoothle.trigger('deviceDropped', [device]);
  };

  var Service = function() {};
  Service.fromNative = function(obj) {
    var s = new Service();
    for (var key in obj) {
      s[key] = obj[key];
    }
    return s;
  };


  var Characteristic = function() {};
  Characteristic.fromNative = function(obj) {
    var c = new Characteristic();
    for (var key in obj) {
      c[key] = obj[key];
    }
    if (!c.value) {
      c.value = new ArrayBuffer();
    }
    else {
      c.value = base64.toArrayBuffer(obj.value);
    }
    return c;
  };


  var Descriptor = function() {};
  Descriptor.fromNative = function(obj) {
    var c = new Descriptor();
    for (var key in obj) {
      c[key] = obj[key];
    }
    if (!c.value) {
      c.value = new ArrayBuffer();
    }
    else {
      c.value = base64.toArrayBuffer(obj.value);
    }
    return c;
  };


  // Android-specific fixes
  if (isAndroid) {
    cordova.exec.setNativeToJsBridgeMode(1);

    // observed, undocumented:
    // android.bluetooth.BluetoothGattCallback#onConnectionStateChange does not
    // seem to be accurate. I get dropped connections and failed commands
    // somewhat often unless I let connect() and disconnect() "settle" after
    // the call.
    bluetoothle.connect = function(address) {
      clearQueue(address);
      var delay = 100;

      return new Promise(function(resolve, reject) {
        exec('connect', [address]).then(function(device) {
          setTimeout(function() {
            resolve(device);
          }, delay);
        }, reject);
      });
    };

    bluetoothle.disconnect = function(address) {
      clearQueue(address);

      return new Promise(function(resolve, reject) {
        exec('disconnect', [address]).then(function(device) {
          setTimeout(function() {
            exec('_close', [address]).then(function() {
              setTimeout(function() {
                resolve(device);
              }, 1000);
            }, reject);
          }, 1000);
        }, reject);
      });
    };

    onDeviceDropped = function(device) {
      setTimeout(function() {
        exec('_close', [device.address]).then(function() {
          setTimeout(function() {
            clearQueue(device.address);
            bluetoothle.trigger('deviceDropped', [device]);
          }, 1000);
        });
      }, 1000);
    };
  }


  if (isIos) {
    var _characteristics = [];

    // iOS needs to discover characteristics separately from services. do this
    // on the js side due to greater ease of writing async code
    bluetoothle.connect = function(address) {
      _characteristics = [];

      var device;
      var delay = 100;
      var args = [{
          address: address
      }];

      return Promise.resolve()
        .then(function() {
          return new Promise(function(resolve) { setTimeout(function() { resolve(); }, delay); });
        })
        .then(function() {
          return exec('connect', args).then(function(d) {
            device = d;
          });
        })
        .then(function() {
          return new Promise(function(resolve) { setTimeout(function() { resolve(); }, delay); });
        })
        .then(function() {
          return bluetoothle.getServices(address);
        })
        .then(function(services) {
          return new Promise(function(resolve, reject) {
            var count = 0;
            services.forEach(function(s, i, list) {
              bluetoothle.getCharacteristics(address, s.uuid).then(function(characteristics) {
                _characteristics = _characteristics.concat(characteristics);
                count++;
                if (count === list.length) {
                  resolve(device);
                }
              }, reject);
            });
          });
        })
        .catch(function(err) {
          return new Promise(function(resolve, reject) {
            bluetoothle.disconnect(address).then(function() {
              reject(err);
            }, function() {
              reject(err);
            });
          });
        });
    };

    bluetoothle.disconnect = function(address) {
      clearQueue(address);
      var delay = 100;

      return new Promise(function(resolve, reject) {
        exec('disconnect', [address]).then(function(device) {
          setTimeout(function() {
            resolve(device);
          }, delay);
        }, reject);
      });
    };

    // iOS forces you to choose "write with response" or "write without
    // response". prefer "with response" if available (keep a cache of
    // _characteristics during discovery above)
    bluetoothle.writeCharacteristicValue = function(address, serviceId, characteristicId, value) {
      serviceId = getLongUUID(serviceId);
      characteristicId = getLongUUID(characteristicId);

      var args = {
        address: address,
        serviceUuid: serviceId,
        characteristicUuid: characteristicId,
        value: base64.fromArrayBuffer(value)
      };

      var characteristic = _characteristics.filter(function(c) {
        return c.uuid.toUpperCase() === characteristicId.toUpperCase();
      })[0];

      // prefer "with response" if available
      if (characteristic.properties.indexOf('write') !== -1) {
        args.withResponse = true;
      }
      else if (characteristic.properties.indexOf('writeWithoutResponse') !== -1) {
        args.withResponse = false;
      }

      return enqueue('writeCharacteristicValue', address, [args]);
    };

  }


  var getLongUUID = function(uuid) {
    if (uuid.length == 4) {
      return '0000' + uuid + '-0000-1000-8000-00805f9b34fb';
    }
    return uuid;
  };


  bluetoothle.callbacks = {};

  cordova.exec(function(device) {
    bluetoothle.trigger('deviceAdded', [device]);
    bluetoothle.trigger('deviceAdded_internal', [device]);
  }, function() {
    console.error('onDeviceAdded error', arguments);
  }, PLUGIN_NAME, 'onDeviceAdded', []);

  cordova.exec(onDeviceDropped, function() {
    console.error('onDeviceDropped error', arguments);
  }, PLUGIN_NAME, 'onDeviceDropped', []);

  cordova.exec(function(characteristic) {
    characteristic = Characteristic.fromNative(characteristic);
    bluetoothle.trigger('characteristicValueChanged', [characteristic]);
  }, function() {
    console.error('onCharacteristicValueChanged error', arguments);
  }, PLUGIN_NAME, 'onCharacteristicValueChanged', []);




  module.exports = bluetoothle;

});
