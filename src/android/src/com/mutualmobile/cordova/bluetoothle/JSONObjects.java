package com.mutualmobile.cordova.bluetoothle;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattDescriptor;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothManager;
import android.bluetooth.BluetoothProfile;
import android.util.Base64;
import android.util.Log;


public class JSONObjects {

  public static JSONObject asAdapter(BluetoothAdapter a) {
    JSONObject result = new JSONObject();
    try {
      result.put("address", a.getAddress());
      result.put("name", a.getName());
      result.put("enabled", a.isEnabled());
      result.put("discovering", a.isDiscovering());
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asDevice(BluetoothDevice device, int rssi, byte[] ad) {
    JSONObject result = new JSONObject();
    try {
      result.put("address", device.getAddress());
      result.put("name", device.getName());
      result.put("rssi", rssi);
      JSONArray uuids = new JSONArray();
      for (UUID u : parseUuids(ad)) {
        uuids.put(u);
      }
      result.put("uuids", uuids);
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }
  
  public static JSONObject asDevice(BluetoothDevice device, int rssi, JSONArray uuids) {
	    JSONObject result = new JSONObject();
	    try {
	      result.put("address", device.getAddress());
	      result.put("name", device.getName());
	      result.put("rssi", rssi);
	      result.put("uuids", uuids);
	    }
	    catch (JSONException e) {
	      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
	    }
	    return result;
	  }


  public static JSONObject asDevice(BluetoothGatt gatt, BluetoothManager manager) {
    JSONObject result = new JSONObject();
    try {
      result.put("address", gatt.getDevice().getAddress());
      result.put("name", gatt.getDevice().getName());

      JSONArray uuids = new JSONArray();
      for (BluetoothGattService service : gatt.getServices()) {
        uuids.put(service.getUuid());
      }
      result.put("uuids", uuids);

      result.put("connected", manager.getConnectionState(gatt.getDevice(), BluetoothProfile.GATT_SERVER) == BluetoothProfile.STATE_CONNECTED);
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asService(BluetoothGattService s, BluetoothDevice d) {
    JSONObject result = new JSONObject();
    try {
      result.put("uuid", s.getUuid().toString());
      result.put("isPrimary", s.getType() == BluetoothGattService.SERVICE_TYPE_PRIMARY);
      result.put("instanceId", String.valueOf(s.getInstanceId()));
      result.put("deviceAddress", d.getAddress());
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asCharacteristic(BluetoothGattCharacteristic c) {
    JSONObject result = new JSONObject();
    try {
      result.put("uuid", c.getUuid().toString());
      result.put("service", c.getService().getUuid().toString());

      JSONArray propArray = new JSONArray();
      int properties = c.getProperties();
      if ((properties & BluetoothGattCharacteristic.PROPERTY_BROADCAST) != 0) {
        propArray.put("broadcast");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_EXTENDED_PROPS) != 0) {
        propArray.put("extendedProperties");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_INDICATE) != 0) {
        propArray.put("indicate");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_NOTIFY) != 0) {
        propArray.put("notify");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_READ) != 0) {
        propArray.put("read");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_SIGNED_WRITE) != 0) {
        propArray.put("authenticatedSignedWrites");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_WRITE) != 0) {
        propArray.put("write");
      }
      if ((properties & BluetoothGattCharacteristic.PROPERTY_WRITE_NO_RESPONSE) != 0) {
        propArray.put("writeWithoutResponse");
      }
      result.put("properties", propArray);

      result.put("instanceId", c.getInstanceId());
      byte[] value = c.getValue();
      if (value == null) {
        result.put("value", null);
      }
      else {
        result.put("value", Base64.encodeToString(c.getValue(), Base64.NO_WRAP));
      }
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asDescriptor(BluetoothGattDescriptor d) {
    JSONObject result = new JSONObject();
    try {
      result.put("uuid", d.getUuid().toString());
      result.put("characteristic", d.getCharacteristic().getUuid().toString());
      result.put("value", Base64.encodeToString(d.getValue(), Base64.NO_WRAP));
    }
    catch (JSONException e) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", e);
    }
    return result;
  }


  public static JSONObject asError(Exception e) {
    JSONObject result = new JSONObject();
    try {
      result.put("message", e.getMessage());

      StringWriter sw = new StringWriter();
      e.printStackTrace(new PrintWriter(sw));
      result.put("stack", sw.toString());
    }
    catch (JSONException other) {
      Log.e("bluetoothle", "JSON Error occurred... so we can't give cordova a response in JSON.", other);
    }
    return result;
  }


  // http://stackoverflow.com/questions/18019161/startlescan-with-128-bit-uuids-doesnt-work-on-native-android-ble-implementation?noredirect=1#comment27879874_18019161
  private static List<UUID> parseUuids(byte[] advertisedData) {
    List<UUID> uuids = new ArrayList<UUID>();

    ByteBuffer buffer = ByteBuffer.wrap(advertisedData).order(ByteOrder.LITTLE_ENDIAN);
    while (buffer.remaining() > 2) {
      byte length = buffer.get();
      if (length == 0) break;

      byte type = buffer.get();
      switch (type) {
        case 0x02: // Partial list of 16-bit UUIDs
        case 0x03: // Complete list of 16-bit UUIDs
          while (length >= 2) {
            uuids.add(UUID.fromString(String.format(
                    "%08x-0000-1000-8000-00805f9b34fb", buffer.getShort())));
            length -= 2;
          }
          break;

        case 0x06: // Partial list of 128-bit UUIDs
        case 0x07: // Complete list of 128-bit UUIDs
          while (length >= 16) {
            long lsb = buffer.getLong();
            long msb = buffer.getLong();
            uuids.add(new UUID(msb, lsb));
            length -= 16;
          }
          break;

        default:
          buffer.position(buffer.position() + length - 1);
          break;
      }
    }

    return uuids;
  }


}
