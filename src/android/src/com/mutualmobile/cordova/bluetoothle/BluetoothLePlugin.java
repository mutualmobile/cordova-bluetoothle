package com.mutualmobile.cordova.bluetoothle;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCallback;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattDescriptor;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothManager;
import android.bluetooth.BluetoothProfile;
import android.content.Context;
import android.util.Base64;
import android.util.Log;

public class BluetoothLePlugin extends CordovaPlugin {

  private CallbackContext connectCallback;
  private CallbackContext disconnectCallback;
  private CallbackContext onDeviceAddedCallback;
  private CallbackContext onDeviceDroppedCallback;
  private CallbackContext onCharacteristicValueChangedCallback;
  private CallbackContext rssiCallback;
  private CallbackContext deviceInfoCallback;
  private Map<CallbackKey, CallbackContext> readWriteCallbacks;
  private Map<String, BluetoothGatt> connectedGattServers;

  //Client Configuration UUID for notifying/indicating
  private final UUID clientConfigurationDescriptorUuid = UUID.fromString("00002902-0000-1000-8000-00805f9b34fb");


  @Override
  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);
    this.connectedGattServers = new HashMap<String, BluetoothGatt>();
    this.readWriteCallbacks = new HashMap<CallbackKey, CallbackContext>();
  }


  private String getLongUUID(String uuid) {
    if (uuid.length() == 4) {
      return "0000" + uuid + "-0000-1000-8000-00805f9b34fb";
    }
    return uuid;
  }


  @Override
  public boolean execute(String action, final JSONArray args, final CallbackContext callback) throws JSONException {
    try {
      if ("getAdapterState".equals(action)) {
        getAdapterState(callback);
      }
      else if ("startDiscovery".equals(action)) {
        startDiscovery(callback);
      }
      else if ("stopDiscovery".equals(action)) {
        stopDiscovery(callback);
      }
      else if ("connect".equals(action)) {
        connect(args.getString(0), callback);
      }
      else if ("disconnect".equals(action)) {
        disconnect(args.getString(0), callback);
      }
      else if ("isConnected".equals(action)) {
        JSONObject result = new JSONObject();
        result.put("isConnected", isConnected(args.getString(0)));
        callback.success(result);
      }
      else if ("_close".equals(action)) {
        close(args.getString(0), callback);
      }
      else if ("getService".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        getService(address, serviceId, callback);
      }
      else if ("getServices".equals(action)) {
        String address = args.getString(0);
        getServices(address, callback);
      }
      else if ("getDevice".equals(action)) {
        String address = args.getString(0);
        getDeviceInfo(address, callback);
      }
      else if ("getCharacteristic".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        String characteristicId = getLongUUID(args.getString(2));
        getCharacteristic(address, serviceId, characteristicId, callback);
      }
      else if ("getCharacteristics".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        getCharacteristics(address, serviceId, callback);
      }
      else if ("getIncludedServices".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        getIncludedServices(address, serviceId, callback);
      }
      else if ("getDescriptor".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        String characteristicId = getLongUUID(args.getString(2));
        String descriptorId = getLongUUID(args.getString(3));
        getDescriptor(address, serviceId, characteristicId, descriptorId, callback);
      }
      else if ("getDescriptors".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        String characteristicId = getLongUUID(args.getString(2));
        getDescriptors(address, serviceId, characteristicId, callback);
      }
      else if ("readCharacteristicValue".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        String characteristicId = getLongUUID(args.getString(2));
        readCharacteristicValue(address, serviceId, characteristicId, callback);
      }
      else if ("writeCharacteristicValue".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        String characteristicId = getLongUUID(args.getString(2));
        byte[] value = Base64.decode(args.getString(3), Base64.NO_WRAP);
        writeCharacteristicValue(address, serviceId, characteristicId, value, callback);
      }
      else if ("startCharacteristicNotifications".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        String characteristicId = getLongUUID(args.getString(2));
        startCharacteristicNotifications(address, serviceId, characteristicId, callback);
      }
      else if ("stopCharacteristicNotifications".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        String characteristicId = getLongUUID(args.getString(2));
        stopCharacteristicNotifications(address, serviceId, characteristicId, callback);
      }
      else if ("readDescriptorValue".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        String characteristicId = getLongUUID(args.getString(2));
        String descriptorId = getLongUUID(args.getString(3));
        readDescriptorValue(address, serviceId, characteristicId, descriptorId, callback);
      }
      else if ("writeDescriptorValue".equals(action)) {
        String address = args.getString(0);
        String serviceId = getLongUUID(args.getString(1));
        String characteristicId = getLongUUID(args.getString(2));
        String descriptorId = getLongUUID(args.getString(3));
        byte[] value = Base64.decode(args.getString(3), Base64.NO_WRAP);
        writeDescriptorValue(address, serviceId, characteristicId, descriptorId, value, callback);
      }
      else if ("onDeviceAdded".equals(action)) {
        this.onDeviceAddedCallback = callback;
      }
      else if ("onDeviceDropped".equals(action)) {
        this.onDeviceDroppedCallback = callback;
      }
      else if ("onCharacteristicValueChanged".equals(action)) {
        this.onCharacteristicValueChangedCallback = callback;
      }
      else {
        return false;
      }
    }
    catch(Exception e) {
      callback.error(JSONObjects.asError(e));
    }
    return true;
  }


  private BluetoothManager getBluetoothManager() {
    return (BluetoothManager) cordova.getActivity().getSystemService(Context.BLUETOOTH_SERVICE);
  }


  private BluetoothDevice getDevice(String address) throws Exception {
    BluetoothManager bluetoothManager = (BluetoothManager) cordova.getActivity().getSystemService(Context.BLUETOOTH_SERVICE);
    BluetoothDevice device = bluetoothManager.getAdapter().getRemoteDevice(address);
    if (device == null) {
      throw new Exception("Unable to find device with address " + address);
    }
    return device;
  }

  private void getDeviceInfo(String address, CallbackContext callback) throws Exception {
	BluetoothGatt gatt = connectedGattServers.get(address);
    deviceInfoCallback = callback;
    boolean result = gatt.readRemoteRssi();

    if (!result) {
      throw new Exception("Could not initiate BluetoothGatt#readRemoteRssi. Android didn't tell us why either.");
    }
  }

  private void getAdapterState(CallbackContext callback) {
    BluetoothManager bluetoothManager = (BluetoothManager) cordova.getActivity().getSystemService(Context.BLUETOOTH_SERVICE);
    callback.success(JSONObjects.asAdapter(bluetoothManager.getAdapter()));
  }


  private BluetoothAdapter.LeScanCallback scanCallback;


  private void startDiscovery(CallbackContext callback) throws Exception {
    final Set<BluetoothDevice> foundDevices = new HashSet<BluetoothDevice>();
    if (scanCallback == null) {
      scanCallback = new BluetoothAdapter.LeScanCallback() {
        @Override
        public void onLeScan(final BluetoothDevice device, int rssi, byte[] ad) {
          foundDevices.add(device);

          JSONObject obj = JSONObjects.asDevice(device, rssi, ad);
          PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, obj);
          pluginResult.setKeepCallback(true);
          onDeviceAddedCallback.sendPluginResult(pluginResult);
        }
      };
    }

    BluetoothManager bluetoothManager = getBluetoothManager();
    boolean result = bluetoothManager.getAdapter().startLeScan(scanCallback);

    if (!result) {
      throw new Exception("Could not start scan (BluetoothAdapter#startLeScan). Android didn't tell us why either.");
    }

    callback.success();
  }


  private void stopDiscovery(CallbackContext callback) {
    BluetoothManager bluetoothManager = getBluetoothManager();
    bluetoothManager.getAdapter().stopLeScan(scanCallback);
    callback.success();
  }


  private boolean isConnected(String address) {
    BluetoothManager bluetoothManager = getBluetoothManager();
    List<BluetoothDevice> devices = bluetoothManager.getConnectedDevices(BluetoothProfile.GATT_SERVER);
    for (BluetoothDevice device : devices) {
      if (device.getAddress().equals(address)) {
        return true;
      }
    }
    return false;
  }


  private void connect(String address, CallbackContext callback) throws Exception {
    if (isConnected(address)) {
      callback.success();
      return;
    }
    connectCallback = callback;
    BluetoothDevice device = getDevice(address);
    device.connectGatt(cordova.getActivity().getApplicationContext(), false, gattCallback);
  }


  private void disconnect(String address, CallbackContext callback) throws Exception {
    if (!isConnected(address)) {
      callback.success();
      return;
    }

    disconnectCallback = callback;
    BluetoothGatt gatt = connectedGattServers.get(address);
    gatt.disconnect();
  }


  private void close(String address, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    connectedGattServers.remove(gatt.getDevice().getAddress());
    gatt.close();
    callback.success();
  }


  private void getService(String address, String uuid, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(uuid));
    if (service == null) {
      throw new Exception(String.format("No service found with the given UUID %s", uuid));
    }
    callback.success(JSONObjects.asService(service, gatt.getDevice()));
  }


  private void getServices(String address, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    JSONArray result = new JSONArray();
    for (BluetoothGattService s : gatt.getServices()) {
      result.put(JSONObjects.asService(s, gatt.getDevice()));
    }
    callback.success(result);
  }


  private void getCharacteristic(String address, String serviceId, String characteristicId, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    BluetoothGattCharacteristic characteristic = service.getCharacteristic(UUID.fromString(characteristicId));
    if (characteristic == null) {
      throw new Exception(String.format("No characteristic found with the given UUID %s", characteristicId));
    }
    callback.success(JSONObjects.asCharacteristic(characteristic));
  }


  private void getCharacteristics(String address, String serviceId, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    JSONArray result = new JSONArray();
    for (BluetoothGattCharacteristic c : service.getCharacteristics()) {
      result.put(JSONObjects.asCharacteristic(c));
    }
    callback.success(result);
  }


  private void getIncludedServices(String address, String serviceId, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    JSONArray result = new JSONArray();
    for (BluetoothGattService s : service.getIncludedServices()) {
      result.put(JSONObjects.asService(s, gatt.getDevice()));
    }
    callback.success(result);
  }


  private void getDescriptor(String address, String serviceId, String characteristicId, String descriptorId, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    BluetoothGattCharacteristic characteristic = service.getCharacteristic(UUID.fromString(characteristicId));
    BluetoothGattDescriptor descriptor = characteristic.getDescriptor(UUID.fromString(descriptorId));
    if (descriptor == null) {
      throw new Exception(String.format("No descriptor found with the given UUID %s", descriptorId));
    }
    callback.success(JSONObjects.asDescriptor(descriptor));
  }


  private void getDescriptors(String address, String serviceId, String characteristicId, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    BluetoothGattCharacteristic characteristic = service.getCharacteristic(UUID.fromString(characteristicId));
    JSONArray result = new JSONArray();
    for (BluetoothGattDescriptor d : characteristic.getDescriptors()) {
      result.put(JSONObjects.asDescriptor(d));
    }
    callback.success(result);
  }


  private void readCharacteristicValue(String address, String serviceId, String characteristicId, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    BluetoothGattCharacteristic characteristic = service.getCharacteristic(UUID.fromString(characteristicId));

    CallbackKey key = new CallbackKey(gatt, characteristic, "readCharacteristicValue");
    readWriteCallbacks.put(key, callback);

    boolean result = gatt.readCharacteristic(characteristic);
    if (!result) {
      readWriteCallbacks.remove(key);
      throw new Exception(String.format("Could not initiate characteristic read operation for %s", characteristicId));
    }
  }


  private void writeCharacteristicValue(String address, String serviceId, String characteristicId, byte[] value, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    BluetoothGattCharacteristic characteristic = service.getCharacteristic(UUID.fromString(characteristicId));

    boolean result = characteristic.setValue(value);

    if (!result) {
      throw new Exception("Could not store characteristic value");
    }

    CallbackKey key = new CallbackKey(gatt, characteristic, "writeCharacteristicValue");
    readWriteCallbacks.put(key, callback);

    if ((characteristic.getProperties() & BluetoothGattCharacteristic.PROPERTY_WRITE) != 0) {
      characteristic.setWriteType(BluetoothGattCharacteristic.WRITE_TYPE_DEFAULT);
    }
    else if ((characteristic.getProperties() & BluetoothGattCharacteristic.PROPERTY_WRITE_NO_RESPONSE) != 0) {
      characteristic.setWriteType(BluetoothGattCharacteristic.WRITE_TYPE_NO_RESPONSE);
    }

    result = gatt.writeCharacteristic(characteristic);

    if (!result) {
      readWriteCallbacks.remove(key);
      throw new Exception("Could not initiate characteristic write operation");
    }
  }


  private void startCharacteristicNotifications(String address, String serviceId, String characteristicId, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    BluetoothGattCharacteristic characteristic = service.getCharacteristic(UUID.fromString(characteristicId));
    BluetoothGattDescriptor descriptor = characteristic.getDescriptor(clientConfigurationDescriptorUuid);

    boolean result = false;

    result = gatt.setCharacteristicNotification(characteristic, true);

    if (!result) {
      throw new Exception("Could not set enable notifications/indications");
    }

    if ((characteristic.getProperties() & BluetoothGattCharacteristic.PROPERTY_NOTIFY) != 0) {
      result = descriptor.setValue(BluetoothGattDescriptor.ENABLE_NOTIFICATION_VALUE);
    }
    else if ((characteristic.getProperties() & BluetoothGattCharacteristic.PROPERTY_INDICATE) != 0) {
      result = descriptor.setValue(BluetoothGattDescriptor.ENABLE_INDICATION_VALUE);
    }
    else {
      throw new Exception("The device does not support notifications/indications on the given characteristic.");
    }

    if (!result) {
      gatt.setCharacteristicNotification(characteristic, false);
      throw new Exception("Could not store notification/indication value on the characteristic's configuration descriptor");
    }

    CallbackKey key = new CallbackKey(gatt, descriptor, "writeDescriptorValue");
    readWriteCallbacks.put(key, callback);

    result = gatt.writeDescriptor(descriptor);

    if (!result) {
      gatt.setCharacteristicNotification(characteristic, false);
      readWriteCallbacks.remove(key);
      throw new Exception("Could not initiate writing the notification/indication value on the characteristic's configuration descriptor");
    }
  }


  private void stopCharacteristicNotifications(String address, String serviceId, String characteristicId, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    BluetoothGattCharacteristic characteristic = service.getCharacteristic(UUID.fromString(characteristicId));
    BluetoothGattDescriptor descriptor = characteristic.getDescriptor(clientConfigurationDescriptorUuid);

    boolean result = false;

    result = gatt.setCharacteristicNotification(characteristic, false);

    if (!result) {
      throw new Exception("Could not disable notifications/indications");
    }

    if ((characteristic.getProperties() & BluetoothGattCharacteristic.PROPERTY_NOTIFY) != 0) {
      result = descriptor.setValue(BluetoothGattDescriptor.DISABLE_NOTIFICATION_VALUE);
    }
    else if ((characteristic.getProperties() & BluetoothGattCharacteristic.PROPERTY_INDICATE) != 0) {
      // yes, supposedly disabling "indications" is done the same as disabling "notifications"
      result = descriptor.setValue(BluetoothGattDescriptor.DISABLE_NOTIFICATION_VALUE);
    }
    else {
      throw new Exception("The device does not support notifications/indications on the given characteristic.");
    }

    if (!result) {
      throw new Exception("Could not store notification/indication value on the characteristic's configuration descriptor");
    }

    CallbackKey key = new CallbackKey(gatt, descriptor, "writeDescriptorValue");
    readWriteCallbacks.put(key, callback);

    result = gatt.writeDescriptor(descriptor);

    if (!result) {
      readWriteCallbacks.remove(key);
      throw new Exception("Could not initiate writing the notification/indication value on the characteristic's configuration descriptor");
    }
  }


  private void readDescriptorValue(String address, String serviceId, String characteristicId, String descriptorId, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    BluetoothGattCharacteristic characteristic = service.getCharacteristic(UUID.fromString(characteristicId));
    BluetoothGattDescriptor descriptor = characteristic.getDescriptor(UUID.fromString(descriptorId));

    CallbackKey key = new CallbackKey(gatt, descriptor, "readDescriptorValue");
    readWriteCallbacks.put(key, callback);

    boolean result = gatt.readDescriptor(descriptor);

    if (!result) {
      readWriteCallbacks.remove(key);
      throw new Exception("Could not initiate reading descriptor");
    }
  }

  private void writeDescriptorValue(String address, String serviceId, String characteristicId, String descriptorId, byte[] value, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    BluetoothGattService service = gatt.getService(UUID.fromString(serviceId));
    BluetoothGattCharacteristic characteristic = service.getCharacteristic(UUID.fromString(characteristicId));
    BluetoothGattDescriptor descriptor = characteristic.getDescriptor(UUID.fromString(descriptorId));

    boolean result = descriptor.setValue(value);

    if (!result) {
      throw new Exception("Could not store descriptor value");
    }

    CallbackKey key = new CallbackKey(gatt, descriptor, "writeDescriptorValue");
    readWriteCallbacks.put(key, callback);

    result = gatt.writeDescriptor(descriptor);

    if (!result) {
      readWriteCallbacks.remove(key);
      throw new Exception(String.format("Failed on BluetoothGatt#writeDescriptor for descriptor %s. Android didn't tell us why either.", descriptorId));
    }
  }


  private void getRssi(String address, CallbackContext callback) throws Exception {
    BluetoothGatt gatt = connectedGattServers.get(address);
    rssiCallback = callback;
    boolean result = gatt.readRemoteRssi();

    if (!result) {
      throw new Exception("Could not initiate BluetoothGatt#readRemoteRssi. Android didn't tell us why either.");
    }
  }


  private final BluetoothGattCallback gattCallback = new BluetoothGattCallback() {
    @Override
    public void onConnectionStateChange(BluetoothGatt gatt, int status, int newState) {
      if (newState == BluetoothProfile.STATE_CONNECTED) {
        gatt.discoverServices();
      }
      else if (newState == BluetoothProfile.STATE_DISCONNECTED) {
        if (disconnectCallback == null) {
          // the user didn't ask for a disconnect, meaning we were dropped
          //connectedGattServers.remove(gatt.getDevice().getAddress());
          //readWriteCallbacks.clear();

          Log.v("bluetoothle", onDeviceDroppedCallback.getCallbackId());
          JSONObject obj = JSONObjects.asDevice(gatt, getBluetoothManager());
          PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, obj);
          pluginResult.setKeepCallback(true);
          onDeviceDroppedCallback.sendPluginResult(pluginResult);
          return;
        }

        disconnectCallback.success(JSONObjects.asDevice(gatt, getBluetoothManager()));
        disconnectCallback = null;
      }
    }


    @Override
    public void onServicesDiscovered(BluetoothGatt gatt, int status) {
      if (status == BluetoothGatt.GATT_SUCCESS) {
        for (BluetoothGattService service : gatt.getServices()) {
          for (BluetoothGattCharacteristic characteristic : service.getCharacteristics()) {
            characteristic.getDescriptors();
          }
        }

        connectedGattServers.put(gatt.getDevice().getAddress(), gatt);
        connectCallback.success(JSONObjects.asDevice(gatt, getBluetoothManager()));
        connectCallback = null;
      }
      else {
        connectCallback.error(JSONObjects.asError(new Exception("Device discovery failed")));
      }

      connectCallback = null;
    }


    @Override
    public void onCharacteristicRead(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
      CallbackKey key = new CallbackKey(gatt, characteristic, "readCharacteristicValue");
      CallbackContext callback = readWriteCallbacks.get(key);

      if (callback == null) {
        Log.e("bluetoothle", "Characteristic " + characteristic.getUuid().toString() + " was read, but apparently nobody asked for it (no callback set)");
        return;
      }

      if (status == BluetoothGatt.GATT_SUCCESS) {
        callback.success(Base64.encodeToString(characteristic.getValue(), Base64.NO_WRAP));
      }
      else {
        callback.error(JSONObjects.asError(new Exception("Failed to read characteristic")));
      }

      readWriteCallbacks.remove(key);
    }


    @Override
    public void onCharacteristicChanged(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic) {
      if (onCharacteristicValueChangedCallback == null) {
        return;
      }

      PluginResult result = new PluginResult(PluginResult.Status.OK, JSONObjects.asCharacteristic(characteristic));
      result.setKeepCallback(true);
      onCharacteristicValueChangedCallback.sendPluginResult(result);
    }


    @Override
    public void onCharacteristicWrite(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
      CallbackKey key = new CallbackKey(gatt, characteristic, "writeCharacteristicValue");
      CallbackContext callback = readWriteCallbacks.get(key);

      if (callback == null) {
        Log.e("bluetoothle", "Characteristic " + characteristic.getUuid().toString() + " was written, but apparently nobody asked for it (no callback set)");
        return;
      }

      if (status == BluetoothGatt.GATT_SUCCESS) {
        callback.success(JSONObjects.asCharacteristic(characteristic));
      }
      else {
        callback.error(JSONObjects.asError(new Exception("Failed to write characteristic")));
      }

      readWriteCallbacks.remove(key);
    }


    @Override
    public void onDescriptorRead(BluetoothGatt gatt, BluetoothGattDescriptor descriptor, int status) {
      CallbackKey key = new CallbackKey(gatt, descriptor, "readDescriptorValue");
      CallbackContext callback = readWriteCallbacks.get(key);

      if (callback == null) {
        Log.e("bluetoothle", "Descriptor " + descriptor.getUuid().toString() + " was read, but apparently nobody asked for it (no callback set)");
        return;
      }

      if (status == BluetoothGatt.GATT_SUCCESS) {
        callback.success(JSONObjects.asDescriptor(descriptor));
      }
      else {
        callback.error(JSONObjects.asError(new Exception("Failed to read descriptor " + descriptor.getUuid().toString())));
      }

      readWriteCallbacks.remove(key);
    }


    @Override
    public void onDescriptorWrite(BluetoothGatt gatt, BluetoothGattDescriptor descriptor, int status) {
      CallbackKey key = new CallbackKey(gatt, descriptor, "writeDescriptorValue");
      CallbackContext callback = readWriteCallbacks.get(key);

      if (callback == null) {
        Log.e("bluetoothle", "Descriptor " + descriptor.getUuid().toString() + " was written, but apparently nobody asked for it (no callback set)");
        return;
      }

      if (status == BluetoothGatt.GATT_SUCCESS) {
        callback.success(JSONObjects.asDescriptor(descriptor));
      }
      else {
        callback.error(JSONObjects.asError(new Exception("Failed to write descriptor " + descriptor.getUuid().toString())));
      }

      readWriteCallbacks.remove(key);
    }


    @Override
    public void onReadRemoteRssi(BluetoothGatt gatt, int rssi, int status) {
      
      if (rssiCallback != null) {
    	  if (status == BluetoothGatt.GATT_SUCCESS) {
    	    rssiCallback.success(rssi);
    	  } else {
    	    rssiCallback.error(JSONObjects.asError(new Exception("Received an error after attempting to read RSSI for device " + gatt.getDevice().getAddress())));
    	  }
    	  rssiCallback = null;
      } else if (deviceInfoCallback != null) {
    	  if (status == BluetoothGatt.GATT_SUCCESS) {
    		JSONArray services = new JSONArray();
    	    for (BluetoothGattService s : gatt.getServices()) {
    	      services.put(JSONObjects.asService(s, gatt.getDevice()));
    	    }
    	    deviceInfoCallback.success(JSONObjects.asDevice(gatt.getDevice(), rssi, services));
    	  } else {
    	    deviceInfoCallback.error(JSONObjects.asError(new Exception("Received an error after attempting to read RSSI for device " + gatt.getDevice().getAddress())));
    	  }
    	  deviceInfoCallback = null;
      } else {
    	  return;
      }
    	
    }

  };


  // Used as keys for the `readWriteOperations` Map
  private class CallbackKey {
    private BluetoothGatt gatt;
    private Object scd; // service, characteristic, or descriptor
    private String operation;

    public CallbackKey(BluetoothGatt gatt, Object scd, String operation) {
      this.gatt = gatt;
      this.scd = scd;
      this.operation = operation;
    }

    @Override
    public int hashCode() {
      return Objects.hash(gatt, scd, operation);
    }

    @Override
    public boolean equals(Object obj) {
      if (!(obj instanceof CallbackKey)) {
        return false;
      }
      return
        Objects.equals(((CallbackKey)obj).gatt, gatt) &&
        Objects.equals(((CallbackKey)obj).scd, scd) &&
        Objects.equals(((CallbackKey)obj).operation, operation);
    }
  }


}
